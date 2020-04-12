include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/ziocleto/poshlib/archive/33176d147626b4f8b4d249bc17c8b94c5b594c49.zip"
    FILENAME "poshlib.zip"
    SHA512 ed805f36854703e2b74ca786e33538e79ea76da2f468b924cd1386d2145cdcfe723c46877eb80bd2f7f3fcc96a700c30876218aa574bd20f9332dd4b70c84a4e
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
