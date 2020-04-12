include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/beltoforion/muparserx/archive/08cbfc3e9087e8fceafc85c8fdb7e034e1c35943.zip"
    FILENAME "08cbfc3e9087e8fceafc85c8fdb7e034e1c35943.zip"
    SHA512 31cfdbde11e3b855a09da5da812f4a560531b6ab3378a7d6b11977dd15f43abc448de804788c19ea8baab37dff296b3c4915742653082f3eefe9af16d80d36dc
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
#    DISABLE_PARALLEL_CONFIGURE
    OPTIONS 
        -DBUILD_EXAMPLES=OFF
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled)
vcpkg_copy_pdbs()
configure_file(${SOURCE_PATH}/License.txt ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)

###
