

include(vcpkg_common_functions)

set(VCPKG_POLICY_EMPTY_PACKAGE enabled)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/wallarm/libwallarmmisc/archive/03a3a18717dc25b9345c2217a2f751a3611b2d3f.zip"
    FILENAME "03a3a18717dc25b9345c2217a2f751a3611b2d3f.zip"
    SHA512 88043c719f0bdfb932f978f97a327206e3d7531b89291b5eeb21dd58f65d3bcc324d41584638efba45da3b05f45f76d1b4b7691fcabec8bcd4ded0c27525f51f
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
#    PATCHES
#        001_port_fixes.patch
#        002_more_port_fixes.patch
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
#    OPTIONS 
#        -D =ON
#        -D =OFF
#    OPTIONS_RELEASE
#        -D =ON
#        -D =OFF
#    OPTIONS_DEBUG
#        -D =ON
#        -D =OFF
)

vcpkg_install_cmake()

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/libwallarmmisc RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME libwallarmmisc)
