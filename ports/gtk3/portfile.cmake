include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://gitlab.gnome.org/GNOME/gimp/-/archive/gtk3-port-meson/gimp-gtk3-port-meson.tar.gz"
    FILENAME "gimp-gtk3-port-meson.tar.gz"
    SHA512 453d80eced451296840c5880942791a142a389c96b02007e387eacbb5da4414a38cfe0b21d96d7208b13f2bc65a413a095186337c0fd2229afb5312dd4d7d0b8
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

		-Dpython=${PYTHON3}

#		-Dpython=python3

)
vcpkg_install_meson()

vcpkg_copy_pdbs()

# Handle copyright
file(INSTALL ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/gtk3 RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME gtk3)
