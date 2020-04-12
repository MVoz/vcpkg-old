include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/geoffmcl/regex/archive/5e78d01d96d50b255857a0b63cee675b248ffa8e.zip"
    FILENAME "5e78d01d96d50b255857a0b63cee675b248ffa8e.zip"
    SHA512 bd24b84577c92e5073d039e7a64422ee5f6897bdb0757f7323459ba6e57d17a05158695cc59515933d6fab67a497eac38e84ccb0df66e4e3fa40e80cb9793e21
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    # OPTIONS -DUSE_THIS_IN_ALL_BUILDS=1 -DUSE_THIS_TOO=2
    # OPTIONS_RELEASE -DOPTIMIZE=1
    # OPTIONS_DEBUG -DDEBUGGABLE=1
)

vcpkg_install_cmake()

# Handle copyright
file(INSTALL ${SOURCE_PATH}/COPYRIGHT DESTINATION ${CURRENT_PACKAGES_DIR}/share/regex RENAME copyright)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME regex)
