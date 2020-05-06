include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/doxygen/doxygen/archive/54e7af6b0e7cf2063c86981c4dca7fcb8eca746a.zip"
    FILENAME "54e7af6b0e7cf2063c86981c4dca7fcb8eca746a.zip"
    SHA512 3764fadd502633a5c875426d1a68e27f5fc7619fae78f9664c6c1b468a02ee038d70d13baa6e575b9ed1a5acc28784a75e2aa58ce824b54dc76dfb2443ab2229
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_find_acquire_program(FLEX)
vcpkg_find_acquire_program(PYTHON3)
vcpkg_find_acquire_program(BISON)
get_filename_component(FLEX_DIR "${FLEX}" DIRECTORY)
get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
get_filename_component(BISON_DIR "${FLEX}" DIRECTORY)
set(ENV{PATH} ";$ENV{PATH};${FLEX_DIR};${BISON_DIR};${PYTHON3_DIR}")

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
	OPTIONS
		-DICONV_INCLUDE_DIR=${SOURCE_PATH}/winbuild
		-DICONV_LIBRARY=${SOURCE_PATH}/winbuild/iconv64.lib
#		-Dwin_static=OFF
		-Dbuild_xmlparser=ON
#		-DLIBICONV_STATIC=OFF
		-Dbuild_parse=ON
#		-Dbuild_search=OFF  # xapian deps
#		-Duse_sqlite3=ON
#		-Dbuild_app:BOOL=OFF
#		-Dbuild_doc:BOOL=OFF
#		-Dbuild_wizard:BOOL=OFF
#		-Denglish_only:BOOL=OFF
#		-Dforce_qt4:BOOL=OFF
#		-Dpkgcfg_lib__SQLITE3_sqlite3:FILEPATH=E:/tools/vcpkg/installed/x64-windows/debug/lib/sqlite3.lib
#		-Duse_libclang:BOOL=OFF
	
)

vcpkg_install_cmake()
set(VCPKG_POLICY_EMPTY_PACKAGE enabled)
# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/doxygen RENAME copyright)
file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/tools)
file(RENAME ${CURRENT_PACKAGES_DIR}/debug/bin ${CURRENT_PACKAGES_DIR}/tools/doxygen)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin) 
# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME doxygen)
