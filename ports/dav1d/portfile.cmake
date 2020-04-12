include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/videolan/dav1d/archive/1306791698acc4983ce85901318eeb2a2a829314.zip"
    FILENAME "1306791698acc4983ce85901318eeb2a2a829314.zip"
    SHA512 74240d01171665d3f51b1c48bdfa3b81f8b2dfd4d4a2aaa28730f149728cd593431fc8542b9e177f7478bec72bb2fa02579fd9d198d32df28d026472b29df726
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_find_acquire_program(NASM)
get_filename_component(NASM_EXE_PATH ${NASM} DIRECTORY)
set(ENV{PATH} "$ENV{PATH};${NASM_EXE_PATH}")

# https://mesonbuild.com/Configuring-a-build-directory.html
vcpkg_configure_meson(
	SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
		--backend=ninja
)
vcpkg_install_meson()

vcpkg_copy_pdbs()

# Handle copyright
file(INSTALL ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/dav1d RENAME copyright)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin)
file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/tools/dav1d)
file(RENAME ${CURRENT_PACKAGES_DIR}/debug/bin ${CURRENT_PACKAGES_DIR}/tools/dav1d)
# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME dav1d)

