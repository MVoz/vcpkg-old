include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/diacritic/BoxFort/archive/926bd4ce968592dbbba97ec1bb9aeca3edf29b0d.zip"
    FILENAME "926bd4ce968592dbbba97ec1bb9aeca3edf29b0d.zip"
    SHA512 c70978fc1ed23c97b4c4690f992baaed718b058fcd64159751145e7ee463cfefab2c3620be648b8658df01ce174a7210ac584ab7ed5e3950862eff80a2d3a567
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH})

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
	OPTIONS
		-DBXF_SAMPLES=OFF
#		-DBXF_STATIC_LIB=ON
		-DBXF_TESTS=OFF
)

vcpkg_install_cmake()

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/boxfort RENAME copyright)
file(INSTALL ${SOURCE_PATH}/include DESTINATION ${CURRENT_PACKAGES_DIR})
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME boxfort)
