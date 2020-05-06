include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://gitlab.gnome.org/GNOME/atk/-/archive/9a07910ddbc9e8d08c51d5f2557c2a1f255f1235/atk-9a07910ddbc9e8d08c51d5f2557c2a1f255f1235.tar.gz"
    FILENAME "atk-9a07910ddbc9e8d08c51d5f2557c2a1f255f1235.tar.gz"
    SHA512 895274b8cd6e6c7eca43ea7372bb13a14f48cd73c60c5e138dc92deaf815247ebdae94702fdfa1d89e740e09c6ca9f2557352e33cddbb870d7b20b3eb6f452aa
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
		-Dintrospection=true
		-Dnls=false
		-Ddocs=false
)
vcpkg_install_meson()

vcpkg_copy_pdbs()

# Handle copyright
file(INSTALL ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/atk RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME atk)
