include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "http://zlib.net/fossils/zlib-1.2.11.tar.gz"
    FILENAME "zlib-1.2.11.tar.gz"
    SHA512 73fd3fff4adeccd4894084c15ddac89890cd10ef105dd5e1835e1e9bbb6a49ff229713bd197d203edfa17c2727700fce65a2a235f07568212d820dca88b528ae
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE} 
)

if(NOT EXISTS SOURCE_PATH)
	file(DOWNLOAD https://raw.githubusercontent.com/mesonbuild/zlib/1.2.11/meson.build ${SOURCE_PATH}/meson.build
		TIMEOUT 15
		EXPECTED_HASH MD5=a98c9c44bd3b82fa4bdfe4a5040549ec
		TLS_VERIFY ON
	)
	file(DOWNLOAD https://raw.githubusercontent.com/mesonbuild/zlib/1.2.11/meson_options.txt ${SOURCE_PATH}/meson_options.txt
		TIMEOUT 15
		EXPECTED_HASH MD5=3d936e5ad1add312c7cc6f78d44e8c10
		TLS_VERIFY ON
	)
endif()
 
# https://mesonbuild.com/Configuring-a-build-directory.html
vcpkg_configure_meson(
	SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
		--backend=ninja
)

vcpkg_install_meson()

vcpkg_copy_pdbs()

# Handle copyright
file(INSTALL ${SOURCE_PATH}/ChangeLog DESTINATION ${CURRENT_PACKAGES_DIR}/share/zlib RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME zlib)
