include(vcpkg_common_functions)

#vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/vovkos/luadoxyxml/archive/91ba8488c0865e44e94c4ba13f9bf56682cdb6e9.zip"
    FILENAME "luadoxyxml.zip"
    SHA512 974fcd1910c6395ecc4a3eba4a945d5f8d6f80ac0f89586607f44ca177816362bf2d64ff149e648fd6b275bf656fefd726e064e0048e4ce4f2c71616ddd32146
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_find_acquire_program(DOXYGEN)
#vcpkg_find_acquire_program(TEXLIVE)
#vcpkg_find_acquire_program(XGETTEXT)
get_filename_component(DOXYGEN_DIR "${DOXYGEN}" DIRECTORY)
#get_filename_component(XGETTEXT_DIR "${XGETTEXT}" DIRECTORY)
#get_filename_component(TEXLIVE_DIR "${TEXLIVE}" DIRECTORY)
set(ENV{PATH} "$ENV{PATH};${DOXYGEN_DIR}")#;${XGETTEXT_DIR};${TEXLIVE_DIR}

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates
    OPTIONS_DEBUG # automatic templates
#      -DCMAKE_IGNORE_PATH=${CURRENT_INSTALLED_DIR}
      -DAXL_CMAKE_DIR=${CURRENT_INSTALLED_DIR}/debug/cmake
	  -DGRACO_CMAKE_DIR=${CURRENT_INSTALLED_DIR}/debug/cmake
    OPTIONS_RELEASE 
#      -DCMAKE_IGNORE_PATH=${CURRENT_INSTALLED_DIR}/debug
      -DAXL_CMAKE_DIR=${CURRENT_INSTALLED_DIR}/cmake
	  -DGRACO_CMAKE_DIR=${CURRENT_INSTALLED_DIR}/cmake
    OPTIONS 
      -DMSVC_USE_FOLDERS=ON
      -DMSVC_USE_PCH=OFF
      -DMSVC_USE_UNICODE=ON
	  -DRAGEL_EXE=${CURRENT_INSTALLED_DIR}/bin/ragel.exe
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE.txt ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
