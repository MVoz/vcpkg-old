include(vcpkg_common_functions)

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/vovkos/graco/archive/e69eda4b8036447ca5e3286b0c584dc5aff02ae0.zip"
    FILENAME "graco.zip"
    SHA512 84453887fd12edba428697db1323f61f4d048a96bfe381907892c2ea5dc9451e26d5e8711a029d8aa95edd0de1f09729b124f18e8405b34c1e3c293a9ce26ddd
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_find_acquire_program(DOXYGEN)
get_filename_component(DOXYGEN_DIR "${DOXYGEN}" DIRECTORY)
set(ENV{PATH} "$ENV{PATH};${DOXYGEN_DIR}")

#LUA_INC_DIR LUA_LIB_DIR LUA_LIB_NAME AXL_CMAKE_DIR RAGEL_EXE 7Z_EXE

#-- Dependency
#--     RAGEL_EXE:           E:/tools/vcpkg/installed/x64-windows/bin/ragel.exe
#-- Lua paths:

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates

    OPTIONS 
      -DAXL_CMAKE_DIR=${CURRENT_INSTALLED_DIR}/cmake
	  -DRAGEL_EXE=${CURRENT_INSTALLED_DIR}/bin/ragel.exe
#	  -D7Z_EXE=${CURRENT_INSTALLED_DIR}/bin/7z.exe
      -DBUILD_GRACO_SAMPLE_01_CALC=OFF
      -DBUILD_GRACO_TESTS=OFF
      -DMSVC_USE_FOLDERS=ON
      -DMSVC_USE_PCH=OFF
      -DMSVC_USE_UNICODE=ON
)

vcpkg_install_cmake()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/license ${CURRENT_PACKAGES_DIR}/debug/license
  ${CURRENT_PACKAGES_DIR}/samples ${CURRENT_PACKAGES_DIR}/debug/samples
  )

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE.txt ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
