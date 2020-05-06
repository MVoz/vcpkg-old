include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/nu774/cafdec/archive/609098b0206fc2156a9be140e96fe1f3802ab185.zip"
    FILENAME "609098b0206fc2156a9be140e96fe1f3802ab185.zip"
    SHA512 9e18161a1dbefb2bef125373969606438d88d68b82c1cbc528db74ab7ddae2d01ba553c31ce26caff2cd0b95f65d6e5967a02a443cb319661a84bb951572acde
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_install_msbuild(
    SOURCE_PATH ${SOURCE_PATH}
    PROJECT_SUBPATH "cafdec.vcxproj"
    SKIP_CLEAN
    LICENSE_SUBPATH README.rst
    USE_VCPKG_INTEGRATION
)

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
###
