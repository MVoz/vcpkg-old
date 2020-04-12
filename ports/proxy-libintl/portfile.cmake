include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/frida/proxy-libintl/archive/50bd2525261d44d80533a523873b9344a6d741c5.zip"
    FILENAME "50bd2525261d44d80533a523873b9344a6d741c5.zip"
    SHA512 e12577485267f5a21dc25905483eebabcea51b416864d72f725ebcf568979fe59cdafa35f9af16fdea7b61c82bce1c2f0d69bfaee9db9da0238705eaf1270e67
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE} 
)

vcpkg_configure_meson(
	SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
		--backend=ninja
)

vcpkg_install_meson()

vcpkg_copy_pdbs()

# Handle copyright
file(INSTALL ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/proxy-libintl RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME proxy-libintl)
