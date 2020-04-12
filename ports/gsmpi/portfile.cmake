include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://www.nektar.info/thirdparty/gsmpi-1.2.1_2.tar.bz2"
    FILENAME "gsmpi-1.2.1_2.tar.bz2"
    SHA512 e9e4fd9153c015a473cbbeec07cc1cdab716b0e33fda239ff77ec717834e849aa718372755cf6abe936aa3f83fa86eb39d4153ec801e1f08c90afe9a6c5321b3
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
