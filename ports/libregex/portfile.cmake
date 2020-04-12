include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/mwgoldsmith/regex/archive/f8d33ced6e9844827a827a43282d46c68e250842.zip"
    FILENAME "f8d33ced6e9844827a827a43282d46c68e250842.zip"
    SHA512 218b70903c5e4f6951cd67a134d27b8c2055c8b622f38eb9abb68d147278f251b9b9e8900c24591fca7d23347699fea058b59a0097447635e9f867cf1bac8eb8
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    PATCHES
      001_libregex_patch.patch
)

vcpkg_install_msbuild(
    SOURCE_PATH ${SOURCE_PATH}
    PROJECT_SUBPATH "projects/vs14/regex.vcxproj"
    SKIP_CLEAN
    LICENSE_SUBPATH COPYING
    USE_VCPKG_INTEGRATION
)

set(PREBUILT ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel)
file(COPY ${PREBUILT}/msvc/include/regex DESTINATION ${CURRENT_PACKAGES_DIR}/include)

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
###
