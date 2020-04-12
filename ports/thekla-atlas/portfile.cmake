include(vcpkg_common_functions)

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/Thekla/thekla_atlas/archive/c60b9ea2e243950392b137a6aff772d85c65df0c.zip"
    FILENAME "c60b9ea2e243950392b137a6aff772d85c65df0c.zip"
    SHA512 3f5ce7dcbad590f652c191b014e8ac1e0c19d4ab157da7bbc6098a4063e4770ab914393850822049361af4b4fcc57be067aebbf76d6e495d06fa2a246e647dab
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
