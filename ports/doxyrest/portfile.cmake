include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/vovkos/doxyrest/archive/90c76140b034b22ef4052a61f74da0af0b4c4c69.zip"
    FILENAME "doxyrest.zip"
    SHA512 fa1db12cd7537206583614b5afb2689d9bbc396a124b901d0461a04932f7c5893781b3082fd34a85bee0d63cec3cd45a179e6c736a8dcca7adffa071bdbe80c0
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_find_acquire_program(DOXYGEN)
vcpkg_find_acquire_program(TEXLIVE)
vcpkg_find_acquire_program(XGETTEXT)
get_filename_component(DOXYGEN_DIR "${DOXYGEN}" DIRECTORY)
get_filename_component(XGETTEXT_DIR "${XGETTEXT}" DIRECTORY)
get_filename_component(TEXLIVE_DIR "${TEXLIVE}" DIRECTORY)
set(ENV{PATH} "$ENV{PATH};${DOXYGEN_DIR};${XGETTEXT_DIR};${TEXLIVE_DIR}")

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
	  -DBUILD_DOXYREST_SAMPLES=OFF
	  -DRAGEL_EXE=${CURRENT_INSTALLED_DIR}/bin/ragel.exe
	  -DLUADOXYXML_EXE=${CURRENT_INSTALLED_DIR}/bin/luadoxyxml.exe
)

vcpkg_install_cmake()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/license ${CURRENT_PACKAGES_DIR}/debug/license)

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE.txt ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
