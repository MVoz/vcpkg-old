include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/avast/pelib/archive/b0b22abf23a09ccdf1a79a3494b9f016d6429987.zip"
    FILENAME "b0b22abf23a09ccdf1a79a3494b9f016d6429987.zip"
    SHA512 8711ca8a152a296ce498aaf473d6329e90f9f06899c9e713118376434a27fc0690ded620d080ab1e2c933a7bc5fa9a3c598ec21e5e09af0a7721682b1b59e391
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE} 
)

file(COPY ${CURRENT_PORT_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH}/src/pelib)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
	PROJECT_SOURCE_DIR ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
)

vcpkg_install_cmake()

file(COPY ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/src/pelib/pelib.lib DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
file(COPY ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/src/pelib/pelib.lib DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)

file(COPY ${SOURCE_PATH}/include DESTINATION ${CURRENT_PACKAGES_DIR})

# Handle copyright
file(INSTALL ${SOURCE_PATH}/MIT_LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/pelib RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME pelib)
