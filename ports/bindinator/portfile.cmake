include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/GLibSharp/bindinator/archive/063a3750bd4bea8c7984e8955989aaf372d3a39b.zip"
    FILENAME "063a3750bd4bea8c7984e8955989aaf372d3a39b.zip"
    SHA512 edc27639b637bed8f1ad9bc2dad0bd11d2bf1b1e47d0d1fc255c4bc8421eddcdea732dd896ef4b32b0a2d7fb47b8fcfd7cf4bb31ebd65fbbc215b1f3d2350840
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
)

vcpkg_install_meson()

vcpkg_copy_pdbs()

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/bindinator RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME bindinator)
