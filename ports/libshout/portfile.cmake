include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/Voskrese/shout/archive/57f15dfd18ff3070eab4fdde7c9af1dcd8bc816a.zip"
    FILENAME "libshout-2.zip"
    SHA512 d7685ae04beb953956dafa23cdffd2f065056158e11aaab6801b43368a722ce305c04c70f6209a9dab60863b8df604c2ca6d633e21e665ba6b3cbe296e5486dd
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_install_msbuild(
    SOURCE_PATH ${SOURCE_PATH}
    PROJECT_SUBPATH "projects/vs14/shout.vcxproj"
	SKIP_CLEAN
	LICENSE_SUBPATH COPYING
	USE_VCPKG_INTEGRATION
)

file(COPY ${SOURCE_PATH}/include/shout/shout.h DESTINATION ${CURRENT_PACKAGES_DIR}/include/shout)

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
###
