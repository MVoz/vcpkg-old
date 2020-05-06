include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://gitlab.gnome.org/GNOME/libsoup/-/archive/2.66.1/libsoup-2.66.1.tar.gz"
    FILENAME "libsoup-2.66.1.tar.gz"
    SHA512 41bab1a5e2c515945dff0b9baf26ebf222e37d7cfa56e75b863176dfeea1d0a566e1a9ccceb3664ab984005365316189357396a252ffb2b4a197bcaa9b0cc403
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_find_acquire_program(XGETTEXT)
get_filename_component(GETTEXT_DIR "${XGETTEXT}" DIRECTORY)
set(ENV{PATH} ";$ENV{PATH};${GETTEXT_DIR}")

#vcpkg_find_acquire_program(VALAC)
#get_filename_component(VALAC_DIR ${VALAC} DIRECTORY)
#set(ENV{PATH} ";$ENV{PATH};${VALAC_DIR}")

# https://mesonbuild.com/Configuring-a-build-directory.html
# Also pass in -Dgssapi=false if not building with GSSAPI support.
vcpkg_configure_meson(
	SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
		--backend=ninja
		-Dgssapi=false
#		-Dvala=${VALAC}
		-Dvapi=false
		-Dintrospection=false
		-Dtests=false
		-Dexamples=false
)

vcpkg_install_meson()

vcpkg_copy_pdbs()

# Handle copyright
file(INSTALL ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/libsoup RENAME copyright)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)