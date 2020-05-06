include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/avast/libdwarf/archive/c51918d213fe2daf7ff8b32eb70106fd50f9f4f4.zip"
    FILENAME "c51918d213fe2daf7ff8b32eb70106fd50f9f4f4.zip"
    SHA512 13c1645c433bec10c6244130887e0fae19249bdddd5a12e151c74eec14ccb06acb38987f5c6518840d960876d62f7e832b7108380ac75c962384f596e371c638
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE} 
)

file(COPY ${CURRENT_PORT_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH}/libdwarf/libdwarf)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}/libdwarf/libdwarf
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
)

vcpkg_install_cmake()

file(COPY ${SOURCE_PATH}/libdwarf/libdwarf/dwarf.h DESTINATION ${CURRENT_PACKAGES_DIR}/include)
file(COPY ${SOURCE_PATH}/libdwarf/libdwarf/libdwarf.h DESTINATION ${CURRENT_PACKAGES_DIR}/include)

# Handle copyright
file(INSTALL ${SOURCE_PATH}/libdwarf/libdwarf/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/libdwarf RENAME copyright)
set(VCPKG_POLICY_EMPTY_PACKAGE enabled)
# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME libdwarf)
