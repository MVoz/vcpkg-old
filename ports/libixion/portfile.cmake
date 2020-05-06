include(vcpkg_common_functions)

#vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_download_distfile(ARCHIVE
    URLS "https://gitlab.com/ixion/ixion/-/archive/a8fe2c542b16ee30723ab3d7f3b643ee479e9723/ixion-a8fe2c542b16ee30723ab3d7f3b643ee479e9723.tar.gz"
    FILENAME "libixion.tar.gz"
    SHA512 160d11ed572ed13fc572aa2c5650624c7ad2b4fa61cc1b3bcbc0d20876ca2058dc2f78e8988d177e33ef476b528df4ec51b84e1ba311b4bebd406b9ab1df10bb
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
      -DMDDS_INCLUDEDIR=${CURRENT_INSTALLED_DIR}/include/mdds-1.5
      -DSPDLOG_INCLUDEDIR=${CURRENT_INSTALLED_DIR}/include/spdlog
      -DBOOST_INCLUDEDIR=${CURRENT_INSTALLED_DIR}/include/boost
#      -DBOOST_LIBRARYDIR=${CURRENT_INSTALLED_DIR}/lib
#      -DBoost_USE_STATIC_LIBS=OFF
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
