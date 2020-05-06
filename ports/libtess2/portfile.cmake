include(vcpkg_common_functions)

#msbuild https://github.com/bormgruppe/libtess2
vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/schmidh/tess2/archive/50f22eee9b4cb23fd7ef5ec69d67b115e8c24c1c.zip"
    FILENAME "libtess2-0.zip"
    SHA512 ef8252f2278384a9e98e4812b53ca0ef2cd08361b1134a194c29910aa08a1c1430af5c435a76004384ca7ec0ba98b9df447d63cb429162c58ce400f20fb87063
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates

#    OPTIONS 
#      -D =OFF # automatic templates
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE.txt ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
