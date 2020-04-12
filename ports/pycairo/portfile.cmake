include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/pygobject/pycairo/archive/7c3a71d1dee13cf3da729ef4c06673a2adc53ccc.zip"
    FILENAME "7c3a71d1dee13cf3da729ef4c06673a2adc53ccc.zip"
    SHA512 c0a16bf758acce12c9b83c9a0ed21f73f448ac03b2009a4b1cf4cea090cc8e11fac2e81ae84c638a925c0695e90f4c7dc32c1a44e34c6eb826574f8273a88b3f
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
		-Dpython=${PYTHON3}
)
vcpkg_install_meson()

vcpkg_copy_pdbs()

# Handle copyright
file(INSTALL ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/pycairo RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME pycairo)
