include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://gitlab.kitware.com/iMSTK/VegaFEM-CMake/-/archive/6bba4eadbd943c003fcf90fcec122a3b3feef30d/VegaFEM-CMake-6bba4eadbd943c003fcf90fcec122a3b3feef30d.tar.gz"
    FILENAME "VegaFEM-CMake-6bba4eadbd943c003fcf90fcec122a3b3feef30d.tar.gz"
    SHA512 56b1f6a20ee467e38ca1cbf61b7ba4a2208a35e9b1883532424b17ffa60cd15313a97ab543940ffbfed89649cacdc8d24fd9c1cc109dcc27b3b043fbe584caf1
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

#vcpkg_find_acquire_program(PYTHON3)
#vcpkg_find_acquire_program(QT5)
#vcpkg_find_acquire_program(TEXLIVE)
#vcpkg_find_acquire_program(XGETTEXT)
#vcpkg_find_acquire_program(DOXYGEN)
#vcpkg_find_acquire_program(DOXYGEN)
#vcpkg_find_acquire_program(PERL)
#vcpkg_find_acquire_program(FLEX)
#vcpkg_find_acquire_program(BISON)
#get_filename_component(FLEX_DIR "${FLEX}" DIRECTORY)
#get_filename_component(BISON_DIR "${BISON}" DIRECTORY)
#get_filename_component(DOXYGEN_DIR "${DOXYGEN}" DIRECTORY)
#get_filename_component(PERL_DIR "${PERL}" DIRECTORY)
#get_filename_component(QT5_DIR "${QT5}" DIRECTORY)
#get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
#get_filename_component(DOXYGEN_DIR "${DOXYGEN}" DIRECTORY)
#get_filename_component(XGETTEXT_DIR "${XGETTEXT}" DIRECTORY)
#get_filename_component(TEXLIVE_DIR "${TEXLIVE}" DIRECTORY)
#set(ENV{PATH} ";$ENV{PATH};${QT5_DIR};${PYTHON3_DIR};${DOXYGEN_DIR};${XGETTEXT_DIR};${TEXLIVE_DIR};${FLEX_DIR};${BISON_DIR};${DOXYGEN_DIR};${PERL_DIR}")
#vcpkg_find_acquire_program(YASM)
#get_filename_component(YASM_EXE_PATH ${YASM} DIRECTORY)
#set(ENV{PATH} "$ENV{PATH};${YASM_EXE_PATH}")

#get_filename_component(GIT_EXE_PATH ${GIT} DIRECTORY)
#set(SH_EXE_PATH "${GIT_EXE_PATH}/../usr/bin")
#set(ENV{PATH} "$ENV{PATH};${VALAC_DIR};${BISON_DIR};${FLEX_DIR};${SH_EXE_PATH}")

#file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH})

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates

    OPTIONS 
      -DVegaFEM_BUILD_MODEL_REDUCTION=OFF
      -DVegaFEM_BUILD_UTILITIES=ON
      -DVegaFEM_ENABLE_Cg_SUPPORT=OFF
      -DVegaFEM_ENABLE_ExpoKit_SUPPORT=OFF
      -DVegaFEM_ENABLE_OpenGL_SUPPORT=ON
      -DVegaFEM_ENABLE_PTHREADS_SUPPORT=OFF #fatal error LNK1104: cannot open file 'Threads::Threads.lib'
#      -DwxWidgets_LIB_DIR:PATH=wxWidgets_LIB_DIR-NOTFOUND
#      -DwxWidgets_ROOT_DIR:PATH=E:/tools/vcpkg/installed/x64-windows
#      -DwxWidgets_wxrc_EXECUTABLE:FILEPATH=wxWidgets_wxrc_EXECUTABLE-NOTFOUND
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
