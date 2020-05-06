include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/nu774/fdkaac/archive/130e249ebfd8983753338459880e1ae005a76290.zip"
    FILENAME "fdkaac.zip"
    SHA512 a35b8c5ecd87531cd25a6b38b992c92c1e88e51d342afbeba885f963257a73e8c1925dbca867b0958c0de0a4507c81e3500582e29fd5ac4b7088c4d99af4ae44
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_install_msbuild(
    SOURCE_PATH ${SOURCE_PATH}
    PROJECT_SUBPATH "MSVC/fdkaac.sln"
    SKIP_CLEAN
    LICENSE_SUBPATH COPYING
    USE_VCPKG_INTEGRATION
)

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
###
