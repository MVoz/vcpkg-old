include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/KDE/lokalize/archive/v19.04.3.tar.gz"
    FILENAME "lokalizev19.04.3.tar.gz"
    SHA512 d1308647c589c02cb69907ef718e9d24fb9d4956cbb091f3077b57018c7c950c42662b5284abac3d185bd5c0b2f9534e60a3aa211aeb7cb3f0656fe99cbab5bc
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

#-- Could NOT find Png2Ico (missing: Png2Ico_EXECUTABLE)
# * Png2Ico, Executable that converts a collection of PNG files into a Windows icon file, <https://www.winterdrache.de/freeware/png2ico/ or https://commits.kde.org/kdewin>
#-- Could NOT find IcoTool (missing: IcoTool_EXECUTABLE) 
# * IcoTool, Executable that converts a collection of PNG files into a Windows icon file, <https://www.nongnu.org/icoutils/>

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
configure_file(${SOURCE_PATH}/COPYING ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
