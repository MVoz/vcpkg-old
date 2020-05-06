#.rst:
# .. command:: vcpkg_build_gn
#
#  Build a qmake-based project, previously configured using vcpkg_configure_qmake.
#
#  ::
#  vcpkg_build_gn()
#


function(vcpkg_build_gn)
    cmake_parse_arguments(_csc "SKIP_MAKEFILES" "BUILD_LOGNAME" "TARGETS;RELEASE_TARGETS;DEBUG_TARGETS" ${ARGN})
	
	
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
#	target_arch=x64
  else()
    set(PROJECT_ARCH "x86")
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


set GN_DEFINES=use_jumbo_build=true is_component_build=true
set GN_ARGUMENTS=--ide=vs2017 --sln=cef --filters=//cef/*


https://chromium.googlesource.com/chromium/src/+/master/docs/linux_suid_sandbox_development.md
export CHROME_DEVEL_SANDBOX=/usr/local/sbin/chrome-devel-sandbox
setting CHROME_DEVEL_SANDBOX to an empty string is equivalent to --disable-setuid-sandbox

sudo chown root:root chrome_sandbox && sudo chmod 4755 chrome_sandbox && \
    export CHROME_DEVEL_SANDBOX="$PWD/chrome_sandbox"
./chrome

Set up the Linux SUID sandbox.

# This environment variable should be set at all times.
export CHROME_DEVEL_SANDBOX=/usr/local/sbin/chrome-devel-sandbox

# This command only needs to be run a single time.
cd ~/code/chromium_git/chromium/src
sudo BUILDTYPE=Debug_GN_x64 ./build/update-linux-sandbox.sh







32-bit Build Commands

To build 32-bit CEF on a 64-bit Windows host system:

set GN_DEFINES=is_official_build=true
set GYP_MSVS_VERSION=2017
set ARCHIVE_FORMAT=tar.bz2
automate-git.py --download-dir=%download_dir% --branch=%branch% --minimal-distrib --client-distrib --force-clean

If VS2017 or SDK is not installed to the default location then set the following before executing automate-git.py:

set WIN_CUSTOM_TOOLCHAIN=1
set VCVARS=none
set GYP_MSVS_OVERRIDE_PATH=%vs_root%
set VS_CRT_ROOT=%vs_crt_root%
set SDK_ROOT=%sdk_root%
set PATH=%sdk_root%\bin\%sdk_version%\x86;%vs_root%\VC\Tools\MSVC\%vc_tools_version%\bin\HostX64\x86;%vs_root%\VC\Tools\MSVC\%vc_tools_version%\bin\HostX64\x64;%vs_root%\VC\Redist\MSVC\%vc_redist_version%\x64\%vc_redist_crt%;%vs_root%\SystemCRT;%PATH%
set LIB=%sdk_root%\Lib\%sdk_version\um\x86;%sdk_root%\Lib\%sdk_version\ucrt\x86;%vs_root%\VC\Tools\MSVC\%vc_tools_version%\lib\x86;%vs_root%\VC\Tools\MSVC\%vc_tools_version%\atlmfc\lib\x86;%LIB%
set INCLUDE=%sdk_root%\Include\%sdk_version%\um;%sdk_root%\Include\%sdk_version%\ucrt;%sdk_root%\Include\%sdk_version%\shared;%vs_root%\VC\Tools\MSVC\%vc_tools_version%\include;%vs_root%\VC\Tools\MSVC\%vc_tools_version%\atlmfc\include;%INCLUDE%

64-bit Build Commands

To build 64-bit CEF on a 64-bit Windows host system:

set GN_DEFINES=is_official_build=true
set GYP_MSVS_VERSION=2017
set ARCHIVE_FORMAT=tar.bz2
automate-git.py --download-dir=%download_dir% --branch=%branch% --minimal-distrib --client-distrib --force-clean --x64-build

If VS2017 or SDK is not installed to the default location then set the following before executing automate-git.py:

set WIN_CUSTOM_TOOLCHAIN=1
set VCVARS=none
set GYP_MSVS_OVERRIDE_PATH=%vs_root%
set VS_CRT_ROOT=%vs_crt_root%
set SDK_ROOT=%sdk_root%
set PATH=%sdk_root%\bin\%sdk_version%\x64;%vs_root%\VC\Tools\MSVC\%vc_tools_version%\bin\HostX64\x64;%vs_root%\VC\Redist\MSVC\%vc_redist_version%\x64\%vc_redist_crt%;%vs_root%\SystemCRT;%PATH%
set LIB=%sdk_root%\Lib\%sdk_version\um\x64;%sdk_root%\Lib\%sdk_version\ucrt\x64;%vs_root%\VC\Tools\MSVC\%vc_tools_version%\lib\x64;%vs_root%\VC\Tools\MSVC\%vc_tools_version%\atlmfc\lib\x64;%LIB%
set INCLUDE=%sdk_root%\Include\%sdk_version%\um;%sdk_root%\Include\%sdk_version%\ucrt;%sdk_root%\Include\%sdk_version%\shared;%vs_root%\VC\Tools\MSVC\%vc_tools_version%\include;%vs_root%\VC\Tools\MSVC\%vc_tools_version%\atlmfc\include;%INCLUDE%





VS2017 15.5.* to build 3282 branch then you must add enable_precompiled_headers=false to GN_DEFINES 

automate-git.py --download-dir=%download_dir% --branch=%branch% --minimal-distrib --client-distrib --force-clean --x64-build
export GN_DEFINES=is_official_build=true
GYP. In that case add the --no-debug-build flag 

automate-git.py --download-dir=%download_dir% --branch=%branch% --minimal-distrib --client-distrib --force-clean --build-target=cefsimple

export GN_DEFINES="is_official_build=true use_sysroot=true use_allocator=none symbol_level=1"

  # Windows style paths.
  "python_path": "src\\third_party\\python_26\\python.exe",
  "gyp_path": "src\\tools\\gyp\\gyp_main.py",
}
    "action": [Var("python_path"),
               Var("gyp_path"),


https://bitbucket.org/chromiumembedded/cef/raw/master/tools/automate/automate-git.py
python ../automate/automate-git.py --download-dir=/home/marshall/code/chromium_git --depot-tools-dir=/home/marshall/code/depot_tools --no-distrib --no-build

export GN_DEFINES=use_jumbo_build=true

DEPOT_TOOLS_UPDATE=0

if(NOT VCPKG_CMAKE_SYSTEM_NAME OR VCPKG_CMAKE_SYSTEM_NAME STREQUAL "WindowsStore")
  if(VCPKG_PLATFORM_TOOLSET MATCHES "v142")
    set(MSVS_VERSION 2017)  #they are abi compatible, so it should work
  elseif(VCPKG_PLATFORM_TOOLSET MATCHES "v141")
    set(MSVS_VERSION 2017)
  else()
    set(MSVS_VERSION 2015)
  endif()

  if(VCPKG_LIBRARY_LINKAGE STREQUAL "dynamic")
      set(LIBUSB_PROJECT_TYPE dll)
  else()
      set(LIBUSB_PROJECT_TYPE static)
  endif()
.....






    if(CMAKE_HOST_WIN32)
        set(_PATHSEP ";")
#        vcpkg_find_acquire_program(JOM)
        set(ENV{CL} /MP)
        set(INVOKE "gn.exe")
    else()
        set(_PATHSEP ":")
        find_program(MAKE make)
        set(INVOKE "gn")
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
