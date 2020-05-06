include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://gitlab.freedesktop.org/tpm/fontconfig/-/archive/meson-rebased-fc-lang-python-port/fontconfig-meson-rebased-fc-lang-python-port.tar.gz"
    FILENAME "fontconfig-meson-rebased-fc-lang-python-port.tar.gz"
    SHA512 42996ec16828f598f0fa507416694f4711add53dbb9fac3faecbd52adcc8ce47cc8a3f06eb8225cb9dd4031ad8f1dc0534df320d3727053747e4b79520a97609
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_acquire_msys(MSYS_ROOT)
set(GPERF ${MSYS_ROOT}/usr/bin/gperf.exe)

#file(DOWNLOAD
#    https://raw.githubusercontent.com/wingtk/gvsbuild/master/patches/fontconfig/config.h
#    ${SOURCE_PATH}/config.h
#    EXPECTED_MD5 d5cc0296eac03a5941a6e302f4d854f5
#	TIMEOUT 60
#	LOG download.log
#    SHOW_PROGRESS
#)

#file(COPY ${CMAKE_CURRENT_LIST_DIR}/config.h DESTINATION ${SOURCE_PATH})

# https://mesonbuild.com/Configuring-a-build-directory.html
vcpkg_configure_meson(
	SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
		--backend=ninja
)

vcpkg_install_meson()

vcpkg_copy_pdbs()

# Handle copyright
file(INSTALL ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/fontconfig RENAME copyright)
file(GLOB_RECURSE EXE ${CURRENT_PACKAGES_DIR}/*.exe)
file(GLOB_RECURSE PDB ${CURRENT_PACKAGES_DIR}/*.pdb)
file(REMOVE_RECURSE ${EXE} ${PDB})
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include ${CURRENT_PACKAGES_DIR}/debug/share)
# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME fontconfig)
