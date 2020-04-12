include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/Omnirobotic/libccd/archive/Omnirobotic.zip"
    FILENAME "libccd.zip"
    SHA512 04de2cb641476712e18ae5ebaf3fdd32f64f4ce5c6799004d8747c7e7ae79230973deb6f1219d8e7aa49da96db0cb88d2b4cee220f104fe49229a66bd31453e6
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
      -DBUILD_DOCUMENTATION:BOOL=OFF
      -DBUILD_TESTING:BOOL=OFF
      -DCCD_HIDE_ALL_SYMBOLS:BOOL=OFF
      -DENABLE_DOUBLE_PRECISION:BOOL=OFF
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/BSD-LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
