include(vcpkg_common_functions)

if(VCPKG_CMAKE_SYSTEM_NAME STREQUAL WindowsStore)
    message(FATAL_ERROR "\n-- Error: UWP builds are currently not supported.\n")
endif()

if(VCPKG_LIBRARY_LINKAGE STREQUAL "static")
#    message(FATAL_ERROR "\n-- Current ${PORT} port only supports dynamic library linkage\n")
    set(VCPKG_LIBRARY_LINKAGE "dynamic")
endif()

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/apache/serf/archive/014bdeb6ce0cb95587b04d2c9bff3a44d32543d2.zip"
    FILENAME "014bdeb6ce0cb95587b04d2c9bff3a44d32543d2.zip"
    SHA512 775171bb19945f190d0bd081043c700c63208e88c9d2e14303e44c76075c88515096a816b908aabf0ea6ea6f5741c40c40b396a716bca8e63f680727a1a9d9d1
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE} 
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    # OPTIONS -DUSE_THIS_IN_ALL_BUILDS=1 -DUSE_THIS_TOO=2
    # OPTIONS_RELEASE -DOPTIMIZE=1
    # OPTIONS_DEBUG -DDEBUGGABLE=1
	OPTIONS
		-DAPR_ROOT=${CURRENT_INSTALLED_DIR}
		-DAPRUtil_ROOT=${CURRENT_INSTALLED_DIR}
)

vcpkg_install_cmake()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/self RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME self)
