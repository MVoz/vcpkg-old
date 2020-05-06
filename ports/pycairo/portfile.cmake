include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/pygobject/pycairo/archive/7c3a71d1dee13cf3da729ef4c06673a2adc53ccc.zip"
    FILENAME "7c3a71d1dee13cf3da729ef4c06673a2adc53ccc.zip"
    SHA512 c0a16bf758acce12c9b83c9a0ed21f73f448ac03b2009a4b1cf4cea090cc8e11fac2e81ae84c638a925c0695e90f4c7dc32c1a44e34c6eb826574f8273a88b3f
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_find_acquire_program(FLEX)
vcpkg_find_acquire_program(BISON)
vcpkg_find_acquire_program(DOXYGEN)

#питон не находит зависимости, пришлось добавить все
get_filename_component(FLEX_DIR "${FLEX}" DIRECTORY)
get_filename_component(BISON_DIR "${BISON}" DIRECTORY)
get_filename_component(DOXYGEN_DIR "${DOXYGEN}" DIRECTORY)

#vcpkg_add_to_path("${PYTHON3_DIR};${FLEX_DIR};${BISON_DIR};${DOXYGEN_DIR}")
set(ENV{PATH} ";$ENV{PATH};${FLEX_DIR};${BISON_DIR};${DOXYGEN_DIR}")
#set(ENV{PYTHON_INSTALL_DIR} "${PYTHON3_DIR}")
#set(ENV{PATH} ";$ENV{PATH};${CURRENT_INSTALLED_DIR}/bin")


#set(ENV{PKG_CONFIG_PATH} ";$ENV{PKG_CONFIG_PATH};${CURRENT_INSTALLED_DIR}/lib/pkgconfig")
#set(ENV{PKG_CONFIG} pkg-config)
#include(FindPkgConfig)
#pkg_search_module(GLIB2 REQUIRED glib-2.0)

# for msgfmt and xgettext
#set(ENV{PATH} "$ENV{PATH};${MSYS_ROOT}/usr/bin")


#find_package(PkgConfig REQUIRED)

#pkg_check_modules(json-glib REQUIRED gio-2.0>=0.1 gobject-2.0>=0.1)

# fake pkg-config
#configure_file(${CURRENT_PORT_DIR}/pkg-config.bat ${CURRENT_BUILDTREES_DIR}/pkg-config.bat @ONLY CRLF)
#set(ENV{PKG_CONFIG} ${CURRENT_BUILDTREES_DIR}/pkg-config.bat)

# https://mesonbuild.com/Configuring-a-build-directory.html
vcpkg_configure_meson(
	SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
#	OPTIONS_RELEASE
#	OPTIONS_DEBUG
		--backend=ninja
		-Dpython=${PYTHON3}
)
vcpkg_install_meson()

vcpkg_copy_pdbs()

# Handle copyright
file(INSTALL ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/pycairo RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME pycairo)
