include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/ament/ament_cmake/archive/e17328e1db525211916cb62ef40c30a35b81eab5.zip"
    FILENAME "e17328e1db525211916cb62ef40c30a35b81eab5.zip"
    SHA512 2cdc8a74a889e5e6138e18535c5903b5b40c94b422bb23a7ecc65a9601d0b40960f24557996004985cb5861d3ac80f24b29e4869678d911da07f470452833ebf
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_find_acquire_program(PYTHON3)
get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
set(ENV{PATH} "$ENV{PATH};${PYTHON3_DIR}")

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}/ament_cmake
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates

    OPTIONS 
      -DAMENT_CMAKE_ENVIRONMENT_GENERATION=OFF
      -DAMENT_CMAKE_ENVIRONMENT_PACKAGE_GENERATION=ON
      -DAMENT_CMAKE_ENVIRONMENT_PARENT_PREFIX_PATH_GENERATION=ON
      -DAMENT_CMAKE_SYMLINK_INSTALL=OFF
      -DAMENT_CMAKE_UNINSTALL_TARGET=OFF
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
