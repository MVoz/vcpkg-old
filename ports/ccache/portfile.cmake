include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/thedmd/ccache/archive/7740a5ccfa380031255d128e683e369129c681d2.zip"
    FILENAME "7740a5ccfa380031255d128e683e369129c681d2.zip"
    SHA512 d30c04325572daa79069f6c95d88827e523c33664b22b3cad74cf553be2da5ca35ee7871f55ca584a346cda38c1c951979ceb5d557d5e591e9a49b17083ce08b
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE} 
)

vcpkg_install_msbuild(
    SOURCE_PATH ${SOURCE_PATH}
    PROJECT_SUBPATH project/ccache-win32.sln
	SKIP_CLEAN
	LICENSE_SUBPATH GPL-3.0.txt
	ALLOW_ROOT_INCLUDES ON
	USE_VCPKG_INTEGRATION
)

file(REMOVE ${CURRENT_PACKAGES_DIR}/debug/lib/zlib.lib)
file(REMOVE ${CURRENT_PACKAGES_DIR}/lib/zlib.lib)