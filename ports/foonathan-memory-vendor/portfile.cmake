include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/eProsima/foonathan_memory_vendor/archive/1724cbe7b6f8c4dcd113aaecc517fa2d79a8384a.zip"
    FILENAME "foonathan_memory_vendor.zip"
    SHA512 89406adf27573b60f005cf29998483e6fb593559db768e4e29f648af41f3c30a332e7eed6e8708117042d6df145a42c1ba31f14f5153905208a7ca9432b017ef
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
