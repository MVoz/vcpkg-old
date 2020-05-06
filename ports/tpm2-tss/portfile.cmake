include(vcpkg_common_functions)

#vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/tpm2-software/tpm2-tss/archive/8b635f806f002fac0167fa730f4f761cb3ada724.zip"
    FILENAME "8b635f806f002fac0167fa730f4f761cb3ada724.zip"
    SHA512 b4f460064403a8c67d815048c3d4f17cc0caea01280bcda5ed5d6ec5714082b9c35f7d7a61a2cc301dde0e1556a45f193ee5207e8c6d0253e9a86ac2659e979e
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
#    PATCHES
#      001_tpm2-tss_fixes.patch
#      001_tpm2-tss_patch.patch
)

vcpkg_install_msbuild(
    SOURCE_PATH ${SOURCE_PATH}
    PROJECT_SUBPATH "tpm2-tss.sln"
#    TARGET restore
    SKIP_CLEAN
#    RELEASE_CONFIGURATION Release_x86${MPG123_CONFIGURATION_SUFFIX}
#    DEBUG_CONFIGURATION Debug_x86${MPG123_CONFIGURATION_SUFFIX}
    LICENSE_SUBPATH LICENSE
    INCLUDES_SUBPATH include 
	ALLOW_ROOT_INCLUDES
#    ALLOW_ROOT_INCLUDES ON
    USE_VCPKG_INTEGRATION
)

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
###
