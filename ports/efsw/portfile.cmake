include(vcpkg_common_functions)

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_download_distfile(ARCHIVE
    URLS "https://bitbucket.org/SpartanJ/efsw/get/e6afbec564e2.zip"
    FILENAME "e6afbec564e2.zip"
    SHA512 d5d0241c247f9957b76ea9aa049e57552655426205a1e2a76d64f2cb7292dea120357f0c370014d9d22a9796bf4e5bd8fd8c83e417419870c95623d5d967ddc8
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
