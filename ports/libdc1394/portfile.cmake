include(vcpkg_common_functions)
include(CMakePrintHelpers)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/aimotive/libdc1394-cmake/archive/b7d7803ba752c87c9321f13b0419a44594ddfcdf.zip"
    FILENAME "b7d7803ba752c87c9321f13b0419a44594ddfcdf.zip"
    SHA512 b8b80de2fea4b97fdc6708f07627aa20451ac1aaad09c08a375dace4fab8521a67a8dc62b184fba806161c5c2f219e3f7ed84b2b3453f70468fbc715b8729a2b
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
#    DISABLE_PARALLEL_CONFIGURE
    OPTIONS_DEBUG # automatic templates
        -DDISABLE_INSTALL_HEADERS=ON # automatic templates
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/README.md ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
