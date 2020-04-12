include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/GNOME/pygobject/archive/060dbc6be9b6e392921a7250d23a2bb4ad97d4cb.zip"
    FILENAME "060dbc6be9b6e392921a7250d23a2bb4ad97d4cb.zip"
    SHA512 6a67a9dbebef74d44360de518716eeddf21423eb2751f182100cdd3e7262173f95099d85f3ea6b2315249c8e38d342f22af410afaced764e98e2e8d6f85bbb34
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

# https://mesonbuild.com/Configuring-a-build-directory.html
vcpkg_configure_meson(
	SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
#	OPTIONS_RELEASE
#	OPTIONS_DEBUG
		--backend=ninja
		-Dpython=${PYTHON3}
		-Dpycairo=true
		-Dtests=false
	
)
vcpkg_install_meson()

vcpkg_copy_pdbs()

# Handle copyright
file(INSTALL ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/pygobject RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME pygobject)
