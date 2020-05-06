include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://computing.llnl.gov/projects/sundials/download/ida-5.0.0-dev.2.tar.gz"
    FILENAME "ida-5.0.0-dev.2.tar.gz"
    SHA512 b6ae034ded40e223988d627678c9a61f47eb3d529d2d063c1647966771f6607e16f14c2deaef8dd2929af4bce12a2fb035775dc2c148ee685862153c25672248
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
