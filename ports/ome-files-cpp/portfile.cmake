include(vcpkg_common_functions)

#vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_download_distfile(ARCHIVE
    URLS "https://gitlab.com/codelibre/ome/ome-files-cpp/-/archive/1f1d0e6dc801899dd783b865d535ef7dedb49f90/ome-files-cpp-1f1d0e6dc801899dd783b865d535ef7dedb49f90.tar.gz"
    FILENAME "ome-files-cpp.tar.gz"
    SHA512 852a66709ab860e9fac705f1209fff09b9fb3c1e4573f959ca9ac708ccb49b29d912de39debfdab18ad15c3823f728a50a436341f0129ba02e3d2bb4ec0f485b
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
      -Dcxxstd-autodetect=ON
      -Ddoxygen=OFF
      -Dextended-tests=OFF
      -Dextra-warnings=OFF
      -Dfatal-warnings=OFF
      -Drelocatable-install=OFF
      -Dsphinx=OFF
      -Dsphinx-linkcheck=OFF
      -Dtest=OFF
#      -Doptions=boost
#      -Dxmldom=xerces
    OPTIONS_RELEASE 
      -DCMAKE_IGNORE_PATH=${CURRENT_INSTALLED_DIR}/debug #ERROR Searching debug\lib\ome-commond.lib ???
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE.md ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
