# Common Ambient Variables:
#   CURRENT_BUILDTREES_DIR    = ${VCPKG_ROOT_DIR}\buildtrees\${PORT}
#   CURRENT_PACKAGES_DIR      = ${VCPKG_ROOT_DIR}\packages\${PORT}_${TARGET_TRIPLET}
#   CURRENT_PORT_DIR          = ${VCPKG_ROOT_DIR}\ports\${PORT}
#   PORT                      = current port name (zlib, etc)
#   TARGET_TRIPLET            = current triplet (x86-windows, x64-windows-static, etc)
#   VCPKG_CRT_LINKAGE         = C runtime linkage type (static, dynamic)
#   VCPKG_LIBRARY_LINKAGE     = target library linkage type (static, dynamic)
#   VCPKG_ROOT_DIR            = <C:\path\to\current\vcpkg>
#   VCPKG_TARGET_ARCHITECTURE = target architecture (x64, x86, arm)
#

include(vcpkg_common_functions)

if(VCPKG_CMAKE_SYSTEM_NAME OR VCPKG_CMAKE_SYSTEM_NAME STREQUAL "WindowsStore")
	message(FATAL_ERROR "\n-- Build port ${PORT} only supported Windows Desktop")
endif()

if(VCPKG_LIBRARY_LINKAGE STREQUAL "dynamic")
    message(STATUS "\n-- Current ${PORT} port only supports static library linkage"
	"\n-- Building static library ...\n"
	)
#    set(VCPKG_LIBRARY_LINKAGE "dynamic")
endif()

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/Voskrese/libdnet/archive/libdnet-1.11.zip"
    FILENAME "libdnet-1.11.zip"
    SHA512 0988f5589a8f7fda5b48460b2844a20306823acca925b685a82678995dc991f21e361bfec45a3683cfd340bf562430af3071190cd08508859b423ffb0f4ebe4b
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE} 
    # (Optional) A friendly name to use instead of the filename of the archive (e.g.: a version number or tag).
    # REF 1.0.0
    # (Optional) Read the docs for how to generate patches at: 
    # https://github.com/Microsoft/vcpkg/blob/master/docs/examples/patching.md
    # PATCHES
    #   001_port_fixes.patch
    #   002_more_port_fixes.patch
)

if(VCPKG_LIBRARY_LINKAGE STREQUAL dynamic)
	vcpkg_install_msbuild(
		CURRENT_BUILDTREES_DIR ${SOURCE_PATH}
		SOURCE_PATH ${SOURCE_PATH}
		CURRENT_INSTALLED_DIR ${CURRENT_INSTALLED_DIR}
		PROJECT_SUBPATH libdnet.vcxproj
		OPTIONS
			/p:ConfigurationType=StaticLibrary
			/p:OutputType=Library
		OPTIONS_RELEASE
			/p:BuildInParallel=true
			/p:DisabledWarnings=MSB4011
			/p:ErrorReport=none
			/p:Utf8Output=true
			/p:WarningsNotAsErrors=true
			
		OPTIONS_DEBUG
			/p:BuildInParallel=true
			/p:DisabledWarnings=MSB4011
			/p:ErrorReport=none
			/p:Utf8Output=true
			/p:WarningsNotAsErrors=true
			
		USE_VCPKG_INTEGRATION
		ALLOW_ROOT_INCLUDES
)
elseif(VCPKG_LIBRARY_LINKAGE STREQUAL static)
	vcpkg_install_msbuild(
		CURRENT_BUILDTREES_DIR ${SOURCE_PATH}
		SOURCE_PATH ${SOURCE_PATH}
		CURRENT_INSTALLED_DIR ${CURRENT_INSTALLED_DIR}
		PROJECT_SUBPATH libdnet.vcxproj
		OPTIONS
			/p:ConfigurationType=StaticLibrary
			/p:OutputType=Library
		OPTIONS_RELEASE 
			/p:RuntimeLibrary=MultiThreaded
			/p:BuildInParallel=true
			/p:OutputType=Library
#			/p:Platform=x86
			
		OPTIONS_DEBUG 
			/p:ConfigurationType=StaticLibrary
			/p:RuntimeLibrary=MultiThreadedDebug
			/p:BuildInParallel=true
#			/p:Platform=x86

		USE_VCPKG_INTEGRATION
		ALLOW_ROOT_INCLUDES
)
endif()

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

# Handle headers
file(COPY ${SOURCE_PATH}/include/dnet.h DESTINATION ${CURRENT_PACKAGES_DIR}/include)
file(COPY ${SOURCE_PATH}/include/dnet DESTINATION ${CURRENT_PACKAGES_DIR}/include FILES_MATCHING PATTERN *.h)

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/libdnet RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME libdnet)
