include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/GNOME/glade/archive/a904a9df251f736ff65c5ec78ccb16dd532606bc.zip"
    FILENAME "a904a9df251f736ff65c5ec78ccb16dd532606bc.zip"
    SHA512 4310b767d777ec1ebee4a64066a206559d870e32a7fbf067e972f50499f943bbd1b600ed7f05d819fcb8a718a3eb750209dd5c3b19d3c38bd02c58ac6801ccc1
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

### https://mesonbuild.com/Configuring-a-build-directory.html
vcpkg_configure_meson(
	SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
		--backend=ninja
)

vcpkg_install_meson()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled)
vcpkg_copy_pdbs()
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)

###
