include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://gitlab.com/randy408/libspng/-/archive/cb18f38c1f2c62a70062d5d2d36b28e7384b954d/libspng-cb18f38c1f2c62a70062d5d2d36b28e7384b954d.tar.gz"
    FILENAME "libspng-cb18f38c1f2c62a70062d5d2d36b28e7384b954d.tar.gz"
    SHA512 a7ccf81e5213e291ef8640dfe087b484ee982cdb8664921cb90cf9e175d3e90ac5b7d5bdc381fc848398dfb28fd735ea4ad0f0f41a7bd0b2a3ab0438496c9629
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

# https://mesonbuild.com/Configuring-a-build-directory.html
vcpkg_configure_meson(
	SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
		--backend=ninja
		-Ddev_build=false
		-Doptimize_filter=false
)

vcpkg_install_meson()

vcpkg_copy_pdbs()

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/libspng RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME libspng)
