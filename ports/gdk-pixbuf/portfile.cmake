include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://gitlab.gnome.org/GNOME/gdk-pixbuf/-/archive/master/gdk-pixbuf-master.tar.gz"
    FILENAME "gdk-pixbuf-2-master.tar.gz"
    SHA512 6c9ccd8dd8834de6f102101a720155a40ca6f5d90e41682fc0fc690ce2b538f56a10ad1f35d56d78199bbd6480e95788a22af58d53bc7f0f99e12f8206249ac6
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE} 
)

vcpkg_find_acquire_program(FLEX)
vcpkg_find_acquire_program(BISON)
vcpkg_find_acquire_program(PYTHON3)
vcpkg_find_acquire_program(DOXYGEN)
vcpkg_find_acquire_program(XGETTEXT)
get_filename_component(XGETTEXT_DIR "${XGETTEXT}" DIRECTORY)

#питон не находит зависимости, пришлось добавить все
get_filename_component(FLEX_DIR "${FLEX}" DIRECTORY)
get_filename_component(BISON_DIR "${BISON}" DIRECTORY)
get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
get_filename_component(DOXYGEN_DIR "${DOXYGEN}" DIRECTORY)

#vcpkg_add_to_path("${PYTHON3_DIR};${FLEX_DIR};${BISON_DIR};${DOXYGEN_DIR}")
set(ENV{PATH} "$ENV{PATH};${FLEX_DIR};${BISON_DIR};${DOXYGEN_DIR};${PYTHON3_DIR};${XGETTEXT_DIR}")

# https://mesonbuild.com/Configuring-a-build-directory.html
vcpkg_configure_meson(
	SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
		--backend=ninja
		-Dbuiltin_loaders=windows
		-Dx11=false
		-Dman=false
		-Dgir=false
		-Dinstalled_tests=false
		-Djasper=true
		-Dnative_windows_loaders=false
		-Djpeg=true
		-Dtiff=true
		-Dpng=true
		-Dgio_sniffing=false
)
vcpkg_install_meson()

vcpkg_copy_pdbs()

# Handle copyright
#file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/gdk-pixbuf RENAME copyright)
#set(VCPKG_POLICY_EMPTY_PACKAGE enabled)
set(VCPKG_POLICY_* enabled)
set(VCPKG_POLICY_EMPTY_PACKAGE enabled)
set(VCPKG_POLICY_ALLOW_OBSOLETE_MSVCRT enabled)
