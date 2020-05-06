include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/kornelski/dssim/archive/dssim1-c.zip"
    FILENAME "dssim1-c.zip"
    SHA512 c9bc97913c8646e796daa60985f4e94bcaed66db3333fd19fb18089ddc3a6a6fe5be82f4f411b71f1bc8d3b49fd4fe0985f75e34910cc1f2569540edb550a898
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

# https://mesonbuild.com/Configuring-a-build-directory.html
vcpkg_configure_meson(
	SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
		--backend=ninja
		--wrap_mode nofallback
		--auto-features enabled 
		--wrap-mode nodownload
)

vcpkg_install_meson()

vcpkg_copy_pdbs()

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/dssim RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME dssim)
