include(vcpkg_common_functions)

vcpkg_find_acquire_program(DOXYGEN)
get_filename_component(DOXYGEN_DIR "${DOXYGEN}" DIRECTORY)
vcpkg_add_to_path("${DOXYGEN_DIR}")
#set(ENV{PATH} "$ENV{PATH};${PYTHON2_DIR};${FLEX_DIR};${BISON_DIR};${DOXYGEN_DIR};${SCONS_DIR}")

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/brechtsanders/xlsxio/archive/8f14331fa6394e545dda246da76fd1cf5cefe97b.zip"
    FILENAME "8f14331fa6394e545dda246da76fd1cf5cefe97b.zip"
    SHA512 d374ceb8f9f019454dc2d42ef9826db74495376fecd5f125076a57716dc0ac7ee48e3f499ad720962088ccd0fcb64969bd273d9efd6c955b7aab2c0bd64074cb
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    OPTIONS 
		-DBUILD_EXAMPLES=OFF

    # OPTIONS_RELEASE -DOPTIMIZE=1
    # OPTIONS_DEBUG -DDEBUGGABLE=1
)

vcpkg_install_cmake()

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/xlsxio RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME xlsxio)
