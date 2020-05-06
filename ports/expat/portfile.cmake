include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/libexpat/libexpat/releases/download/R_2_2_6/expat-2.2.6.tar.bz2"
    FILENAME "expat-2.2.6.tar.bz2"
    SHA512 dbfb635a5fe7b190722664263a0dd437b512fdf519bc53bd4905567f4bfb4b1e89a021562da63df8cacd48b706d1dea60ccde47f279e57400ad3c846b6e9c4e6
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE} 
)

if(NOT EXISTS SOURCE_PATH)
	file(DOWNLOAD https://raw.githubusercontent.com/mesonbuild/expat/2.2.6/meson.build ${SOURCE_PATH}/meson.build
		TIMEOUT 15
		EXPECTED_HASH MD5=a8f25b1e8ad44c525c5b5b60bfe5d3b9
		TLS_VERIFY ON
	)
	file(DOWNLOAD https://raw.githubusercontent.com/mesonbuild/expat/2.2.6/meson_options.txt ${SOURCE_PATH}/meson_options.txt
		TIMEOUT 15
		EXPECTED_HASH MD5=00cbf928b4a250ea4a63c9b1502bd9eb
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
file(INSTALL ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/expat RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME expat)
