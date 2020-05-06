include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/GNOME/pygobject/archive/060dbc6be9b6e392921a7250d23a2bb4ad97d4cb.zip"
    FILENAME "060dbc6be9b6e392921a7250d23a2bb4ad97d4cb.zip"
    SHA512 6a67a9dbebef74d44360de518716eeddf21423eb2751f182100cdd3e7262173f95099d85f3ea6b2315249c8e38d342f22af410afaced764e98e2e8d6f85bbb34
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

#find_program(PYTHON3 NAMES python python_d)
vcpkg_find_acquire_program(FLEX)
vcpkg_find_acquire_program(BISON)
vcpkg_find_acquire_program(DOXYGEN)
#set(PYTHON3 ${CURRENT_INSTALLED_DIR}/python3)

#питон не находит зависимости, пришлось добавить все
get_filename_component(FLEX_DIR "${FLEX}" DIRECTORY)
get_filename_component(BISON_DIR "${BISON}" DIRECTORY)
#get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
get_filename_component(DOXYGEN_DIR "${DOXYGEN}" DIRECTORY)

#vcpkg_add_to_path("${PYTHON3_DIR};${FLEX_DIR};${BISON_DIR};${DOXYGEN_DIR}")
set(ENV{PATH} ";$ENV{PATH};${FLEX_DIR};${BISON_DIR};${DOXYGEN_DIR})
#;${PYTHON3_DIR}")
#set(ENV{PYTHON_INSTALL_DIR} "${PYTHON3_DIR}")
#set(ENV{PATH} ";$ENV{PATH};${CURRENT_INSTALLED_DIR}/bin")

#set(ENV{PYTHON_CMD} "${PYTHON3}/python")
#set(PYTHON_EXECUTABLE 
#set(ENV{PYTHON_INCLUDES} ${PYTHON3_DIR}/include)

#"_PYTHONHOME"="e:\\Anaconda2"
#"_PYTHONPATH"="E:\\Anaconda2\\Lib"
#"_PYTHONSCRIPT"="e:\\Anaconda2\\Scripts;E:\\Anaconda2\\Wing_IDE\\scripts;C:\\Program Files (x86)\\IDA 6.8\\python"
#"_PYTHON_EXECUTABLE"="e:\\Anaconda2\\python.exe"
#"_PYTHON_HOME"="e:\\Anaconda2"
#"_PYTHON_INCLUDE_DIR"="e:\\Anaconda2\\include"
#"_PYTHON_LIBRARY"="E:\\Anaconda2\\libs\\python27.lib;E:\\Anaconda2\\libs"

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
		-Dpycairo=true
		-Dtests=false
	
)
vcpkg_install_meson()

vcpkg_copy_pdbs()

# Handle copyright
file(INSTALL ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/pygobject RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME pygobject)
