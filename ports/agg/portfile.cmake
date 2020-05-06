include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/franko/agg/archive/ae883e67ffbbc9e155721ee43c233e5d0251c23e.zip"
    FILENAME "agg.zip"
    SHA512 d531ff478e67e1151efe7fe88ded07991199eaf31a7a3ed822e4a50d053a9401c82667eaeea8456efa0a1b68a4a027eb0a9c96b5607ce624660711b69406dd44
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

### https://mesonbuild.com/Configuring-a-build-directory.html
vcpkg_configure_meson(
    SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
      --backend=ninja
)

vcpkg_install_meson()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/copying ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
