include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "http://www.dyncall.org/r1.0/dyncall-1.0.zip"
    FILENAME "dyncall-1.0.zip"
    SHA512 ac3260ef3ff2fe8e2c38f8768ecb819c7044cfa526c0ce8a4c841faec639cfecdff7300d44e7b933a0b7b91fb263e7ded65d24092002c17346c45e7ec0562a52
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
#    OPTIONS
#        -DOPTIMIZE=1
)

vcpkg_install_cmake()

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/dyncall RENAME copyright)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME dyncall)
