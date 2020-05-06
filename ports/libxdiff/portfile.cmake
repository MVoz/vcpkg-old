#vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/opencor/libxdiff/archive/a858a2d5ee76616e01ecc078059f31777eac641e.zip"
    FILENAME "libxdiff.zip"
    SHA512 94deecbce0a7ddd14beeed84f7f1267b1a12a066f76269bb1e0487f0824e0d71b41f59e06936ffd4ac5105362f06c3b49c617c380ec0c1edfda07ef51757abba
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
      -DENABLE_TESTS:BOOL=OFF
      -DENABLE_TOOLS:BOOL=ON
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/COPYING ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
