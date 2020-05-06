include(vcpkg_common_functions)

#vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/jackaudio/jack2/archive/dad4b5702782eef3bd66e3c3f4fefaaae3571208.zip"
    FILENAME "jack2.zip"
    SHA512 318fb2dbabf9e4adb68fe3074f11d29b43def96f05cba33e35961575455b20801ac3499baf796917aeeb31155ff4239633c4ea2aca8c90378601c7bdffb58ae5
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

# Install headers and a statically built JackWeakAPI.c
file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH})

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
)

vcpkg_install_cmake()

# Remove duplicate headers
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

# Handle copyright
file(INSTALL ${SOURCE_PATH}/AUTHORS.rst DESTINATION ${CURRENT_PACKAGES_DIR}/share/jack2 RENAME copyright)
