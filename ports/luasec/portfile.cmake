include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/brunoos/luasec/archive/master.zip"
    FILENAME "luasec.zip"
    SHA512 66fd86d62e7ab5ce27a6d2bd6b27fddfa2e67f1d60e7142a370655733bdaac8902231ad45e6938559036c812ef0a91c6d5550da6bf3a33df5b80af6429e5ecf4
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_install_msbuild(
    SOURCE_PATH ${SOURCE_PATH}
    PROJECT_SUBPATH luasec.vcxproj
	LICENSE_SUBPATH LICENSE
	ALLOW_ROOT_INCLUDES ON
	USE_VCPKG_INTEGRATION
)

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
###
