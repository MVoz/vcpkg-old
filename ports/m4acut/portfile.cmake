include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/nu774/m4acut/archive/f8b88230195da0f7c1179124dccd188ae80afc0a.zip"
    FILENAME "f8b88230195da0f7c1179124dccd188ae80afc0a.zip"
    SHA512 1bff542eea8fdac03133b56122923d36766310e87e257434e48ab22da59215c91d4a2df7bc0e882192575c38100d244deb80b768c45c43dae531be6393e33174
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_install_msbuild(
    SOURCE_PATH ${SOURCE_PATH}
    PROJECT_SUBPATH "MSVC/m4acut.vcxproj"
    SKIP_CLEAN
    LICENSE_SUBPATH COPYING
    USE_VCPKG_INTEGRATION
)

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
###
