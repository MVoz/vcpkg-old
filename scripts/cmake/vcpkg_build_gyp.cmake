#.rst:
# .. command:: vcpkg_build_gyp
#
#  Build a qmake-based project, previously configured using vcpkg_configure_qmake.
#
#  ::
#  vcpkg_build_gyp()
#

# Determine the platform.
if("${CMAKE_SYSTEM_NAME}" STREQUAL "Darwin")
  set(OS_MACOSX 1)
  set(OS_POSIX 1)
elseif("${CMAKE_SYSTEM_NAME}" STREQUAL "Linux")
  set(OS_LINUX 1)
  set(OS_POSIX 1)
elseif("${CMAKE_SYSTEM_NAME}" STREQUAL "Windows")
  set(OS_WINDOWS 1)
endif()

# Determine the project architecture.
if(NOT DEFINED PROJECT_ARCH)
  if(CMAKE_SIZEOF_VOID_P MATCHES 8)
    set(PROJECT_ARCH "x86_64")
  else()
    set(PROJECT_ARCH "x86")
  endif()
endif()

if(${CMAKE_GENERATOR} STREQUAL "Ninja")
  set(GEN_NINJA 1)
elseif(${CMAKE_GENERATOR} STREQUAL "Unix Makefiles")
  set(GEN_MAKEFILES 1)
endif()

# Determine the build type.
if(NOT CMAKE_BUILD_TYPE AND (GEN_NINJA OR GEN_MAKEFILES))
  # CMAKE_BUILD_TYPE should be specified when using Ninja or Unix Makefiles.
  set(CMAKE_BUILD_TYPE Release)
  message(WARNING "No CMAKE_BUILD_TYPE value selected, using ${CMAKE_BUILD_TYPE}")
endif()

# Configure use of the sandbox.
option(USE_SANDBOX "Enable or disable use of the sandbox." OFF)

if(OS_WINDOWS)
  if (GEN_NINJA)
    # When using the Ninja generator clear the CMake defaults to avoid excessive
    # console warnings (see issue #2120).
    set(CMAKE_CXX_FLAGS "")
    set(CMAKE_CXX_FLAGS_DEBUG "")
    set(CMAKE_CXX_FLAGS_RELEASE "")
  endif()

  if(USE_SANDBOX)
    # Check if the current MSVC version is compatible with the sandbox.lib
    # static library. For a list of all version numbers see
    # https://en.wikipedia.org/wiki/Microsoft_Visual_C%2B%2B#Internal_version_numbering
    list(APPEND supported_msvc_versions
      1900  # VS2015 and updates 1, 2, & 3
      1910  # VS2017 version 15.1 & 15.2
      1911  # VS2017 version 15.3 & 15.4
      1912  # VS2017 version 15.5
      1913  # VS2017 version 15.6
      1914  # VS2017 version 15.7
      1915  # VS2017 version 15.8
      1916  # VS2017 version 15.9
      1920  # VS2019 version 16.0
      1921  # VS2018 version 16.1
      )
    list(FIND supported_msvc_versions ${MSVC_VERSION} _index)
    if (${_index} EQUAL -1)
      message(WARNING "CEF sandbox is not compatible with the current MSVC version (${MSVC_VERSION})")
      set(USE_SANDBOX OFF)
    endif()
  endif()

  # Consumers who run into LNK4099 warnings can pass /Z7 instead (see issue #385).
  set(DEBUG_INFO_FLAG "/Zi" CACHE STRING "Optional flag specifying specific /Z flag to use")

  # Consumers using different runtime types may want to pass different flags
  set(RUNTIME_LIBRARY_FLAG "/MT" CACHE STRING "Optional flag specifying which runtime to use")
  if (RUNTIME_LIBRARY_FLAG)
    list(APPEND COMPILER_FLAGS_DEBUG ${RUNTIME_LIBRARY_FLAG}d)
    list(APPEND COMPILER_FLAGS_RELEASE ${RUNTIME_LIBRARY_FLAG})
  endif()

  # Platform-specific compiler/linker flags.
  set(LIBTYPE STATIC)
  list(APPEND COMPILER_FLAGS
    /MP           # Multiprocess compilation
    /Gy           # Enable function-level linking
    /GR-          # Disable run-time type information
    /W4           # Warning level 4
    /WX-           # Treat warnings as errors
    /wd4100       # Ignore "unreferenced formal parameter" warning
    /wd4127       # Ignore "conditional expression is constant" warning
    /wd4244       # Ignore "conversion possible loss of data" warning
    /wd4481       # Ignore "nonstandard extension used: override" warning
    /wd4512       # Ignore "assignment operator could not be generated" warning
    /wd4701       # Ignore "potentially uninitialized local variable" warning
    /wd4702       # Ignore "unreachable code" warning
    /wd4996       # Ignore "function or variable may be unsafe" warning
    ${DEBUG_INFO_FLAG}
    )
  list(APPEND COMPILER_FLAGS_DEBUG
    /RTC1         # Disable optimizations
    /Od           # Enable basic run-time checks
    )
  list(APPEND COMPILER_FLAGS_RELEASE
    /O2           # Optimize for maximum speed
    /Ob2          # Inline any suitable function
    /GF           # Enable string pooling
    )
  list(APPEND LINKER_FLAGS_DEBUG
    /DEBUG        # Generate debug information
    )
  list(APPEND EXE_LINKER_FLAGS
    /MANIFEST:NO        # No default manifest (see ADD_WINDOWS_MANIFEST macro usage)
    /LARGEADDRESSAWARE  # Allow 32-bit processes to access 3GB of RAM
    )
  list(APPEND COMPILER_DEFINES
    WIN32 _WIN32 _WINDOWS             # Windows platform
    UNICODE _UNICODE                  # Unicode build
    WINVER=0x0601 _WIN32_WINNT=0x601  # Targeting Windows 7
    NOMINMAX                          # Use the standard's templated min/max
    WIN32_LEAN_AND_MEAN               # Exclude less common API declarations
    _HAS_EXCEPTIONS=0                 # Disable exceptions
    )
  list(APPEND COMPILER_DEFINES_RELEASE
    NDEBUG _NDEBUG                    # Not a debug build
    )

  # Standard libraries.
  set(STANDARD_LIBS
    comctl32.lib
    rpcrt4.lib
    shlwapi.lib
    ws2_32.lib
    )

  if(USE_SANDBOX)
    list(APPEND COMPILER_DEFINES
      PSAPI_VERSION=1   # Required by sandbox.lib
      USE_SANDBOX   # Used by apps to test if the sandbox is enabled
      )

    # Libraries required by sandbox.lib.
    set(SANDBOX_STANDARD_LIBS
      dbghelp.lib
      psapi.lib
      version.lib
      wbemuuid.lib
      winmm.lib
      )

    # CEF sandbox library paths.
    set(SANDBOX_LIB_DEBUG "${BINARY_DIR_DEBUG}/sandbox.lib")
    set(SANDBOX_LIB_RELEASE "${BINARY_DIR_RELEASE}/sandbox.lib")
  endif()

  # Configure use of ATL.
  option(USE_ATL "Enable or disable use of ATL." ON)
  if(USE_ATL)
    # Locate the atlmfc directory if it exists. It may be at any depth inside
    # the VC directory. The cl.exe path returned by CMAKE_CXX_COMPILER may also
    # be at different depths depending on the toolchain version
    # (e.g. "VC/bin/cl.exe", "VC/bin/amd64_x86/cl.exe",
    # "VC/Tools/MSVC/14.10.25017/bin/HostX86/x86/cl.exe", etc).
    set(HAS_ATLMFC 0)
    get_filename_component(VC_DIR ${CMAKE_CXX_COMPILER} DIRECTORY)
    get_filename_component(VC_DIR_NAME ${VC_DIR} NAME)
    while(NOT ${VC_DIR_NAME} STREQUAL "VC")
      get_filename_component(VC_DIR ${VC_DIR} DIRECTORY)
      if(IS_DIRECTORY "${VC_DIR}/atlmfc")
        set(HAS_ATLMFC 1)
        break()
      endif()
      get_filename_component(VC_DIR_NAME ${VC_DIR} NAME)
    endwhile()

    # Determine if the Visual Studio install supports ATL.
    if(NOT HAS_ATLMFC)
      message(WARNING "ATL is not supported by your VC installation.")
      set(USE_ATL OFF)
    endif()
  endif()

  if(USE_ATL)
    list(APPEND COMPILER_DEFINES
      USE_ATL   # Used by apps to test if ATL support is enabled
      )
  endif()
endif()



#
# Linux macros.
#

if(OS_LINUX)

# Use pkg-config to find Linux libraries and update compiler/linker variables.
macro(FIND_LINUX_LIBRARIES libraries)
  # Read pkg-config info into variables.
  execute_process(COMMAND pkg-config --cflags ${libraries} OUTPUT_VARIABLE FLL_CFLAGS)
  execute_process(COMMAND pkg-config --libs-only-L --libs-only-other ${libraries} OUTPUT_VARIABLE FLL_LDFLAGS)
  execute_process(COMMAND pkg-config --libs-only-l ${libraries} OUTPUT_VARIABLE FLL_LIBS)

  # Strip leading and trailing whitepspace.
  STRING(STRIP "${FLL_CFLAGS}"  FLL_CFLAGS)
  STRING(STRIP "${FLL_LDFLAGS}" FLL_LDFLAGS)
  STRING(STRIP "${FLL_LIBS}"    FLL_LIBS)

  # Convert to a list.
  separate_arguments(FLL_CFLAGS)
  separate_arguments(FLL_LDFLAGS)
  separate_arguments(FLL_LIBS)

  # Update build variables.
  list(APPEND C_COMPILER_FLAGS    ${FLL_CFLAGS})
  list(APPEND CXX_COMPILER_FLAGS  ${FLL_CFLAGS})
  list(APPEND EXE_LINKER_FLAGS    ${FLL_LDFLAGS})
  list(APPEND SHARED_LINKER_FLAGS ${FLL_LDFLAGS})
  list(APPEND STANDARD_LIBS       ${FLL_LIBS})
endmacro()

# Set SUID permissions on the specified executable.
macro(SET_LINUX_SUID_PERMISSIONS target executable)
  add_custom_command(
    TARGET ${target}
    POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E echo ""
    COMMAND ${CMAKE_COMMAND} -E echo "*** Run the following command manually to set SUID permissions ***"
    COMMAND ${CMAKE_COMMAND} -E echo "EXE=\"${executable}\" && sudo -- chown root:root $EXE && sudo -- chmod 4755 $EXE"
    COMMAND ${CMAKE_COMMAND} -E echo ""
    VERBATIM
    )
endmacro()

endif(OS_LINUX)
#
# Windows macros.
#

if(OS_WINDOWS)

# Add custom manifest files to an executable target.
macro(ADD_WINDOWS_MANIFEST manifest_path target extension)
  add_custom_command(
    TARGET ${target}
    POST_BUILD
    COMMAND "mt.exe" -nologo
            -manifest \"${manifest_path}/${target}.${extension}.manifest\" \"${manifest_path}/compatibility.manifest\"
            -outputresource:"${TARGET_OUT_DIR}/${target}.${extension}"\;\#1
    COMMENT "Adding manifest..."
    )
endmacro()

endif(OS_WINDOWS)





















function(vcpkg_build_gyp)
    cmake_parse_arguments(_csc "SKIP_MAKEFILES" "BUILD_LOGNAME" "TARGETS;RELEASE_TARGETS;DEBUG_TARGETS" ${ARGN})

    if(CMAKE_HOST_WIN32)
        set(_PATHSEP ";")
#        vcpkg_find_acquire_program(JOM)
        set(ENV{CL} /MP)
        set(INVOKE "nmake")
    else()
        set(_PATHSEP ":")
        find_program(MAKE make)
        set(INVOKE "${MAKE}")
    endif()

    # Make sure that the linker finds the libraries used 
    set(ENV_PATH_BACKUP "$ENV{PATH}")
    
    if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "debug")
        set(DEBUG_DIR ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg)
    endif()
    if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "release")
        set(RELEASE_DIR ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel)
    endif()

    file(TO_NATIVE_PATH "${CURRENT_INSTALLED_DIR}" NATIVE_INSTALLED_DIR)

    if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "release")
        list(APPEND _csc_RELEASE_TARGETS ${_csc_TARGETS})
    endif()
    if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "debug")
        list(APPEND _csc_DEBUG_TARGETS ${_csc_TARGETS})
    endif()

    if(NOT _csc_BUILD_LOGNAME)
        set(_csc_BUILD_LOGNAME build)
    endif()

    function(run_jom TARGETS LOG_PREFIX LOG_SUFFIX)
        message(STATUS "Package ${LOG_PREFIX}-${TARGET_TRIPLET}-${LOG_SUFFIX}")
        vcpkg_execute_required_process(
            COMMAND ${INVOKE} ${TARGETS}
            WORKING_DIRECTORY ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-${LOG_SUFFIX}
            LOGNAME package-${LOG_PREFIX}-${TARGET_TRIPLET}-${LOG_SUFFIX}
        )
    endfunction()

    # This fixes issues on machines with default codepages that are not ASCII compatible, such as some CJK encodings
    set(ENV_CL_BACKUP "$ENV{_CL_}")
    set(ENV{_CL_} "/utf-8")

    #First generate the makefiles so we can modify them
    if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "debug")
        set(ENV{PATH} "${CURRENT_INSTALLED_DIR}/debug/lib${_PATHSEP}${CURRENT_INSTALLED_DIR}/debug/bin${_PATHSEP}${CURRENT_INSTALLED_DIR}/tools/qt5${_PATHSEP}${ENV_PATH_BACKUP}")
        if(NOT _csc_SKIP_MAKEFILES)
            run_jom(qmake_all makefiles dbg)

            #Store debug makefiles path
            file(GLOB_RECURSE DEBUG_MAKEFILES ${DEBUG_DIR}/*Makefile*)

            foreach(DEBUG_MAKEFILE ${DEBUG_MAKEFILES})
                file(READ "${DEBUG_MAKEFILE}" _contents)
                string(REPLACE "zlib.lib" "zlibd.lib" _contents "${_contents}")
                string(REPLACE "installed\\${TARGET_TRIPLET}\\lib" "installed\\${TARGET_TRIPLET}\\debug\\lib" _contents "${_contents}")
                string(REPLACE "/LIBPATH:${NATIVE_INSTALLED_DIR}\\debug\\lib" "/LIBPATH:${NATIVE_INSTALLED_DIR}\\debug\\lib\\manual-link /LIBPATH:${NATIVE_INSTALLED_DIR}\\debug\\lib shell32.lib" _contents "${_contents}")
                string(REPLACE "tools\\qt5\\qmlcachegen.exe" "tools\\qt5-declarative\\qmlcachegen.exe" _contents "${_contents}")
                string(REPLACE "tools/qt5/qmlcachegen" "tools/qt5-declarative/qmlcachegen" _contents "${_contents}")
                string(REPLACE "debug\\lib\\Qt5Bootstrap.lib" "tools\\qt5\\Qt5Bootstrap.lib" _contents "${_contents}")
                string(REPLACE "lib\\Qt5Bootstrap.lib" "tools\\qt5\\Qt5Bootstrap.lib" _contents "${_contents}")
                string(REPLACE " Qt5Bootstrap.lib " " ${NATIVE_INSTALLED_DIR}\\tools\\qt5\\Qt5Bootstrap.lib Ole32.lib Netapi32.lib Advapi32.lib ${NATIVE_INSTALLED_DIR}\\lib\\zlib.lib Shell32.lib " _contents "${_contents}")
                file(WRITE "${DEBUG_MAKEFILE}" "${_contents}")
            endforeach()
        endif()

        run_jom("${_csc_DEBUG_TARGETS}" ${_csc_BUILD_LOGNAME} dbg)
    endif()

    if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "release")
        set(ENV{PATH} "${CURRENT_INSTALLED_DIR}/lib${_PATHSEP}${CURRENT_INSTALLED_DIR}/bin${_PATHSEP}${CURRENT_INSTALLED_DIR}/tools/qt5${_PATHSEP}${ENV_PATH_BACKUP}")
        if(NOT _csc_SKIP_MAKEFILES)
            run_jom(qmake_all makefiles rel)

            #Store release makefile path
            file(GLOB_RECURSE RELEASE_MAKEFILES ${RELEASE_DIR}/*Makefile*)

            foreach(RELEASE_MAKEFILE ${RELEASE_MAKEFILES})
                file(READ "${RELEASE_MAKEFILE}" _contents)
                string(REPLACE "/LIBPATH:${NATIVE_INSTALLED_DIR}\\lib" "/LIBPATH:${NATIVE_INSTALLED_DIR}\\lib\\manual-link /LIBPATH:${NATIVE_INSTALLED_DIR}\\lib shell32.lib" _contents "${_contents}")
                string(REPLACE "tools\\qt5\\qmlcachegen.exe" "tools\\qt5-declarative\\qmlcachegen.exe" _contents "${_contents}")
                string(REPLACE "tools/qt5/qmlcachegen" "tools/qt5-declarative/qmlcachegen" _contents "${_contents}")
                string(REPLACE "debug\\lib\\Qt5Bootstrap.lib" "tools\\qt5\\Qt5Bootstrap.lib" _contents "${_contents}")
                string(REPLACE "lib\\Qt5Bootstrap.lib" "tools\\qt5\\Qt5Bootstrap.lib" _contents "${_contents}")
                string(REPLACE " Qt5Bootstrap.lib " " ${NATIVE_INSTALLED_DIR}\\tools\\qt5\\Qt5Bootstrap.lib Ole32.lib Netapi32.lib Advapi32.lib ${NATIVE_INSTALLED_DIR}\\lib\\zlib.lib Shell32.lib " _contents "${_contents}")
                file(WRITE "${RELEASE_MAKEFILE}" "${_contents}")
            endforeach()
        endif()

        run_jom("${_csc_RELEASE_TARGETS}" ${_csc_BUILD_LOGNAME} rel)
    endif()
    
    # Restore the original value of ENV{PATH}
    set(ENV{PATH} "${ENV_PATH_BACKUP}")
    set(ENV{_CL_} "${ENV_CL_BACKUP}")
endfunction()
