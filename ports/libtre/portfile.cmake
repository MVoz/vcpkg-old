include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/laurikari/tre/archive/6fb7206b935b35814c5078c20046dbe065435363.zip"
    FILENAME "6fb7206b935b35814c5078c20046dbe065435363.zip"
    SHA512 2a6032567ffda099894811b2b2aba0e16605606357f2c3b0b51963714993eb0fd5804094abb47f467a7cc4b1cebf3b7b3fd51868c65cb5b44bf3866ab5fdeeff
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE} 
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE} 
)

## https://github.com/Voskrese/vcpkg/blob/master/scripts/cmake/vcpkg_replace_string.cmake
#vcpkg_replace_regex(${SOURCE_PATH}/SMP/libgpg-error.vcxproj ".\.\.\\msvc" "msvc")

vcpkg_install_msbuild(
    SOURCE_PATH ${SOURCE_PATH}
    PROJECT_SUBPATH vcbuild/tre.vcxproj
	SKIP_CLEAN
	LICENSE_SUBPATH LICENSE
	ALLOW_ROOT_INCLUDES ON
	USE_VCPKG_INTEGRATION
)

