if(VCPKG_CMAKE_SYSTEM_NAME STREQUAL "WindowsStore")
    message(FATAL_ERROR "${PORT} does not currently support UWP")
endif()

if("wchar" IN_LIST FEATURES)
    list(APPEND ACE_FEATURE_LIST "uses_wchar=1")
endif()
if("zlib" IN_LIST FEATURES)
    list(APPEND ACE_FEATURE_LIST "zlib=1")
else()
    list(APPEND ACE_FEATURE_LIST "zlib=0")
endif()
if("ssl" IN_LIST FEATURES)
    list(APPEND ACE_FEATURE_LIST "ssl=1")
else()
    list(APPEND ACE_FEATURE_LIST "ssl=0")
endif()
list(JOIN ACE_FEATURE_LIST "," ACE_FEATURES)

if (VCPKG_LIBRARY_LINKAGE STREQUAL static)
  if(NOT VCPKG_CMAKE_SYSTEM_NAME)
    set(DLL_DECORATOR s)
  endif()
  set(MPC_STATIC_FLAG -static)
endif()
include(vcpkg_common_functions)
set(ACE_ROOT ${CURRENT_BUILDTREES_DIR}/src/ACE_wrappers)
set(ENV{ACE_ROOT} ${ACE_ROOT})
set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/ACE_wrappers/ace)
vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/DOCGroup/ACE_TAO/releases/download/ACE%2BTAO-6_5_5/ACE-src-6.5.5.zip"
    FILENAME ACE-src-6.5.5.zip
    SHA512 65696e6f2776fd9c015adb78a92f1c87edacde62ff11f20f88c416d4420a6fc6e5176412c5f93262d06e67b89717499f8108f68582f70fea6ce05466c53415e9
)
vcpkg_extract_source_archive(${ARCHIVE})

vcpkg_find_acquire_program(PERL)
get_filename_component(PERL_PATH ${PERL} DIRECTORY)
vcpkg_add_to_path(${PERL_PATH})

if (TRIPLET_SYSTEM_ARCH MATCHES "arm")
    message(FATAL_ERROR "ARM is currently not supported.")
elseif (TRIPLET_SYSTEM_ARCH MATCHES "x86")
    set(MSBUILD_PLATFORM "Win32")
else ()
    set(MSBUILD_PLATFORM ${TRIPLET_SYSTEM_ARCH})
endif()

# Add ace/config.h file
# see https://htmlpreview.github.io/?https://github.com/DOCGroup/ACE_TAO/blob/master/ACE/ACE-INSTALL.html
if(NOT VCPKG_CMAKE_SYSTEM_NAME)
  set(LIB_RELEASE_SUFFIX .lib)
  set(LIB_DEBUG_SUFFIX d.lib)
  if(VCPKG_PLATFORM_TOOLSET MATCHES "v142")
    set(SOLUTION_TYPE vs2019)
  elseif(VCPKG_PLATFORM_TOOLSET MATCHES "v141")
    set(SOLUTION_TYPE vs2017)
  else()
    set(SOLUTION_TYPE vc14)
  endif()
  file(WRITE ${SOURCE_PATH}/config.h "#include \"ace/config-windows.h\"")
endif()

if(VCPKG_CMAKE_SYSTEM_NAME STREQUAL "Linux")
  set(DLL_DECORATOR)
  set(LIB_RELEASE_SUFFIX .a)
  set(LIB_DEBUG_SUFFIX .a)
  set(LIB_PREFIX lib)
  set(SOLUTION_TYPE gnuace)
  file(WRITE ${SOURCE_PATH}/config.h "#include \"ace/config-linux.h\"")
  file(WRITE ${ACE_ROOT}/include/makeinclude/platform_macros.GNU "include $(ACE_ROOT)include/makeinclude/platform_linux.GNU")
endif()

# Invoke mwc.pl to generate the necessary solution and project files
vcpkg_execute_required_process(
    COMMAND ${PERL} ${ACE_ROOT}/bin/mwc.pl -type ${SOLUTION_TYPE} -features "${ACE_FEATURES}" ace ${MPC_STATIC_FLAG}
    WORKING_DIRECTORY ${ACE_ROOT}
    LOGNAME mwc-${TARGET_TRIPLET}
)

if(NOT VCPKG_CMAKE_SYSTEM_NAME)
  vcpkg_build_msbuild(
    PROJECT_PATH ${SOURCE_PATH}/ace.sln
    PLATFORM ${MSBUILD_PLATFORM}
    USE_VCPKG_INTEGRATION
  )
endif()

if(VCPKG_CMAKE_SYSTEM_NAME STREQUAL "Linux")
  FIND_PROGRAM(MAKE make)
  IF (NOT MAKE)
    MESSAGE(FATAL_ERROR "MAKE not found")
  ENDIF ()
  vcpkg_execute_required_process(
    COMMAND make
    WORKING_DIRECTORY ${ACE_ROOT}/ace
    LOGNAME make-${TARGET_TRIPLET}
  )
endif()

# ACE itself does not define an install target, so it is not clear which
# headers are public and which not. For the moment we install everything
# that is in the source path and ends in .h, .inl
function(install_ace_headers_subdirectory SOURCE_PATH RELATIVE_PATH)
    file(GLOB HEADER_FILES ${SOURCE_PATH}/${RELATIVE_PATH}/*.h ${SOURCE_PATH}/${RELATIVE_PATH}/*.inl)
    file(INSTALL ${HEADER_FILES} DESTINATION ${CURRENT_PACKAGES_DIR}/include/ace/${RELATIVE_PATH})
endfunction()

# We manually install header found in the ace directory because in that case
# we are supposed to install also *cpp files, see ACE_wrappers\debian\libace-dev.install file
file(GLOB HEADER_FILES ${SOURCE_PATH}/*.h ${SOURCE_PATH}/*.inl ${SOURCE_PATH}/*.cpp)
file(INSTALL ${HEADER_FILES} DESTINATION ${CURRENT_PACKAGES_DIR}/include/ace/)

# Install headers in subdirectory
install_ace_headers_subdirectory(${SOURCE_PATH} "Compression")
install_ace_headers_subdirectory(${SOURCE_PATH} "Compression/rle")
install_ace_headers_subdirectory(${SOURCE_PATH} "ETCL")
install_ace_headers_subdirectory(${SOURCE_PATH} "QoS")
install_ace_headers_subdirectory(${SOURCE_PATH} "Monitor_Control")
install_ace_headers_subdirectory(${SOURCE_PATH} "os_include")
install_ace_headers_subdirectory(${SOURCE_PATH} "os_include/arpa")
install_ace_headers_subdirectory(${SOURCE_PATH} "os_include/net")
install_ace_headers_subdirectory(${SOURCE_PATH} "os_include/netinet")
install_ace_headers_subdirectory(${SOURCE_PATH} "os_include/sys")
if("ssl" IN_LIST FEATURES)
    install_ace_headers_subdirectory(${SOURCE_PATH} "SSL")
endif()

# Install the libraries
function(install_ace_library SOURCE_PATH ACE_LIBRARY)
    set(LIB_PATH ${SOURCE_PATH}/lib/)
    if (VCPKG_LIBRARY_LINKAGE STREQUAL dynamic)
        # Install the DLL files
        file(INSTALL
            ${LIB_PATH}/${ACE_LIBRARY}d.dll
            DESTINATION ${CURRENT_PACKAGES_DIR}/debug/bin
        )
        file(INSTALL
            ${LIB_PATH}/${ACE_LIBRARY}.dll
            DESTINATION ${CURRENT_PACKAGES_DIR}/bin
        )
    endif()

    # Install the lib files
    file(INSTALL
        ${LIB_PATH}/${LIB_PREFIX}${ACE_LIBRARY}${DLL_DECORATOR}${LIB_DEBUG_SUFFIX}
        DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib
    )

    file(INSTALL
        ${LIB_PATH}/${LIB_PREFIX}${ACE_LIBRARY}${DLL_DECORATOR}${LIB_RELEASE_SUFFIX}
        DESTINATION ${CURRENT_PACKAGES_DIR}/lib
    )
endfunction()

install_ace_library(${ACE_ROOT} "ACE")
install_ace_library(${ACE_ROOT} "ACE_Compression")
install_ace_library(${ACE_ROOT} "ACE_ETCL")
install_ace_library(${ACE_ROOT} "ACE_ETCL_Parser")
install_ace_library(${ACE_ROOT} "ACE_Monitor_Control")
if(NOT VCPKG_CMAKE_SYSTEM_NAME)
  install_ace_library(${ACE_ROOT} "ACE_QoS")
endif()
install_ace_library(${ACE_ROOT} "ACE_RLECompression")
if("ssl" IN_LIST FEATURES)
    install_ace_library(${ACE_ROOT} "ACE_SSL")
endif()

# Handle copyright
file(COPY ${ACE_ROOT}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/ace)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/ace/COPYING ${CURRENT_PACKAGES_DIR}/share/ace/copyright)

vcpkg_copy_pdbs()
