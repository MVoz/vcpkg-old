include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/boxerab/cairo/archive/36783c1e92fff2ea7ce2a41be15b491b067b265e.zip"
    FILENAME "cairomeson-1.16.01.zip"
    SHA512 53cb8da14166305a0e2d4551d50a5f05976e1e2184f87666b69fec4421edfea62dc4abad4c8e39693d93d90de6846a6e53b74f4c05e6b835f90dd0980d547d8b
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
#		-Dgl-backend=gl
		-Dtests=disabled
		# static enable
#		-Dfontconfig=disabled
#		-Dfreetype=disabled 
)

vcpkg_install_meson()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/COPYING ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)