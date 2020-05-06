include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/nu774/libsoxconvolver/archive/de7fa7bfa54bd53dd6c9e529e75b198a9a5cf85d.zip"
    FILENAME "de7fa7bfa54bd53dd6c9e529e75b198a9a5cf85d.zip"
    SHA512 c48b8528dee55fa376a929fc82232e01519f24caf095db87ac9b9639c5ffd4419b70a1d460ed58310f4ab1f18eb90c5e8cf09ee32ee26ae2598a1975b628331d
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_install_msbuild(
    SOURCE_PATH ${SOURCE_PATH}
    PROJECT_SUBPATH "MSVC/libsoxconvolver.vcxproj"
    SKIP_CLEAN
    LICENSE_SUBPATH COPYING
    USE_VCPKG_INTEGRATION
)

file(COPY ${SOURCE_PATH}/libsoxconvolver.h DESTINATION ${CURRENT_PACKAGES_DIR}/include)

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
###
