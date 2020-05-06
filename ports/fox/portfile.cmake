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

find_package(Git QUIET)

set(GIT_URL "https://github.com/zenotech/fox-toolkit.git")
set(GIT_REV "master")
set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/fox-1.6.54)

if(NOT EXISTS "${SOURCE_PATH}/.git")
	message(STATUS "Cloning")
	set(error_code 1)
	set(number_of_tries 0)
	while(error_code AND number_of_tries LESS 3)
		execute_process(
		COMMAND ${GIT} clone --recurse-submodules -q --branch=master --progress ${GIT_URL} ${SOURCE_PATH}
		WORKING_DIRECTORY ${SOURCE_PATH}
		RESULT_VARIABLE error_code
	)
	math(EXPR number_of_tries "${number_of_tries} + 1")
	endwhile()
	if(number_of_tries GREATER 1)
		message(STATUS "Had to git clone more than once:	${number_of_tries} times.")
	endif()
	if(error_code)
		message(FATAL_ERROR "Failed to clone repository: '${GIT_URL}'")
	endif()
endif()

#vcpkg_configure_cmake(
#	-D_CRT_SECURE_NO_WARNINGS
#    SOURCE_PATH ${SOURCE_PATH}
#    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    # OPTIONS -DUSE_THIS_IN_ALL_BUILDS=1 -DUSE_THIS_TOO=2
    # OPTIONS_RELEASE -DOPTIMIZE=1
    # OPTIONS_DEBUG -DDEBUGGABLE=1
#)

vcpkg_build_msbuild(
    PROJECT_PATH ${SOURCE_PATH}/windows/vcpp/win32.sln
	SOURCE_PATH ${SOURCE_PATH}
#	${CURRENT_BUILDTREES_DIR}/${}
#    [RELEASE_CONFIGURATION <Release>]
#    [DEBUG_CONFIGURATION <Debug>]
#    [TARGET <Build>]
#    [TARGET_PLATFORM_VERSION <10.0.15063.0>]
#    [PLATFORM <${TRIPLET_SYSTEM_ARCH}>]
#    [PLATFORM_TOOLSET <${VCPKG_PLATFORM_TOOLSET}>]
#    [OPTIONS </p:ZLIB_INCLUDE_PATH=X>...]
#    [OPTIONS_RELEASE </p:ZLIB_LIB=X>...]
#    [OPTIONS_DEBUG </p:ZLIB_LIB=X>...]
#    [USE_VCPKG_INTEGRATION]
    TARGET fox
#	PLATFORM x86
)

vcpkg_install_cmake()

# Handle copyright
# file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/fox RENAME copyright)

# Post-build test for cmake libraries
# ## ### vcpkg_test_cmake(PACKAGE_NAME fox)
