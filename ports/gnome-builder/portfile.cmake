include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/GNOME/gnome-builder/archive/dbff666e2d68d98574267bd0e463652f158a4cff.zip"
    FILENAME "dbff666e2d68d98574267bd0e463652f158a4cff.zip"
    SHA512 571ab6ddcc7286dff0a154e61bf06bf3136d5a7c9886b7584a71fd73f99ee44d6906051fba65c65fd3e518544a6dfce7bce77ddadd332b77beb8c34e36a3a5a9
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

# https://mesonbuild.com/Configuring-a-build-directory.html
vcpkg_configure_meson(
	SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
#	OPTIONS_RELEASE
#	OPTIONS_DEBUG
		--backend=ninja
#		-Dsubproject:option=_build
#		-Dcpp_link_args="/LIBPATH:${CURRENT_INSTALLED_DIR}/lib"
#		-Dc_link_args="/LIBPATH:${CURRENT_INSTALLED_DIR}/lib"
#		-Dc_args="/I:${CURRENT_INSTALLED_DIR}/include"
#		-Dcpp_args="/I:${CURRENT_INSTALLED_DIR}/include"	
)

vcpkg_install_meson()

vcpkg_copy_pdbs()

# Handle copyright
# file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/gnome-builder RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME gnome-builder)
