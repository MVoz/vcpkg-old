include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/STEllAR-GROUP/blaze_tensor/archive/ebfe5729805611e1df9e7cf3e825789a1564a60e.zip"
    FILENAME "blaze_tensor.zip"
    SHA512 ac59b98b1459dcc843f581b3d06ae4a5504a5e20fdf559ccb9a84d07ec7f867b4d47b47325020ca62d787e3994589d3024bdd59e078dc9be338e46e1d91e7dde
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
