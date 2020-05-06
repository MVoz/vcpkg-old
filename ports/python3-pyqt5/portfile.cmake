include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://www.riverbankcomputing.com/static/Downloads/PyQt5/5.12.2/PyQt5_gpl-5.12.2.zip"
    FILENAME "PyQt5_gpl-5.12.2.zip"
    SHA512 554d2cafa1b922bb1df0dee78d3b7346fac2bd7619324a555cba99d19a7b02e13740a578803d27497bae67be62c91884974173a9fb8194ee9235c4351cf54057
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_find_acquire_program(PYTHON3)
vcpkg_find_acquire_program(QT5)
#vcpkg_find_acquire_program(TEXLIVE)
#vcpkg_find_acquire_program(XGETTEXT)
#vcpkg_find_acquire_program(PYTHON3)
#vcpkg_find_acquire_program(DOXYGEN)

#питон не находит зависимости, пришлось добавить все
get_filename_component(QT5_DIR "${QT5}" DIRECTORY)
get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
#get_filename_component(DOXYGEN_DIR "${DOXYGEN}" DIRECTORY)

#vcpkg_add_to_path("${PYTHON3_DIR};${FLEX_DIR};${BISON_DIR};${DOXYGEN_DIR}")
set(ENV{PATH} ";$ENV{PATH};${QT5_DIR};${PYTHON3_DIR}")

find_program(NMAKE nmake)

vcpkg_execute_required_process(
  COMMAND ${PYTHON3} ${SOURCE_PATH}/configure.py --verbose -j 4 --qmake ${QT5} --static --disable QtNfc --confirm-license
  WORKING_DIRECTORY ${SOURCE_PATH}
  LOGNAME configure-${TARGET_TRIPLET}
)

vcpkg_execute_required_process(
  COMMAND ${NMAKE} clean install
  WORKING_DIRECTORY ${SOURCE_PATH}
  LOGNAME nmake-build-${TARGET_TRIPLET}-debug
)

include(${CURRENT_INSTALLED_DIR}/share/python3-setuptools/python-pip-install.cmake)
python_pip_install(SOURCE_PATH ${SOURCE_PATH})
