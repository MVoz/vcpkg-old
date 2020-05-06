include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://gitlab.linphone.org/BC/public/external/opencore-amr/-/archive/bc/opencore-amr-bc.tar.gz"
    FILENAME "opencore-amr-bc.tar.gz"
    SHA512 7af3b544dc3979207cde1f5df88c87bf027ca10bbb1b61152552039dbe2efe07d261be958bf69bca9386adf8b693be40e2b3ca5c8cd08420683c3872fc354f1c
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE} 
    PATCHES
		opencore-amr.patch
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
)

vcpkg_install_cmake()

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/opencore-amr RENAME copyright)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME opencore-amr)
