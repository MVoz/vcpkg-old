include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://gitlab.com/orcus/orcus/-/archive/7e08a01c20a9aa96dddd8b4717a4914c2e36fcb4/orcus-7e08a01c20a9aa96dddd8b4717a4914c2e36fcb4.tar.gz"
    FILENAME "orcus-7e08a01c20a9aa96dddd8b4717a4914c2e36fcb4.tar.gz"
    SHA512 a937a1135e4caac6daf2bc183859b9a1b6057f6a5bc3726972dd4b068edd03e3d5321fda3ab4d388183f07e35d91bcbd195a3a576efd27332b9a38b6b358ccb0
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
#      -DBOOST_INCLUDEDIR=${CURRENT_INSTALLED_DIR}/include/boost
#      -DBOOST_LIBRARYDIR=${CURRENT_INSTALLED_DIR}/lib
      -DIXION_INCLUDEDIR=${CURRENT_INSTALLED_DIR}/include/ixion-0.15
      -DIXION_LIBRARYDIR=${CURRENT_INSTALLED_DIR}/lib
      -DZLIB_ROOT=${CURRENT_INSTALLED_DIR}
      -DWITH_CPU_FEATURES=ON
#      -DBoost_USE_STATIC_LIBS=OFF
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
