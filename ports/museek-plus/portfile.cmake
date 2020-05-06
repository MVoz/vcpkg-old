include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/eLvErDe/museek-plus/archive/875d96e65697b96c70b2d1e557fc9428b6a1d04a.zip"
    FILENAME "875d96e65697b96c70b2d1e557fc9428b6a1d04a.zip"
    SHA512 8449aafca9440716c2efc80e482b49c5b3fac4d05506c6569775f5b368df4cacf5d4507937db5e7afe99a55edead4b76b1536a3a5cd2683e99cf330d93204da5
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
	OPTIONS
		-DCMAKE_REQUIRED_INCLUDES=${CURRENT_INSTALLED_DIR}/include
		-DICONV_INCLUDE_DIR==${CURRENT_INSTALLED_DIR}/include
)

vcpkg_install_cmake()

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/museek-plus RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME museek-plus)
