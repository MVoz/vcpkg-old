include(vcpkg_common_functions)

#vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/sekrit-twc/zimg/archive/05ef70fadf1198c92f408f1832889d3234fbdb15.zip"
    FILENAME "zimg.zip"
    SHA512 65426439a24b57e0cfb3cfa0c41b8656af5cf36d580c844e20780d7a539f842393d88f770ca1cac5d2f4dd1bb4a390d19849d5b673d99f280d2eb7469890f62e
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    PATCHES
      001_zimg_patch.patch
      002_zimg_patch.patch #disable example & test
)

vcpkg_install_msbuild(
    SOURCE_PATH ${SOURCE_PATH}
    PROJECT_SUBPATH "_msvc/zimg.sln"
    SKIP_CLEAN
    LICENSE_SUBPATH COPYING
    USE_VCPKG_INTEGRATION
)

file(COPY ${SOURCE_PATH}/src/zimg/api/zimg.h ${SOURCE_PATH}/src/zimg/api/zimg++.hpp DESTINATION ${CURRENT_PACKAGES_DIR}/include)

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
###
