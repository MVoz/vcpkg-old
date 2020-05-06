

include(vcpkg_common_functions)

set(VCPKG_POLICY_EMPTY_PACKAGE enabled)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/fenbf/Intel-Parallel-STL-Tests/archive/e01c7913a99a918214fd900968c66ba4f704c532.zip"
    FILENAME "e01c7913a99a918214fd900968c66ba4f704c532.zip"
    SHA512 a5bb6d77bc31aafdcabc49e64a276279c304fe3eca1cae6c958eaf28afb753b4277960eed5136aa1c3ab8b7ba196a46d68ef22fcd74b3fc8edb28feb7ab8737c
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
#    PATCHES
#        001_port_fixes.patch
#        002_more_port_fixes.patch
)

vcpkg_install_msbuild(
    SOURCE_PATH ${SOURCE_PATH}
    PROJECT_SUBPATH "Intel Parallel STL Tests.sln"
    USE_VCPKG_INTEGRATION
)


# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME Intel-Parallel-STL-Tests)
