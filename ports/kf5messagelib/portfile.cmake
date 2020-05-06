include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/KDE/messagelib/archive/v19.04.3.tar.gz"
    FILENAME "messagelibv19.04.3.tar.gz"
    SHA512 b2d07e88367bc11d193b348c6e6a6f5d79f9d5dcee6e2b50bb8b42b9d0aaa8413ab5a4ac6c95c4c479dbf4ea11f8476b6cc53681e4dc28cc2b54041631452481
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_find_acquire_program(XGETTEXT)
vcpkg_find_acquire_program(PYTHON3)
get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
get_filename_component(GETTEXT_DIR "${XGETTEXT}" DIRECTORY)
set(ENV{PATH} "$ENV{PATH};${GETTEXT_DIR};${PYTHON3_DIR}")

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS 
      -DBUILD_HTML_DOCS=OFF
      -DBUILD_MAN_DOCS=OFF
      -DBUILD_QTHELP_DOCS=OFF
      -DBUILD_TESTING=OFF
      -DKI18N_PYTHON_EXECUTABLE=${PYTHON3}
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/COPYING.LIB ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
