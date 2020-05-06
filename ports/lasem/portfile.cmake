include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/GNOME/lasem/archive/wip/meson.zip"
    FILENAME "lasem-wip-meson.zip"
    SHA512 f31921ac1c0bb1f615654d2592ff780bb9abc7e88f1e73898cc78d4eb3e24624f7f171cb37e2a65a20b34d0099063bd2d966285b6780dba8df8eef25d275e5ae
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

#Requirements:
#gobject, glib, gio, gdk-pixbuf, gdk, cairo, pangocairo, libxml, BISON, FLEX

vcpkg_find_acquire_program(BISON)
vcpkg_find_acquire_program(FLEX)
get_filename_component(BISON_DIR ${BISON} DIRECTORY)
get_filename_component(FLEX_DIR ${FLEX} DIRECTORY)
set(ENV{PATH} ";$ENV{PATH};${BISON_DIR};${FLEX_DIR};${CURRENT_INSTALLED_DIR}/bin")

### https://mesonbuild.com/Configuring-a-build-directory.html
vcpkg_configure_meson(
	SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
		--backend=ninja
		-Ddocumentation=false
		-Dintrospection=false
		
)

vcpkg_install_meson()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled)
vcpkg_copy_pdbs()
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)

###
