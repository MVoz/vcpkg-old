include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/KDE/kxmlrpcclient/archive/v5.58.0.tar.gz"
    FILENAME "kxmlrpcclientv5.58.0.tar.gz"
    SHA512 dfd10d0e4342fbac44821ed0ad24047312858fa6f1d96af6e355adea0efe1c7e205fedfc9964196df1b222d7aa37cc601ed2b6677bfea50c5d9ff490a422931f
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

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/COPYING.LIB ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
