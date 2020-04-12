include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/taocpp/tuple/archive/1f294957b2cfaa8fb5e1f75d226609de32306dd9.zip"
    FILENAME "tuple.zip"
    SHA512 a97d6197d00c6e3db68b7a2d92a6e7eef6a564eff0141aabff6898389a6c3127e56f6aad88e3305132f8670bc91f8a75d809d7c946d8338d0f2c4b503d139d57
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS 
      -DTAOCPP_TUPLE_BUILD_TESTS=OFF
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###