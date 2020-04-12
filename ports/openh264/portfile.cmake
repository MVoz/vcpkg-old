include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/cisco/openh264/archive/c2e4abc16641a2c14cec48aef92940503116f4bb.zip"
    FILENAME "openh264.zip"
    SHA512 b70cdacea7b8bf05f1444c94b37756906644ab3b35a6653ce17c0c93cdeb7c79734f845dea701daf3ee9aad7120ff660c57e4d38759ecf3c715c47bc8040e019
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_find_acquire_program(NASM)
get_filename_component(NASM_DIR "${NASM}" DIRECTORY)
set(ENV{PATH} "$ENV{PATH};${NASM_DIR}")

### https://mesonbuild.com/Configuring-a-build-directory.html
vcpkg_configure_meson(
	SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
		--backend=ninja
)

vcpkg_install_meson()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
