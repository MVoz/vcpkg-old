include(vcpkg_common_functions)

find_program(GIT NAMES git git.cmd)
set(GIT_URL "https://gitlab.com/codelibre/ome/ome-files")
set(GIT_REV master)
set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/${PORT})
if(NOT EXISTS "${SOURCE_PATH}/.git")
    message(STATUS "Cloning and fetching submodules")
    vcpkg_execute_required_process(
      COMMAND ${GIT} clone --recurse-submodules ${GIT_URL} ${SOURCE_PATH}
      WORKING_DIRECTORY ${SOURCE_PATH}
      LOGNAME clone
    )
    message(STATUS "Checkout revision ${GIT_REV}")
    vcpkg_execute_required_process(
      COMMAND ${GIT} checkout ${GIT_REV}
      WORKING_DIRECTORY ${SOURCE_PATH}
      LOGNAME checkout
    )
endif()

vcpkg_find_acquire_program(PYTHON3)
#vcpkg_find_acquire_program(QT5)
vcpkg_find_acquire_program(TEXLIVE)
vcpkg_find_acquire_program(XGETTEXT)
vcpkg_find_acquire_program(DOXYGEN)
#vcpkg_find_acquire_program(DOXYGEN)
#vcpkg_find_acquire_program(PERL)
#vcpkg_find_acquire_program(FLEX)
#vcpkg_find_acquire_program(BISON)
#get_filename_component(FLEX_DIR "${FLEX}" DIRECTORY)
#get_filename_component(BISON_DIR "${BISON}" DIRECTORY)
get_filename_component(DOXYGEN_DIR "${DOXYGEN}" DIRECTORY)
#get_filename_component(PERL_DIR "${PERL}" DIRECTORY)
#get_filename_component(QT5_DIR "${QT5}" DIRECTORY)
get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
#get_filename_component(DOXYGEN_DIR "${DOXYGEN}" DIRECTORY)
get_filename_component(GETTEXT_DIR "${XGETTEXT}" DIRECTORY)
get_filename_component(TEXLIVE_DIR "${TEXLIVE}" DIRECTORY)
#set(ENV{PATH} ";$ENV{PATH};${QT5_DIR};${PYTHON3_DIR};${DOXYGEN_DIR};${XGETTEXT_DIR};${TEXLIVE_DIR};${FLEX_DIR};${BISON_DIR};${DOXYGEN_DIR};${PERL_DIR}")
#vcpkg_find_acquire_program(YASM)
#get_filename_component(YASM_EXE_PATH ${YASM} DIRECTORY)
set(ENV{PATH} "$ENV{PATH};${DOXYGEN_DIR};${PYTHON3_DIR};${GETTEXT_DIR};${TEXLIVE_DIR}")

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates
    OPTIONS 
      -Ddoxygen:BOOL=OFF
      -Dextended-tests:BOOL=OFF
      -Dextra-warnings:BOOL=OFF
      -Dfatal-warnings:BOOL=OFF
#      -Dfilesystem:STRING=standard;boost
#      -Dfilesystem:STRING=standard;boost;qt5
#      -Doptions:STRING=boost
#      -Doptions:STRING=boost;qt5
      -Drelocatable-install:BOOL=ON
      -Dsphinx:BOOL=OFF
      -Dsphinx-linkcheck:BOOL=OFF
      -Dsphinx-pdf:BOOL=OFF
      -Dtest:BOOL=OFF
#      -Dxmldom:STRING=xerces
#      -Dxmldom:STRING=xerces;qt5
      -Dxsdfu-debug:BOOL=ON
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE.md ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
