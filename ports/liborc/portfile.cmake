include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://gitlab.freedesktop.org/gstreamer/orc/-/archive/fd88dd9e3c44303fbc58d89f242c40ba1fbcf0e6/orc-fd88dd9e3c44303fbc58d89f242c40ba1fbcf0e6.tar.gz"
    FILENAME "orc-fd88dd9e3c44303fbc58d89f242c40ba1fbcf0e6.tar.gz"
    SHA512 135283bbfb98ca4e5b7864b2a8c11376681051958ca2dcafcb6de1f5caa864f23b7ace1530a89478ebaf5ac0452cfd8555d108e1b1fdbf6d31b337af04b2c67c
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

### https://mesonbuild.com/Configuring-a-build-directory.html
vcpkg_configure_meson(
	SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
		--backend=ninja
)

vcpkg_install_meson()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/COPYING ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
