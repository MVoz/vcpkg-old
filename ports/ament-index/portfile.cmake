include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/ament/ament_index/archive/0dba2f42c7f9b18a676c96d5643f26d5213513dd.zip"
    FILENAME "0dba2f42c7f9b18a676c96d5643f26d5213513dd.zip"
    SHA512 941242cf91419f52f071270fcf7c61491820558a7486e91907eaeb1deee3b08ba20d875eea96eb178a25978bbff6f02f437cb6d57a03ef1179b58458b345a0ab
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_find_acquire_program(PYTHON3)
get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
set(ENV{PATH} "$ENV{PATH};${PYTHON3_DIR}")

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}/ament_index_cpp
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates

    OPTIONS 
      -DAMENT_CMAKE_ENVIRONMENT_GENERATION=OFF
      -DAMENT_CMAKE_ENVIRONMENT_PACKAGE_GENERATION=ON
      -DAMENT_CMAKE_ENVIRONMENT_PARENT_PREFIX_PATH_GENERATION=ON
      -DAMENT_CMAKE_SYMLINK_INSTALL=OFF
      -DAMENT_CMAKE_UNINSTALL_TARGET=OFF
      -DBUILD_TESTING=OFF
      -D_gtest_header_file:FILEPATH=${CURRENT_INSTALLED_DIR}/include
#	  -Dgtest_vendor_DIR:PATH=
#	  -D_gtest_src_file:FILEPATH=
#	  -Dament_copyright_BIN:FILEPATH= #install/bin/ament_copyright.exe
#	  -Dament_cppcheck_BIN:FILEPATH= #install/bin/ament_cppcheck.exe
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
