include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/atolab/rmw_cyclonedds/archive/428072358e1099293d7962c074e754a1390dfcb1.zip"
    FILENAME "428072358e1099293d7962c074e754a1390dfcb1.zip"
    SHA512 2c78f7cca329b2cc1877a38be680de09d0137ae854910790de84ab0f9f75c7d428825543613449cdf37155fc3ff8bb28ca3e106c541f62b54c8e9201f32edf2c
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_find_acquire_program(PYTHON3)
get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
set(ENV{PATH} "$ENV{PATH};${PYTHON3_DIR}")

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}/cyclonedds_cmake_module
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates

    OPTIONS 
      -DAMENT_CMAKE_ENVIRONMENT_GENERATION=OFF
      -DAMENT_CMAKE_ENVIRONMENT_PACKAGE_GENERATION=ON
      -DAMENT_CMAKE_ENVIRONMENT_PARENT_PREFIX_PATH_GENERATION=ON
      -DAMENT_CMAKE_SYMLINK_INSTALL=OFF
      -DAMENT_CMAKE_UNINSTALL_TARGET=OFF
      -DBUILD_TESTING=OFF
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###