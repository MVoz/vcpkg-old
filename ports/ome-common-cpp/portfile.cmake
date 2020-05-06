include(vcpkg_common_functions)

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_download_distfile(ARCHIVE
    URLS "https://gitlab.com/codelibre/ome/ome-common-cpp/-/archive/7622bbbef1fd85dc3d604bc23b8ae09dd275b731/ome-common-cpp-7622bbbef1fd85dc3d604bc23b8ae09dd275b731.tar.gz"
    FILENAME "ome-common-cpp.tar.gz"
    SHA512 4ef7ba5bed9c5942af2dee7bf385221522b91e08ba464cc7be23ed5a040e59d1480b6a3eb921b592f43923a28aa35a71dc8f52b68fadec46ef42c535fdde813e
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
      -Ddoxygen:BOOL=OFF
      -Dextended-tests:BOOL=OFF
      -Dextra-warnings:BOOL=OFF
      -Dfatal-warnings:BOOL=OFF
      -Drelocatable-install:BOOL=OFF
      -Dtest:BOOL=OFF
    OPTIONS_RELEASE 
      -DCMAKE_IGNORE_PATH=${CURRENT_INSTALLED_DIR}/debug #ERROR check xerces-c and xalan-c lib, Searching lib debug\lib
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE.md ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
