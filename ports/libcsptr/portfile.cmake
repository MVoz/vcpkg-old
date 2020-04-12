include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/Snaipe/libcsptr/archive/5bc7aad8cab5f8d9d64308dcffb1a397e86a6b0c.zip"
    FILENAME "5bc7aad8cab5f8d9d64308dcffb1a397e86a6b0c.zip"
    SHA512 3712feedefb030489c9d413c3addbd2376806a957d7573f2ef849608f53854a4abef83f1eb4153307d95d555f2a55c9c40cb69916f4e486d125f08c9aa56f878
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
	OPTIONS
		-DLIBCSPTR_TESTS=OFF
)

vcpkg_install_cmake()

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/libcsptr RENAME copyright)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)
# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME libcsptr)
