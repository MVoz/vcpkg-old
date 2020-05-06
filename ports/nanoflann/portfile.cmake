include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/jlblancoc/nanoflann/archive/49cd1120247ceaab93c1aee89fb647d831f9c9ba.zip"
    FILENAME "49cd1120247ceaab93c1aee89fb647d831f9c9ba.zip"
    SHA512 1e8f46cba0d0bb7299466c4d1defcd5923c20acd5bdfa22d6e72e768d775cb724f467ac72f396c000cbb529bf23fb82a051b8fc0eda19c85ab51ed9998abe7ff
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
configure_file(${SOURCE_PATH}/COPYING ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
