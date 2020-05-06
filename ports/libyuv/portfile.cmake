include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/lemenkov/libyuv/archive/413a8d8041f1cc5a350a47c0d81cc721e64f9fd0.zip"
    FILENAME "libyuv.zip"
    SHA512 765cde868fe1827cd85e7e594eb9aff27ce7d895671731ed08edd12c87b4d9936efc40ab649c02645171c0ef2c386e447e9272b47968272a34c73db3db19867a
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
	PATCHES 
	  fix-jpeg-and-install.patch
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
)

vcpkg_install_cmake()

#vcpkg_fixup_cmake_targets()
# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/libyuv RENAME copyright)
file(INSTALL ${CURRENT_PACKAGES_DIR}/debug/share/libyuv/LIBYUVConfig-debug.cmake DESTINATION ${CURRENT_PACKAGES_DIR}/share/libyuv )
# Remove debug includes
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)
file(COPY ${CMAKE_CURRENT_LIST_DIR}/usage DESTINATION ${CURRENT_PACKAGES_DIR}/share/libyuv)

vcpkg_copy_pdbs()