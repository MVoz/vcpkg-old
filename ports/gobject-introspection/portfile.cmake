include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/GNOME/gobject-introspection/archive/dac89688b7f2c4caf466772125f6a00a668600bd.zip"
    FILENAME "dac89688b7f2c4caf466772125f6a00a668600bd.zip"
    SHA512 e07c59258317e76a29cc6fd1c6c2079434b876c98651a8f4db62552cc148ba9dcaa698c8a9db23630af4cd1f808954312c42ccee4b758213a1bb5d15a54ad35b
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_find_acquire_program(FLEX)
vcpkg_find_acquire_program(BISON)
vcpkg_find_acquire_program(DOXYGEN)
vcpkg_find_acquire_program(PYTHON3)

get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
get_filename_component(FLEX_DIR "${FLEX}" DIRECTORY)
get_filename_component(BISON_DIR "${BISON}" DIRECTORY)
get_filename_component(DOXYGEN_DIR "${DOXYGEN}" DIRECTORY)

set(ENV{PATH} ";$ENV{PATH};${FLEX_DIR};${BISON_DIR};${DOXYGEN_DIR};${PYTHON3_DIR}")

#find_program(PYTHON3_REL NAMES python HINTS "${CURRENT_INSTALLED_DIR}/python3")
#find_program(PYTHON3_DBG NAMES python_d HINTS "${CURRENT_INSTALLED_DIR}/debug/python3")


# не работает с debug lib python error #unresolved external symbol __imp_PyModule_Create2

# https://mesonbuild.com/Configuring-a-build-directory.html
vcpkg_configure_meson(
	SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
		--backend=ninja
#		-Dcairo_libname=cairo-gobject-2.dll
		-Dcairo_libname=cairo-gobject.dll
#		-Dpython=${PYTHON3}
		-Dgtk_doc=false
		-Ddoctool=false
#	OPTIONS_RELEASE
		-Dpython=${PYTHON3}
#	OPTIONS_DEBUG
#		-Dpython=${PYTHON3_DBG}
)
vcpkg_install_meson()

vcpkg_copy_pdbs()

# Handle copyright
file(INSTALL ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/gobject-introspection RENAME copyright)

set(VCPKG_POLICY_* enabled)
set(VCPKG_POLICY_EMPTY_PACKAGE enabled)
set(VCPKG_POLICY_ALLOW_OBSOLETE_MSVCRT enabled)
