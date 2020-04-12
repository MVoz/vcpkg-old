include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://download.kde.org/stable/frameworks/5.58/baloo-5.58.0.zip"
    FILENAME "baloo-5.58.0.zip"
    SHA512 8d0be353603d3738bb80ba65f0a6bdf610cf0a5210ab236cecdaefd2d97cbdfc4e5818f3b0a666f0bc15f5bfa0d9cc62e1e14145f64cf674e8e902d1f915b85f
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
