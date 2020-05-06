include(vcpkg_common_functions)

set(VCPKG_POLICY_EMPTY_PACKAGE enabled)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/intel/parallelstl/archive/924e3f5d7cca82116f4b93718082b54e43816397.zip"
    FILENAME "924e3f5d7cca82116f4b93718082b54e43816397.zip"
    SHA512 f9032d7ba931a310590586c6d5a7ac90465db3e1b8af36c284886ef6b40018b388fb6a62779316ed55f8c598e6f06eb3bef4b60a1e306427eff3ef210d5f90e3
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

file(COPY ${CMAKE_CURRENT_LIST_DIR}/FindTBB.cmake DESTINATION ${SOURCE_PATH}/cmake)
file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH})

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    OPTIONS 
        -DTBB_DIR=${CURRENT_INSTALLED_DIR}
)

vcpkg_install_cmake()

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/parallelstl RENAME copyright)
file(COPY ${SOURCE_PATH}/include DESTINATION ${CURRENT_PACKAGES_DIR})
# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME parallelstl)
