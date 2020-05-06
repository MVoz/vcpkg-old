include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/STEllAR-GROUP/BlazeIterative/archive/d3f778ff8dc1abc6db471629721c7265e7914bb0.zip"
    FILENAME "BlazeIterative.zip"
    SHA512 a2733ea70e3d7c30f67e2abe03d4ecf8948a765464138cad018b514ec2d855dfb30b554c7e7d15353cf121ee63df0854591dd8e2ab44f5bfeda1e40731e88e0a
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
