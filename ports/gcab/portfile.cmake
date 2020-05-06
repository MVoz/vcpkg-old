include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://gitlab.gnome.org/GNOME/gcab/-/archive/master/gcab-master.tar.gz"
    FILENAME "gcab-master.tar.gz"
    SHA512 cb7ee0a4b70c82d025daced46f249d41abc7ec7e1858db01eb6f47b1a415cec35bc50caf886c805da3c287b6e4f159993b85d7a9ed9b44bbef6f8eb7134a30a5
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE} 
)

# for msgfmt and xgettext
#set(ENV{PATH} "$ENV{PATH};${MSYS_ROOT}/usr/bin")
set(ENV{PATH} ";$ENV{PATH};${CURRENT_INSTALLED_DIR}/bin")

find_program(GIT NAMES git git.cmd)
find_program(7ZIP NAMES 7z)

# sed and awk are installed with git but in a different directory
get_filename_component(GIT_EXE_PATH ${GIT} DIRECTORY)
#set(AWK_EXE_PATH "${GIT_EXE_PATH}/../usr/bin")
#set(ENV{PATH} "$ENV{PATH};${AWK_EXE_PATH}")
vcpkg_find_acquire_program(7ZIP)
vcpkg_find_acquire_program(FLEX)
vcpkg_find_acquire_program(BISON)
vcpkg_find_acquire_program(VALAC)
vcpkg_find_acquire_program(CMAKE)

#питон не находит зависимости, пришлось добавить все
get_filename_component(VALAC_DIR "${VALAC}" DIRECTORY)
get_filename_component(FLEX_DIR "${FLEX}" DIRECTORY)
get_filename_component(BISON_DIR "${BISON}" DIRECTORY)
get_filename_component(DOXYGEN_DIR "${CMAKE}" DIRECTORY)

#vcpkg_add_to_path("${PYTHON3_DIR};${FLEX_DIR};${BISON_DIR};${DOXYGEN_DIR}")
set(ENV{PATH} "$ENV{PATH};${VALAC_DIR}/bin;${FLEX_DIR};${BISON_DIR};${DOXYGEN_DIR};${GIT_EXE_PATH}")

#find_package(PkgConfig REQUIRED)
#set(PKG_CONFIG_USE_CMAKE_PREFIX_PATH ON)
#set(ENV{PKG_CONFIG_PATH} ";$ENV{PKG_CONFIG_PATH};${CURRENT_INSTALLED_DIR}/lib/pkgconfig")
#set(ENV{PKG_CONFIG} ${CURRENT_INSTALLED_DIR}/bin/pkg-config.exe)
#pkg_check_modules(json-glib REQUIRED gio-2.0>=0.1 gobject-2.0>=0.1)

# fake pkg-config
configure_file(${CURRENT_PORT_DIR}/pkg-config.bat ${CURRENT_BUILDTREES_DIR}/pkg-config.bat @ONLY CRLF)
set(ENV{PKG_CONFIG} ${CURRENT_BUILDTREES_DIR}/pkg-config.bat)

vcpkg_configure_meson(
	SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
#	OPTIONS_RELEASE
#	OPTIONS_DEBUG
		--backend=ninja
#		-Dsubproject:option=_build

#		--buildtype=release
#		--backend=vs2017
#		--backend=vs2015		
)

vcpkg_install_meson()

vcpkg_copy_pdbs()

# Handle copyright
# file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/gcab RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME gcab)
