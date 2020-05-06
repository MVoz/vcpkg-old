include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://gitlab.com/mdds/mdds/-/archive/038587eed484b083b4430bf41e7af4992d92b6d0/mdds-038587eed484b083b4430bf41e7af4992d92b6d0.tar.gz"
    FILENAME "mdds.tar.bz2"
    SHA512 0b431dd9eaae3ff83c1a9b9b922c27d3365b73058ca34f46f9201597831378a10819871ceca516c25f52bd75b7826a43bb25a0cf0f1d9decb15e95d5badb9383
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates

#    OPTIONS 
#      -D =OFF # automatic templates
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
