include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://sourceforge.net/projects/ed448goldilocks/files/libdecaf-1.0.0.tgz/download"
    FILENAME "libdecaf.zip"
    SHA512 0a962fe01e73655db98c98692938794d6ec4cee5656f9a6172ab24e385882229f9163d09212b2a13bff874623c18befb6aaa2f0ed65aa638e1a3c56dd3e124c0
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE} 
)

vcpkg_find_acquire_program(PYTHON2)
get_filename_component(PYTHON2_DIR ${PYTHON2} DIRECTORY)
vcpkg_add_to_path(${PYTHON2_DIR})


vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja

)

vcpkg_install_cmake()

# Handle copyright
# file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/libdecaf RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME libdecaf)
