include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/mwgoldsmith/cddb/archive/5cf92c1fb939f7855857ffadec3201c1474f37b9.zip"
    FILENAME "5cf92c1fb939f7855857ffadec3201c1474f37b9.zip"
    SHA512 b43d5d425550178c165856838196fd259ef72fd6ba9529434feb35bdb8df0c66b1a53cb4bf468c3e37cf1c91a602b71557b81806ecd8e6bfebf9de84f26d6102
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    PATCHES
      001_libcddb_patch.patch
)

vcpkg_install_msbuild(
    SOURCE_PATH ${SOURCE_PATH}
    PROJECT_SUBPATH "projects/vs14/cddb.vcxproj"
    SKIP_CLEAN
    LICENSE_SUBPATH COPYING
    USE_VCPKG_INTEGRATION
)

set(PREBUILT ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel)
file(COPY ${PREBUILT}/msvc/include/cddb DESTINATION ${CURRENT_PACKAGES_DIR}/include)

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
###
