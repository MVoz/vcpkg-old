include(vcpkg_common_functions)

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_download_distfile(ARCHIVE
    URLS "https://gitlab.com/codelibre/ome/ome-model/-/archive/fbe551cb1ebe8c3c24a0ca19796f81e8fe421ab3/ome-model-fbe551cb1ebe8c3c24a0ca19796f81e8fe421ab3.tar.gz"
    FILENAME "ome-model.tar.gz"
    SHA512 25739ad7a8dbb633abc8a0e208cdc214ae6cc7609d1f60e93813ae69d9af5c446ceacbc75d008975f41fef3a069a393407fa6b9e3078ea4cf5f78e018cdd978e
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_find_acquire_program(PYTHON3)
#vcpkg_find_acquire_program(QT5)
#vcpkg_find_acquire_program(TEXLIVE)
#vcpkg_find_acquire_program(XGETTEXT)
vcpkg_find_acquire_program(DOXYGEN)
get_filename_component(DOXYGEN_DIR "${DOXYGEN}" DIRECTORY)
#get_filename_component(QT5_DIR "${QT5}" DIRECTORY)
get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
#get_filename_component(GETTEXT_DIR "${XGETTEXT}" DIRECTORY)
#get_filename_component(TEXLIVE_DIR "${TEXLIVE}" DIRECTORY)
set(ENV{PATH} "$ENV{PATH};${DOXYGEN_DIR};${PYTHON3_DIR}") #;${GETTEXT_DIR};${TEXLIVE_DIR}

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates

    OPTIONS 
      -Dcxxstd-autodetect:BOOL=ON
      -Ddoxygen:BOOL=OFF
      -Dextended-tests:BOOL=OFF
      -Dextra-warnings:BOOL=OFF
      -Dfatal-warnings:BOOL=OFF
      -Dmodel-source-only:BOOL=OFF
      -Drelocatable-install:BOOL=ON
      -Dsphinx:BOOL=OFF
      -Dsphinx-linkcheck:BOOL=OFF
      -Dtest:BOOL=OFF
      -Dxsdfu-debug:BOOL=OFF
    OPTIONS_RELEASE 
      -DCMAKE_IGNORE_PATH=${CURRENT_INSTALLED_DIR}/debug #ERROR Searching debug\lib\ome-commond.lib ???
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE.md ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
