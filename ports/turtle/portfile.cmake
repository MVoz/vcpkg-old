include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/mat007/turtle/releases/download/v1.3.1/turtle-1.3.1.tar.gz"
    FILENAME "turtle-1.3.1.tar.gz"
    SHA512 b60ddda8092d83f43037411f7442a4cce02bb460674a9977909d4070103806a9d4a54d2e5bf3a525fdb92f9a0d8412692eac574945fdcf38d98220a04127a804
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
	NO_REMOVE_ONE_LEVEL
)

if(NOT EXISTS SOURCE_PATH)
	file(DOWNLOAD https://raw.githubusercontent.com/mesonbuild/turtle/1.3.1/meson.build ${SOURCE_PATH}/meson.build
		TIMEOUT 15
		EXPECTED_HASH MD5=87f4d56fdac86063ba850f09cfab3810
		TLS_VERIFY ON
	)
endif()
 
# https://mesonbuild.com/Configuring-a-build-directory.html
vcpkg_configure_meson(
	SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
		--backend=ninja
)

# Handle copyright
file(INSTALL ${SOURCE_PATH}/doc/index.html DESTINATION ${CURRENT_PACKAGES_DIR}/share/turtle RENAME copyright)

file(INSTALL ${SOURCE_PATH}/include DESTINATION ${CURRENT_PACKAGES_DIR})

vcpkg_install_meson()

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME turtle)
