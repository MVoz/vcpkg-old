include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/avast/yaracpp/archive/df0ab6b4ec817f6101a885c56732b9571015df90.zip"
    FILENAME "df0ab6b4ec817f6101a885c56732b9571015df90.zip"
    SHA512 1d08811eaec578aa8ad063a6f0935a8a04c312d6939626fa6eaae8a6d40f41ad6527518526020a94b1462e9513148daf81a12b7aceca405515dab6e3620a5547
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

file(COPY ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/src/yaracpp.lib DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
file(COPY ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/src/yaracpp.lib DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)

file(COPY ${SOURCE_PATH}/include/yaracpp DESTINATION ${CURRENT_PACKAGES_DIR}/include)

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/yaracpp RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME yaracpp)
