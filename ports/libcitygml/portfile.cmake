include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/jklimke/libcitygml/archive/e301c770183cd4c01faaf6a8e2e0065915149f99.zip"
    FILENAME "libcitygml.zip"
    SHA512 4876ea89c67b28f3568970b13148f1995ef615e3f3b63b983deb46809960dc22e1dbddcabece20dd2239ad5a795ef474b2b92d29058be92e3e08e814fb392929
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
#      -DLIBCITYGML_DYNAMIC:BOOL=ON
      -DLIBCITYGML_OSGPLUGIN:BOOL=OFF
#      -DLIBCITYGML_STATIC_CRT:BOOL=ON
      -DLIBCITYGML_TESTS:BOOL=OFF
      -DLIBCITYGML_USE_GDAL:BOOL=ON
#      -DXERCESC_STATIC:BOOL=ON
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
