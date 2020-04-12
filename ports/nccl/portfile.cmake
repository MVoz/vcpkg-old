include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/hunter-packages/nccl/archive/d751467e1ed704e422e8020695f039a542267489.zip"
    FILENAME "d751467e1ed704e422e8020695f039a542267489.zip"
    SHA512 927b18d0442d7f88ef6f4b0639300777983948a379bd81f786adefb443f1d42726de8808b1a1a07ea2aeb13120182c817b02fafb17588dd24b5ae2cec4b9ba0a
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
configure_file(${SOURCE_PATH}/LICENSE.txt ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
