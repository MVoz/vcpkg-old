include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/vovkos/cmakedoxyxml/archive/34aa230e237b20a7d70c821e1c24f167649d8d7b.zip"
    FILENAME "cmakedoxyxml.zip"
    SHA512 74bcc7a68d7471a0068dff44e9609cf9d886cdc36397a96ac26760a4839261588d0606f25bf7e99f5cd4c071a9a7ed9d7aaa106e013ae6a6edd4477cb9ba49fe
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

#vcpkg_find_acquire_program(PYTHON3)
#vcpkg_find_acquire_program(QT5)
#vcpkg_find_acquire_program(TEXLIVE)
#vcpkg_find_acquire_program(XGETTEXT)
#vcpkg_find_acquire_program(DOXYGEN)
#vcpkg_find_acquire_program(DOXYGEN)
#vcpkg_find_acquire_program(PERL)
#vcpkg_find_acquire_program(FLEX)
#vcpkg_find_acquire_program(BISON)
#get_filename_component(FLEX_DIR "${FLEX}" DIRECTORY)
#get_filename_component(BISON_DIR "${BISON}" DIRECTORY)
#get_filename_component(DOXYGEN_DIR "${DOXYGEN}" DIRECTORY)
#get_filename_component(PERL_DIR "${PERL}" DIRECTORY)
#get_filename_component(QT5_DIR "${QT5}" DIRECTORY)
#get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
#get_filename_component(DOXYGEN_DIR "${DOXYGEN}" DIRECTORY)
#get_filename_component(XGETTEXT_DIR "${XGETTEXT}" DIRECTORY)
#get_filename_component(TEXLIVE_DIR "${TEXLIVE}" DIRECTORY)
#set(ENV{PATH} ";$ENV{PATH};${QT5_DIR};${PYTHON3_DIR};${DOXYGEN_DIR};${XGETTEXT_DIR};${TEXLIVE_DIR};${FLEX_DIR};${BISON_DIR};${DOXYGEN_DIR};${PERL_DIR}")

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
