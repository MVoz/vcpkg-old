include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/GNOME/devhelp/archive/f0e4c449aec15b4bcf8e1b131a47dc6eaed608fb.zip"
    FILENAME "f0e4c449aec15b4bcf8e1b131a47dc6eaed608fb.zip"
    SHA512 4453c4308b95c3ab4bdabcc0518df93891c86797e3d4e6fe5b9e2ce42fb7b013be950397902c8e482cd21153671278e30d37b2a8cef948bf16866a101035ba89
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
file(INSTALL ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/devhelp RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME devhelp)
