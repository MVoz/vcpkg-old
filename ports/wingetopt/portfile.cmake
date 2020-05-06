include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/alex85k/wingetopt/archive/fed839a02eca9abaebb834d3e53c583ff4304e1c.zip"
    FILENAME "fed839a02eca9abaebb834d3e53c583ff4304e1c.zip"
    SHA512 3a4c714b4f8e808e26e038b78c5a5b03f0b935285a04d4633e58c32779e3f8065bcf5a51453788c436c49bdcd9d112eba5e0adfb6fd153cf69f0f9b777ad9c98
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
#    OPTIONS
#		-DBUILD_SHARED_LIBS=OFF
)

vcpkg_install_cmake()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/wingetopt RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME wingetopt)
