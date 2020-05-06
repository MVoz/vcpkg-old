include(vcpkg_common_functions)

# http://viennacl.sourceforge.net/viennacl-download.html
# Windows 7/8/8.1/10, 32/64 bit: ViennaCL-1.7.1.zip
# Linux/Mac OS, 32/64 bit: ViennaCL-1.7.1.tar.gz 

if(VCPKG_CMAKE_SYSTEM_NAME OR VCPKG_CMAKE_SYSTEM_NAME STREQUAL "WindowsStore")
	message(FATAL_ERROR "\n-- Build port ${PORT} only supported Windows Desktop")
endif()

vcpkg_download_distfile(ARCHIVE
    URLS "https://netix.dl.sourceforge.net/project/viennacl/1.7.x/ViennaCL-1.7.1.zip"
    FILENAME "ViennaCL-1.7.1.zip"
    SHA512 7593388ff693e8ac7c45846c616e4e2d0829ad31927666953a699b5dc5902ad4540c4464617d5aa8ac73a81bffa7573c9fc772e5d0e6d61baeca2d2efd132a32
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
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/viennacl RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME viennacl)
