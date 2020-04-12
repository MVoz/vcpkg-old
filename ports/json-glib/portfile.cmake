include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://gitlab.gnome.org/GNOME/json-glib/-/archive/09091490a45cbe21bb85e670d3565e30c7d1ddd2/json-glib-09091490a45cbe21bb85e670d3565e30c7d1ddd2.tar.gz"
    FILENAME "json-glib-1.4.tar.gz"
    SHA512 fabcc2216232d6a8b84ef3589397e142d3a414bb088f95802196ca413b7e1024c5bf16804e4c6d9cbd4eb053066d5d7cc9cb5c7ac1383f4828c48d535724a986
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

# for msgfmt and xgettext
vcpkg_find_acquire_program(XGETTEXT)
#set(ENV{PATH} "$ENV{PATH};${MSYS_ROOT}/usr/bin")
#set(ENV{PATH} ";$ENV{PATH};${CURRENT_INSTALLED_DIR}/bin")

vcpkg_find_acquire_program(PYTHON3)

get_filename_component(XGETTEXT_DIR "${XGETTEXT}" DIRECTORY)
set(ENV{PATH} ";$ENV{PATH};${XGETTEXT_DIR}")

set(GLIB_MKENUMS_INTERP ${PYTHON3})

# https://mesonbuild.com/Configuring-a-build-directory.html
vcpkg_configure_meson(
	SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
		--backend=ninja
		-Dman=false
		-Dintrospection=disabled
		-Dgtk_doc=disabled
)

vcpkg_install_meson()

vcpkg_copy_pdbs()

# Handle copyright
file(INSTALL ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/json-glib RENAME copyright)

file(GLOB_RECURSE VALIDATE ${CURRENT_PACKAGES_DIR}/json-glib-validate*)
file(GLOB_RECURSE FORMAT ${CURRENT_PACKAGES_DIR}/json-glib-format*)

file(REMOVE_RECURSE 
	${VALIDATE} 
	${FORMAT}
	${CURRENT_PACKAGES_DIR}/libexec
	${CURRENT_PACKAGES_DIR}/debug/share
	${CURRENT_PACKAGES_DIR}/debug/libexec
)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME json-glib)











