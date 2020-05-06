include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/nu774/mp4fpsmod/archive/aaf1ed042883968ccca45ef7121576c78e91cf10.zip"
    FILENAME "aaf1ed042883968ccca45ef7121576c78e91cf10.zip"
    SHA512 8201628eed99bb960ff0a5e76028ccdc95de67ba3ff67aee8e6e30a63c38703fc6b382460fbef21ac2f55b96349c5c13c3467815ed2bc3e180410bb70ba04326
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_install_msbuild(
    SOURCE_PATH ${SOURCE_PATH}
    PROJECT_SUBPATH "vcproj/mp4fpsmod.sln"
    SKIP_CLEAN
    LICENSE_SUBPATH COPYING
    USE_VCPKG_INTEGRATION
)

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
###
