
include(vcpkg_common_functions)

set(VCPKG_POLICY_EMPTY_PACKAGE enabled)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/ntirpankar/petsc_3_10_3_goparots/archive/620af54c95675e4d82720c47b14b7052f4948f80.zip"
    FILENAME "620af54c95675e4d82720c47b14b7052f4948f80.zip"
    SHA512 54147232324e22be2ff01a44ea96fd3069ba495a8891d0e486d7859b40cb2c0a17b0a2995fcf6a3395f6215d6d9a4d9a4b5beed2a3c8f2de55c61555835bca00
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
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/petsc_parots RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME petsc_parots)
