
#vcpkg_check_linkage(ONLY_STATIC_LIBRARY) ## = ## VCPKG_LIBRARY_LINKAGE=static ## = ## BUILD_STATIC_LIBS=ON
include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/zeroc-ice/ice/archive/1389c577b783cb9bf6827d9b889b35873a1f9f44.zip"
    FILENAME "1389c577b783cb9bf6827d9b889b35873a1f9f44.zip"
    SHA512 6c987130bd60a5000a9acc99e0c2d669cbbda53dc09824ca0a3166c2d7e79454f8f92ee571409cfd51b16375afe095012de7393412e80f3794cdfb1525f289a1
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_install_msbuild(
    SOURCE_PATH ${SOURCE_PATH}
    TARGET restore
    PROJECT_SUBPATH "cpp/msbuild/ice.v140.sln"
    SKIP_CLEAN
    LICENSE_SUBPATH LICENSE
    INCLUDES_SUBPATH cpp/include ALLOW_ROOT_INCLUDES
    USE_VCPKG_INTEGRATION
)

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
###
