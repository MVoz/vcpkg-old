include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/videolan/dav1d/archive/3a77c57b0ca06c613fea96afe63d2870f513e97f.zip"
    FILENAME "dav1d.zip"
    SHA512 786c93ead7a2b37390cf3820c34c1c5cb04e9678b8bb847eb1b697c76b2cc7961224239e1b2bc9bf9f03a1ed4aae0956ede3fb93d67c079126a8cd08135456bd
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
      -Denable_tests=false
	  -Dtestdata_tests=false
)
vcpkg_install_meson()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/COPYING ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)

