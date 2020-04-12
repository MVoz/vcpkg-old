include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/win-iconv/win-iconv/archive/v0.0.8.tar.gz"
    FILENAME "win-iconv-0.0.8.tar.gz"
    SHA512 2ac525b1c80661586686fb71b299abd4ccff54e1eebae236c5a0d17e49d0ebb6aab88e9c683142df71c0e253f7af4085388fc604f065882b0b982600245e3461
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE} 
)

if(VCPKG_LIBRARY_LINKAGE STREQUAL dynamic)
    set(BUILD_SHARED ON)
    set(BUILD_STATIC OFF)
else()
    set(BUILD_SHARED OFF)
    set(BUILD_STATIC ON)
endif()

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    OPTIONS
		-DBUILD_SHARED=${BUILD_SHARED}
		-DBUILD_STATIC=${BUILD_STATIC}
		
		-DBUILD_EXECUTABLE=OFF
		-DBUILD_TEST=OFF
)

vcpkg_install_cmake()

# Handle copyright
file(INSTALL ${SOURCE_PATH}/readme.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/winiconv RENAME copyright)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME winiconv)
