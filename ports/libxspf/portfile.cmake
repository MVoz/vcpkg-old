include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/Voskrese/libxspf-msvc/archive/1755102a2953d2390b66b157cb0703620bb03910.zip"
    FILENAME "libxspf-1.2.0.zip"
    SHA512 bc34b8eff1002bff338fba509d6882342f4c6537d35db17f92eb883f3d620a7a82e2e02fadc6591c750addc0c2f2e9fc93b631ad321ea44979a4494a08903382
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

###
vcpkg_install_msbuild(
    SOURCE_PATH ${SOURCE_PATH}
    PROJECT_SUBPATH "win32/Visual_Studio_2005/libxspf.vcxproj"
	SKIP_CLEAN
	LICENSE_SUBPATH COPYING
	USE_VCPKG_INTEGRATION
)

file(COPY ${SOURCE_PATH}/include DESTINATION ${CURRENT_PACKAGES_DIR})

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
###
