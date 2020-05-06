include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "http://ftp.acc.umu.se/pub/GNOME/sources/glib/2.60/glib-2.60.4.tar.xz"
    FILENAME "glib-2.60.4.tar.xz"
    SHA512 614d25652ec9e8387f7865777e128b7f6fd68ff4a1a000868117cbcf5210b5f6aa476eb2b795a6dde56b997906aeb2157c83308f1421a27c4e379522d0ed0afc
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_find_acquire_program(PYTHON3)
set(ENV{PATH} ";$ENV{PATH};${CURRENT_INSTALLED_DIR}/bin")

vcpkg_configure_meson(
	SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
		--backend=ninja
		-Dinternal_pcre=true
#		-Dnls=disabled
		-Dc_args=/I:${CURRENT_INSTALLED_DIR}/include
		-Dcpp_args=/I:${CURRENT_INSTALLED_DIR}/include
#		-Dc_link_args=/LIBPATH:${CURRENT_INSTALLED_DIR}/lib
#		-Dcpp_link_args=/LIBPATH:${CURRENT_INSTALLED_DIR}/lib
		
#		-Diconv=gnu
		-Dselinux=disabled
		-Dxattr=false
		-Dlibmount=false
		-Ddtrace=false
		-Dman=false
		-Dgtk_doc=false
		-Dfam=false
#		-Dinternal_pcre=false
		-Db_lundef=false

		
)

vcpkg_install_meson()

vcpkg_copy_pdbs()

# Handle copyright
file(INSTALL ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/glib RENAME copyright)

file(INSTALL ${CURRENT_PACKAGES_DIR}/debug/bin DESTINATION ${CURRENT_PACKAGES_DIR}/tools RENAME glib)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME glib)
