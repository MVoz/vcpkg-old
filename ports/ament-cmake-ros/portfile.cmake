include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/ros2/ament_cmake_ros/archive/ea3bde35648a352e60e4a6d6da204afa6f8332da.zip"
    FILENAME "ea3bde35648a352e60e4a6d6da204afa6f8332da.zip"
    SHA512 862fce6b524eb77e9c36f618be373e863d3f9ba5094b87bbcd2daa2eeb811e47c2a5affe382b60b6329b0e9b721fe3dad601bfe76541e85517c379d5947d6963
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_find_acquire_program(PYTHON3)
get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
set(ENV{PATH} "$ENV{PATH};${PYTHON3_DIR}")

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}/ament_cmake_ros
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