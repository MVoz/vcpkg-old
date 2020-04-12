include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/mwgoldsmith/kate/archive/09e3021e7c0e8752f7be9eaf6e226862c6c7c9a3.zip"
    FILENAME "09e3021e7c0e8752f7be9eaf6e226862c6c7c9a3.zip"
    SHA512 41ea38ef014f4c1f2f96fa24aa670a1579e9cc479c7197527ee0e7f711118079c046b977a2afbfd4a447df6c316d8836c1980cc7a90d76e8d5aa00678fdfb7f8
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    PATCHES
#      001_oggkate_fixes.patch
      001_oggkate_patch.patch
)

vcpkg_install_msbuild(
    SOURCE_PATH ${SOURCE_PATH}
    PROJECT_SUBPATH "projects/vs14/kate.vcxproj"
    SKIP_CLEAN
    LICENSE_SUBPATH COPYING
    USE_VCPKG_INTEGRATION
)

set(PREBUILT ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel)
file(COPY ${PREBUILT}/msvc/include/kate DESTINATION ${CURRENT_PACKAGES_DIR}/include)

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
###
