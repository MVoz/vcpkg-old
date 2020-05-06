include(vcpkg_common_functions)

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/vovkos/jancy/archive/3879e9d771f42d2d2f088f7cb82cda1fd5c63153.zip"
    FILENAME "jancy.zip"
    SHA512 9f3a0b239787ab6e5ba767a4f725bb6c0a6126a9b466aa3ead8cd9a59a3fc22dbb4b8595060b052e33ec0c8f06e55d2c29d9e537d6b416503641cc2c5cfab594
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_find_acquire_program(DOXYGEN)
vcpkg_find_acquire_program(TEXLIVE)
#vcpkg_find_acquire_program(XGETTEXT)
vcpkg_find_acquire_program(PERL)
vcpkg_find_acquire_program(7Z)
vcpkg_find_acquire_program(PYTHON3)
get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
get_filename_component(DOXYGEN_DIR "${DOXYGEN}" DIRECTORY)
#get_filename_component(XGETTEXT_DIR "${XGETTEXT}" DIRECTORY)
get_filename_component(TEXLIVE_DIR "${TEXLIVE}" DIRECTORY)
get_filename_component(PERL_DIR "${PERL}" DIRECTORY)

###PERSONAL ENV LLVM + CLANG
set(LLVM_ROOT_DIR "E:/tools/LLVM-4")
set(LLVM_BIN_DIR "${LLVM_ROOT_DIR}/bin")
set(LLVM_INCLUDE_DIRS "${LLVM_ROOT_DIR}/include")
set(LLVM_LIBRARY_DIRS "${LLVM_ROOT_DIR}/lib")

set(ENV{LLVM_INC_DIR} "${LLVM_INCLUDE_DIRS}")
set(ENV{LLVM_LIB_DIR} "${LLVM_LIBRARY_DIRS}")

set(ENV{PATH} "$ENV{PATH};${PERL_DIR};${DOXYGEN_DIR};${TEXLIVE_DIR};${LLVM_BIN_DIR}")#

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates
    OPTIONS_DEBUG # automatic templates
#      -DCMAKE_IGNORE_PATH=${CURRENT_INSTALLED_DIR}
      -DAXL_CMAKE_DIR=${CURRENT_INSTALLED_DIR}/debug/cmake
	  -DGRACO_CMAKE_DIR=${CURRENT_INSTALLED_DIR}/debug/cmake
	  -DDOXYREST_CMAKE_DIR=${CURRENT_INSTALLED_DIR}/debug/cmake
    OPTIONS_RELEASE 
#      -DCMAKE_IGNORE_PATH=${CURRENT_INSTALLED_DIR}/debug
      -DAXL_CMAKE_DIR=${CURRENT_INSTALLED_DIR}/cmake
	  -DGRACO_CMAKE_DIR=${CURRENT_INSTALLED_DIR}/cmake
	  -DDOXYREST_CMAKE_DIR=${CURRENT_INSTALLED_DIR}/cmake
    OPTIONS 
      -DMSVC_USE_FOLDERS=ON
      -DMSVC_USE_PCH=OFF
      -DMSVC_USE_UNICODE=ON
	  -DRAGEL_EXE=${CURRENT_INSTALLED_DIR}/bin/ragel.exe
	  -DPERL_EXE=${PERL}
	  -D7Z_EXE=${7Z}
	  -DSPHINX_BUILD_EXE=${PYTHON3_DIR}/Scripts/sphinx-build.exe
	  -DDOXYGEN_EXE=${DOXYGEN}
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE.txt ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
