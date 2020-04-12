include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/sparsehash/sparsehash-c11/archive/ba83a797d58324ddd4cf89d62fef7c3bc152a780.zip"
    FILENAME "ba83a797d58324ddd4cf89d62fef7c3bc152a780.zip"
    SHA512 ea23e468282077cda0e937762cadc0682abdc5db77de9d0b41437093fbcccaac858518beee2adb3cbff48840270a40f0a28967335bf88541151eac10259233fe
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
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/sparsehash-c11 RENAME copyright)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug)
# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME sparsehash-c11)
