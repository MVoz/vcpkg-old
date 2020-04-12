include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/VirtualGL/virtualgl/archive/b74c7b86f21703b201682e2078e1188fc46c3b1f.zip"
    FILENAME "virtualgl.zip"
    SHA512 85636f6d21af030fad7df8a8d063a4356a6dffc9febe1adcba12678d7d5292e48eb6bce1a05d8cb82b58e4074a3d473aacfceae17f9959bb7e7264ce466ff5cc
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
      -DVGL_FORCEINLINE=ON
      -DVGL_USESSL=ON
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE.txt ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
