include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/KDE/khtml/archive/v5.58.0.tar.gz"
    FILENAME "khtmlv5.58.0.tar.gz"
    SHA512 04643c0bae60c77c572b20742e4941c521623e51d495c8face7e95febba9350a3530e1f8b2a06103e184dfc0e6720842bbb0ec0654f1b48dc64e8b0df712e8bc
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_find_acquire_program(PYTHON3)
vcpkg_find_acquire_program(XGETTEXT)
vcpkg_find_acquire_program(PERL)
get_filename_component(GETTEXT_DIR "${XGETTEXT}" DIRECTORY)
get_filename_component(PERL_DIR "${PERL}" DIRECTORY)
get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
set(ENV{PATH} ";$ENV{PATH};${GETTEXT_DIR};${PERL_DIR};${PYTHON3_DIR}")

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS -DBUILD_HTML_DOCS=OFF
            -DBUILD_MAN_DOCS=OFF
            -DBUILD_QTHELP_DOCS=OFF
            -DBUILD_TESTING=OFF
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/COPYING.LIB ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
