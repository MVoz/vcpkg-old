include(vcpkg_common_functions)

if(VCPKG_CMAKE_SYSTEM_NAME OR VCPKG_CMAKE_SYSTEM_NAME STREQUAL "WindowsStore")
	message(FATAL_ERROR "\n-- Build port ${PORT} only TESTED Windows Desktop"
	"\n--"
	)
endif()

vcpkg_download_distfile(ARCHIVE
    URLS "https://soplex.zib.de/download/release/soplex-4.0.1.tgz"
    FILENAME "soplex-4.0.1.tgz"
    SHA512 c47364105fd6e1ed4cc70364f8409c0d068b0e19025002aa1724212efcb2f912d24d8464e122281248da0e1451fdd20a31ea61b9744318e2c0bf20b773d66aaa
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

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/bin)

# Handle copyright
file(INSTALL ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/soplex RENAME copyright)
