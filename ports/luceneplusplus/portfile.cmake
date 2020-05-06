include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/luceneplusplus/LucenePlusPlus/archive/e6feb35c326b70b32b65bf5bebe1037f1c284746.zip"
    FILENAME "e6feb35c326b70b32b65bf5bebe1037f1c284746.zip"
    SHA512 a41c79b8c9873eb3d62f6dbfe7a2eaf1285fc0a9955cd88b11a6cbea693f528124f634d1c69b02f061bbae93703272b4495cc2cb4dc50335c55629b13d9f604e
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
file(INSTALL ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/luceneplusplus RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME luceneplusplus)
