include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/Esri/lerc/archive/cbd2f719f9b628244931976eb2706bff6ebf8cbb.zip"
    FILENAME "lerc.zip"
    SHA512 40ee492bfe9dc633618250d242a256bb9cbd15bc76ec466ecbf8b6b827a700aaf5fe86045b0e91ee92d9fdb3d1fde69d4399fc123c1d909ef3f9e8ed1845cdfa
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_install_msbuild(
    SOURCE_PATH ${SOURCE_PATH}
    PROJECT_SUBPATH "build/windows/MS_VS2017/Lerc/Lerc.vcxproj"
    SKIP_CLEAN
    LICENSE_SUBPATH LICENSE
    INCLUDES_SUBPATH include ALLOW_ROOT_INCLUDES
    USE_VCPKG_INTEGRATION
)

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
###
