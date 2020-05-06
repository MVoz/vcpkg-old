include(vcpkg_common_functions)

# This port explicitly avoids to use vcpkg_from_bitbucket as the gazebo mercurial repo is extremly heavy 
vcpkg_download_distfile(ARCHIVE
    URLS "https://osrf-distributions.s3.amazonaws.com/gazebo/releases/gazebo-10.1.0.tar.bz2"
    FILENAME "gazebo-10.1.0.tar.bz2"
    SHA512 e81f0f73e628155ef929c6d7930611f02009a8a217a043e127506c1310ae892b846a8080906feb0932108e9cfa280f473573a5af5096b55b66619b2ac794b0d5
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE} 
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    OPTIONS -DBUILD_TESTING=OFF
)

vcpkg_install_cmake()

# Fix cmake targets location
vcpkg_fixup_cmake_targets(CONFIG_PATH "lib/cmake/gazebo")

# Remove debug files
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include 
                    ${CURRENT_PACKAGES_DIR}/debug/lib/cmake
                    ${CURRENT_PACKAGES_DIR}/debug/share)

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/gazebo10 RENAME copyright)

# Post-build test for cmake libraries
vcpkg_test_cmake(PACKAGE_NAME gazebo)