# Common Ambient Variables:
#   CURRENT_BUILDTREES_DIR    = ${VCPKG_ROOT_DIR}\buildtrees\${PORT}
#   CURRENT_PACKAGES_DIR      = ${VCPKG_ROOT_DIR}\packages\${PORT}_${TARGET_TRIPLET}
#   CURRENT_PORT_DIR          = ${VCPKG_ROOT_DIR}\ports\${PORT}
#   PORT                      = current port name (zlib, etc)
#   TARGET_TRIPLET            = current triplet (x86-windows, x64-windows-static, etc)
#   VCPKG_CRT_LINKAGE         = C runtime linkage type (static, dynamic)
#   VCPKG_LIBRARY_LINKAGE     = target library linkage type (static, dynamic)
#   VCPKG_ROOT_DIR            = <C:\path\to\current\vcpkg>
#   VCPKG_TARGET_ARCHITECTURE = target architecture (x64, x86, arm)
# 
# 

### https://mesonbuild.com/Configuring-a-build-directory.html

###

include(vcpkg_common_functions)

set(VCPKG_POLICY_EMPTY_PACKAGE enabled)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/OpenHMD/OpenHMD/archive/406a4cff68c5cb13c0628ddd798ad7463108cb46.zip"
    FILENAME "406a4cff68c5cb13c0628ddd798ad7463108cb46.zip"
    SHA512 50df34189434929f1995f0c013b987af3fc8d55af7732423c1936a41be2b8db3a7763b44a7800ef1e45938fcea20b93465da925684b69e832e1419ff3e1e2603
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
#    PATCHES
#        001_port_fixes.patch
#        002_more_port_fixes.patch
)

vcpkg_configure_meson(
	SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
		--backend=ninja
)

vcpkg_install_meson()

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/openhmd RENAME copyright)
file(GLOB_RECURSE HIDAPI ${CURRENT_PACKAGES_DIR}/hidapi*)
file(REMOVE_RECURSE ${HIDAPI})

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME openhmd)
