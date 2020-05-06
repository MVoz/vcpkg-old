include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/cyrusimap/wslay/archive/4a937cdd259de69a955f55d8f57671f410ce7cf9.zip"
    FILENAME "4a937cdd259de69a955f55d8f57671f410ce7cf9.zip"
    SHA512 74b222064b40c75e3cab10ffe88619265d2040d7a9295a3560030f9bff7663020a639f853dfb419089d9aa4e4f48b761f3460156a817e3a10bec4e2f5ad434e9
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
		-DWSLAY_STATIC=OFF
		-DWSLAY_SHARED=ON
		-DWSLAY_EXAMPLES=OFF
		-DWSLAY_TESTS=OFF
		
#option(WSLAY_CONFIGURE_INSTALL "Generate install target" ON)

)

vcpkg_install_cmake()

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/wslay RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME wslay)
