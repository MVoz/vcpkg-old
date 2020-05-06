include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/BurningEnlightenment/libb2/archive/ded229baabe4e526279052dc1cc0c3979880adac.zip"
    FILENAME "libb2.zip"
    SHA512 61dc3b2280ee0d5ce3d5470ef854d1279e4949db97c07bf6ebd4592ed9fc885f2144f02c16dc43a60750397fc53c1989716a2c9b7cb4fec996c1faa8fee5c5e1
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
      -DBLAKE2_BUILD_TESTS:BOOL=OFF
#      -DBLAKE2_FAT_BINARIES:BOOL=ON
#      -DBLAKE2_SHARED_OBJECT:BOOL=OFF
#      -DBLAKE2_UTILIZE_OPENMP:BOOL=ON
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
