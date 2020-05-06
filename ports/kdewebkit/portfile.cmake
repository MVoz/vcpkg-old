include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://download.kde.org/stable/frameworks/5.58/kdewebkit-5.58.0.zip"
    FILENAME "kdewebkit-5.58.0.zip"
    SHA512 20ba245188ea16b8257bbb2996e3b43452537944ee4924940de92eb0b00517520dd75f613890ea4c27920c29a12df66bfbd479901e9d932369c343ac71997d7d
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_find_acquire_program(XGETTEXT)
get_filename_component(GETTEXT_DIR "${XGETTEXT}" DIRECTORY)
set(ENV{PATH} "$ENV{PATH};${GETTEXT_DIR}")

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
