include(vcpkg_common_functions)

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/MmgTools/mmg/archive/1957d7054dbebc31d786c3bbcae10329706e45bd.zip"
    FILENAME "mmg.zip"
    SHA512 a791280fb45247a52b73ebae7caf87437c584c15c1a0d827afe48eb3ccb999a935a86745aee58c51037ab3b3f21f36fd1b52f674efbda30578eee40d74407640
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
      -DBUILD_TESTING:BOOL=OFF
#      -DELAS_DIR:PATH=
#      -DELAS_INCLUDE_DIR:PATH=ELAS_INCLUDE_DIR-NOTFOUND
#      -DELAS_LIBRARY:FILEPATH=ELAS_LIBRARY-NOTFOUND
      -DTEST_LIBMMG:BOOL=OFF
      -DTEST_LIBMMG2D:BOOL=OFF
      -DTEST_LIBMMG3D:BOOL=OFF
      -DTEST_LIBMMGS:BOOL=OFF
      -DUSE_SCOTCH=OFF # enable or disable the SCOTCH library link
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
