include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/cesarizu/freealut/archive/e7dc5c297e8223a85f9b848c0ff56970db6344b6.zip"
    FILENAME "freealut.zip"
    SHA512 976e1e1c8d3effbabdae0b1a0879765c7777a5e7c310e4a3d27a133f8a3e50777458782f70d6e8f2151889a535eebf76d10937c791011cb55f093ebc0c6e311b
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
      -DBUILD_EXAMPLES:BOOL=OFF
#      -DBUILD_DYNAMIC:BOOL=ON
#      -DBUILD_STATIC:BOOL=OFF
      -DBUILD_TESTS:BOOL=OFF
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/COPYING ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
