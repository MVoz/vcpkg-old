include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/ros2-dotnet/dotnet_cmake_module/archive/100d92be68f679a7b7d1c19e01e0ea1f52bccca6.zip"
    FILENAME "dotnet_cmake_module.zip"
    SHA512 e2396a55b18d5ceb531863ea3860a47176194811cc23a6aa213157c1734f7ceaf55bd6f456e33f0b37f5c949bc87acd8a7615eb1994fe5fe70a3b98ac18b5307
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_find_acquire_program(PYTHON3)
get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
set(ENV{PATH} "$ENV{PATH};${PYTHON3_DIR}")

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
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
configure_file(${SOURCE_PATH}/LICENSE.GPL3 ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
