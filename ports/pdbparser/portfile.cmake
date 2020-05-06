include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/bekdepo/pdbparser/archive/e7fc4a497a22d9eb1f8ee22169e9d8176a0f5e9a.zip"
    FILENAME "e7fc4a497a22d9eb1f8ee22169e9d8176a0f5e9a.zip"
    SHA512 ddd5edf0072ac2cda1973d9e0300226f1ce0b14c2220ed9da0ad0d749351d3d287cd326dfb017fa7c6f0e84863ef619bce3530a44023c00d80475074117e08b3
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE} 
)

file(COPY ${CURRENT_PORT_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH}/src/pdbparser)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
)

vcpkg_install_cmake()

file(COPY ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/src/pdbparser/pdbparser.lib DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
file(COPY ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/src/pdbparser/pdbparser.lib DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)

file(COPY ${SOURCE_PATH}/include DESTINATION ${CURRENT_PACKAGES_DIR})

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/pdbparser RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME pdbparser)
