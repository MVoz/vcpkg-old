include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/ludocode/mpack/archive/v1.0.tar.gz"
    FILENAME "v1.0.tar.gz"
    SHA512 449e7cc8ce520cf4b89136ebd06f4906bc80030bf1b38405244749219d4e5d3274794a8f24a52621f79405e37a88da39de91d4fe23ce050013e8ab2e9a147444
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE} 
)

if(NOT EXISTS SOURCE_PATH)
	file(DOWNLOAD https://raw.githubusercontent.com/mesonbuild/ludocode-mpack/1.0/meson.build ${SOURCE_PATH}/meson.build
		TIMEOUT 15
		EXPECTED_HASH MD5=18e8d021edea8593a703bb983a975f5d
		TLS_VERIFY ON
	)
endif()

# https://mesonbuild.com/Configuring-a-build-directory.html
vcpkg_configure_meson(
	SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
		--backend=ninja
)

vcpkg_install_meson()

vcpkg_copy_pdbs()

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/mpack RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME mpack)
