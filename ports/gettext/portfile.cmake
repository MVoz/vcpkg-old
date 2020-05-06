
#Based on https://github.com/winlibs/gettext

include(vcpkg_common_functions)

set(GETTEXT_VERSION 0.19.7)

vcpkg_download_distfile(ARCHIVE
    URLS "https://ftp.gnu.org/pub/gnu/gettext/gettext-${GETTEXT_VERSION}.tar.gz" "https://www.mirrorservice.org/sites/ftp.gnu.org/gnu/gettext/gettext-${GETTEXT_VERSION}.tar.gz"
    FILENAME "gettext-${GETTEXT_VERSION}.tar.gz"
    SHA512 7ba89074d3eddd0b4a5e2980e1ec74b53c49b7a04a1fa91c70c4bc11ce9c30415e4df9d79698148eaaed325fb4feb25a340a2e8e01fbe86b1a66b1376a4c9e3d
)
vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    REF ${GETTEXT_VERSION}
    PATCHES
		0001-gettext-runtime-Add-pre-configured-headers-for-MSVC-.patch
		0001-gettext-tools-Add-pre-configured-headers-and-sources.patch
		0001-gettext-tools-gnulib-lib-libxml-Check-for-_WIN32-as-.patch
		0001-gettext-tools-Make-private-headers-C-friendly.patch
		0001-gettext-tools-src-x-lua.c-Fix-C99ism.patch
		0002-gettext-tools-gnulib-lib-Declare-items-at-top-of-blo.patch
		0004-gettext-runtime-intl-plural-exp.h-Match-up-declarati.patch
		0005-gettext-runtime-intl-printf-parse.c-Fix-build-on-Vis.patch
		0006-gettext-intrinsics.patch
)

file(COPY ${CMAKE_CURRENT_LIST_DIR}/build DESTINATION ${SOURCE_PATH})

# Build the project using the generated msbuild solutions
vcpkg_install_msbuild(
#	CURRENT_BUILDTREES_DIR ${SOURCE_PATH}
	SOURCE_PATH ${SOURCE_PATH}
	PROJECT_SUBPATH build/win32/vs15/gettext.sln	
	SKIP_CLEAN
	LICENSE_SUBPATH COPYING
#	ALLOW_ROOT_INCLUDES ON
#	INCLUDES_SUBPATH include
#	PROJECT_PATH ${CURRENT_BUILDTREES_DIR}
#	PLATFORM ${MSBUILD_PLATFORM}
#	RELEASE_CONFIGURATION Release-Override
#	DEBUG_CONFIGURATION Debug
#	WORKING_DIRECTORY ${SOURCE_PATH}/build/win32/vs14
	USE_VCPKG_INTEGRATION
#	OPTIONS_DEBUG "/p:RuntimeLibrary=MultiThreadedDebug${RuntimeLibraryExt}"
#	OPTIONS_RELEASE "/p:RuntimeLibrary=MultiThreaded${RuntimeLibraryExt}"
#	OPTIONS /p:SolutionDir=../
)

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

#vcpkg_fixup_cmake_targets(CONFIG_PATH share/unofficial-gettext TARGET_PATH share/unofficial-gettext)

vcpkg_copy_pdbs()
