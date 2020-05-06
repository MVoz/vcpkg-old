# port 1 https://github.com/centricular/freetype2
# port 2 https://github.com/mesonbuild/freetype2/tree/2.9.1
include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/centricular/freetype2/archive/10517d50b4fd1513043ab8363973f3244d8ce561.zip"
    FILENAME "10517d50b4fd1513043ab8363973f3244d8ce561.zip"
    SHA512 4d5632d2b6225789cfb4718b198320d1ef1fbe63438f729c3833480f9987b1bbb258334e0a0e41f187748ea47de5c8e37e03ee5dd68a4d188cb9af33c9a098f4
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
		-Dpng=enabled
		-Dbzip2=enabled
		-Dzlib=enabled
		-Dharfbuzz=enabled

		-Dpython=${PYTHON3}
	
)
vcpkg_install_meson()

vcpkg_copy_pdbs()

# Handle copyright
file(INSTALL ${SOURCE_PATH}/README DESTINATION ${CURRENT_PACKAGES_DIR}/share/freetype2 RENAME copyright)
#file(REMOVE ${CURRENT_PACKAGES_DIR}/*/)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME freetype2)
