include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/glfw/glfw/archive/599fb3de348f73134b4e9d2ee5cabc62ca0b84ab.zip"
    FILENAME "599fb3de348f73134b4e9d2ee5cabc62ca0b84ab.zip"
    SHA512 848a7ec05cccf27b4e896140e1c6518eaeafb22bd27a514f29f6e68b1d6493ee6897ce98c77fc883c852b9524730e33e9624c46dabd79440b84a047e3b58c74d
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE} 
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
)

vcpkg_install_cmake()

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE.md DESTINATION ${CURRENT_PACKAGES_DIR}/share/glfw RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME glfw)
