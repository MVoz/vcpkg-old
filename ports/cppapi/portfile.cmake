include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/jpakkane/cppapi/archive/5b4e7d5a308487fb3129cfae27e325879fb974a9.zip"
    FILENAME "5b4e7d5a308487fb3129cfae27e325879fb974a9.zip"
    SHA512 3326a723c4166f35f501c90d35e06048af491d8d5e0411b2ea63b573f276906a30cdee7f8822a4563c848074d692b821c1170e41bfa4ff3f57013fea6b2aec48
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
)

vcpkg_install_meson()

vcpkg_copy_pdbs()

# Handle copyright
file(INSTALL ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/cppapi RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME cppapi)
