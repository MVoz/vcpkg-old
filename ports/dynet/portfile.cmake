include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/clab/dynet/archive/c64c86f7c12d579857dcfe210932a9852454d770.zip"
    FILENAME "dynet.zip"
    SHA512 bd3ff6e8603eefa64dcb885a061a61ccf8e2225121db67f96c5ec098048f6f52b81543414607c3a228783e35208109241de423c5a44491df23bc3a08c7df8874
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates

    OPTIONS 
      -DENABLE_BOOST=OFF #error
	  -DENABLE_CPP_EXAMPLES=OFF
	  -DEIGEN3_INCLUDE_DIR=${CURRENT_INSTALLED_DIR}/include
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE.txt ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
