include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/wgois/OIS/archive/27c44b0130ae202619a918c39f0c58bebbcef686.zip"
    FILENAME "OIS.zip"
    SHA512 9bb062300fa9dbc42ce1f062dc41f03c045df72480f2f24fe12c56a52b4552ce8b788c2b272bc2792f10528a2c45e6117c59dccf2b63c1590fbee7050a2645e1
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates
    OPTIONS 
      -DOIS_BUILD_DEMOS=OFF
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE.md ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
