include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/ebassi/mutest/archive/4898363ca962e03b0a26f9c4a07bffd2381b0022.zip"
    FILENAME "mutest.zip"
    SHA512 19e18d4aab065b98e8d0964eb03d24825bf0b67c79c9a961886e06a458564f58ec9fb4fa966bbcf8c0d974e732fe943a1f8eabf1a1a47559ad335f53884a8f84
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
configure_file(${SOURCE_PATH}/LICENSE.txt ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
