include(vcpkg_common_functions)

set(VCPKG_POLICY_EMPTY_PACKAGE enabled)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/Snaipe/Criterion/archive/tools/meson.zip"
    FILENAME "meson.zip"
    SHA512 aa407cf8a5171656bb5bfd0540adec5ef9cefb3a31b1c6afcc40bdd9dcfc0df2bbd00ac0eb53d24e1e73536686a54bc2b98add0cecfc6a433c40765468bf49b7
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
		-Dtests=false
		-Dtheories=disabled
)

vcpkg_install_meson()

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/criterion RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME criterion)
