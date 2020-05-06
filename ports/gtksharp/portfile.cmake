include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/GLibSharp/GtkSharp/archive/c58a32158edf1af45a46cea1b6c82d91bb09b281.zip"
    FILENAME "c58a32158edf1af45a46cea1b6c82d91bb09b281.zip"
    SHA512 e95bf1165bceff355cdf1adf4a86277203543e00b7a49ac8ca79e13a1172b69f5ed40e74b56642918b3bb6031b681d875033ad11fa54dec57f427602a9cae385
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
		-Dinstall=true
)

vcpkg_install_meson()

vcpkg_copy_pdbs()

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/gtksharp RENAME copyright)

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME gtksharp)
