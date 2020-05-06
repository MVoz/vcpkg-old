include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://gitlab.gnome.org/GNOME/gtk/-/archive/wip/nirbheek/gtk-3-24-meson/gtk-wip-nirbheek-gtk-3-24-meson.tar.gz"
    FILENAME "gtk-wip-nirbheek-gtk-3-24-meson.tar.gz"
    SHA512 4de58a1b15ab7def8effc036095193ba4212730d203d28335ff13aae592597bdfe85c4e4b4bae8bebca50e7cc949ee8c702f678fb619cd53b2025ae2dd013f62
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE} 

)

vcpkg_find_acquire_program(FLEX)
vcpkg_find_acquire_program(BISON)
vcpkg_find_acquire_program(PYTHON3)
vcpkg_find_acquire_program(DOXYGEN)

#питон не находит зависимости, пришлось добавить все
get_filename_component(FLEX_DIR "${FLEX}" DIRECTORY)
get_filename_component(BISON_DIR "${BISON}" DIRECTORY)
get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
get_filename_component(DOXYGEN_DIR "${DOXYGEN}" DIRECTORY)

#vcpkg_add_to_path("${PYTHON3_DIR};${FLEX_DIR};${BISON_DIR};${DOXYGEN_DIR}")
set(ENV{PATH} ";$ENV{PATH};${FLEX_DIR};${BISON_DIR};${DOXYGEN_DIR};${PYTHON3}")
#set(ENV{PYTHON_INSTALL_DIR} "${PYTHON3_DIR}")

#set(ENV{PYTHON_CMD} "${PYTHON3}/python")
#set(ENV{PYTHON_INCLUDES} ${PYTHON3_DIR}/include)

# https://mesonbuild.com/Configuring-a-build-directory.html
vcpkg_configure_meson(
	SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
#	OPTIONS_RELEASE
#	OPTIONS_DEBUG
		--backend=ninja

		-Dpython=${PYTHON3}
		-Dwin32-backend=true
		-Dgtk_doc=false
		-Ddoctool=false
#		-Dpython=python3
		-Ddemos=false
		-Dbuild-examples=false
		-Dbuild-tests=false
)
vcpkg_install_meson()

vcpkg_copy_pdbs()

# Handle copyright
file(INSTALL ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/gtk RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME gtk)
