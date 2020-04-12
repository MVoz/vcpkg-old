include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/cginternals/libzeug/archive/cf71d3631ba7df69505d4c88785ffa6919cd8648.zip"
    FILENAME "libzeug.zip"
    SHA512 fa9b6d03384541b4ae41bc702742ec18537c2c9b8ec0bd8dab1517a2911600ed075a4693df67ab54c7ab6f68ddb459f998ffe29707733e0bd76b7de98fa3e986
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
#      -DINSTALL_MSVC_REDIST_FILEPATH:FILEPATH=
      -DOPTION_BUILD_DOCS:BOOL=OFF
      -DOPTION_BUILD_EXAMPLES:BOOL=OFF
      -DOPTION_BUILD_TESTS:BOOL=OFF
#      -DOPTION_BUILD_WITH_STD_REGEX:BOOL=ON
#      -DOPTION_BUILD_WITH_STD_THREAD:BOOL=OFF
#      -DOPTION_SELF_CONTAINED:BOOL=OFF
#      -DQt5Core_DIR:PATH=
#      -DQt5Gui_DIR:PATH=
#      -DQt5Widgets_DIR:PATH=
      -Dgmock_build_tests:BOOL=OFF
      -Dgtest_build_samples:BOOL=OFF
      -Dgtest_build_tests:BOOL=OFF
      -Dgtest_force_shared_crt:BOOL=OFF
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
