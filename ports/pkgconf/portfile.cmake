include(vcpkg_common_functions)
set(VCPKG_POLICY_EMPTY_PACKAGE enabled)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/pkgconf/pkgconf/archive/pkgconf-1.5.4.zip"
    FILENAME "pkgconf-1.5.4.zip"
    SHA512 fe3c6f9c072ba7beb0c5e2610499f06430b54b77afa2ec6c783510991d3f5e11ee4eb30d303cb7b49930c829d71755d1b1fca6e012c7d329305893e7c17ce12a
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE} 
    PATCHES
		0001-vs2013.patch
)

# https://mesonbuild.com/Configuring-a-build-directory.html
vcpkg_configure_meson(
	SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
		--backend=ninja
		-Dtests=false
)

vcpkg_copy_pdbs()
vcpkg_install_meson()

# Handle copyright
file(INSTALL ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/pkgconf RENAME copyright)

if(WIN32)
file(INSTALL ${CURRENT_PACKAGES_DIR}/bin/pkgconf.exe DESTINATION ${CURRENT_PACKAGES_DIR}/bin RENAME pkg-config.exe)
file(INSTALL ${CURRENT_PACKAGES_DIR}/debug/bin/pkgconf.exe DESTINATION ${CURRENT_PACKAGES_DIR}/debug/bin RENAME pkg-config.exe)
endif()
