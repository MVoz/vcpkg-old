include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/libspatialindex/libspatialindex/archive/0fb2125c8d82b64303334ac44748f78c377e4db4.zip"
    FILENAME "0fb2125c8d82b64303334ac44748f78c377e4db4.zip"
    SHA512 3521cf9807218f3161ab1c335d255075676908df8fd3d98662081cc550fda7bf80d498c05736ee78c678b14d959f8807585da3a8f4ac9e451744d32dfb8124ac
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)


vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
)

vcpkg_install_cmake()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

configure_file(${SOURCE_PATH}/COPYING ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
set(VCPKG_POLICY_EMPTY_PACKAGE enabled)
vcpkg_copy_pdbs()

###
