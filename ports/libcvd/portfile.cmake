include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/edrosten/libcvd/archive/64de52005dfae5d34a3a7f9b235e8f842968a68f.zip"
    FILENAME "64de52005dfae5d34a3a7f9b235e8f842968a68f.zip"
    SHA512 52a761a57eb076a041ad3bf9be81e81dbf3936525f4fd11d5c478922914d5f1dc5c9037a90ec71a66d0d648c2465b59502ffd129501c732072b9d51bd1f95af9
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
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
