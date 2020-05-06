include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/ddiakopoulos/tinyply/archive/a6ca3c89480b89d271b6909e16d8423ef0025336.zip"
    FILENAME "a6ca3c89480b89d271b6909e16d8423ef0025336.zip"
    SHA512 fec530b96d27d3ffbb7c10a18fb70808035109fc21b130f4b84f9787ea2ca19c98cc43d742d8f5b4d9a7e9b12ad1fd4274399a2ed50b9b2d3426a2f43edb5e41
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
###
