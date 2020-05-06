include(vcpkg_common_functions)
include(FindPackageHandleStandardArgs)

find_program(GIT NAMES git git.cmd)
set(GIT_URL "https://github.com/pulseaudio/pulseaudio")
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

# sed and awk are installed with git but in a different directory
#get_filename_component(GIT_DIR ${GIT} DIRECTORY)
#vcpkg_acquire_msys(MSYS_ROOT)
get_filename_component(GIT_DIR ${GIT} DIRECTORY)
#set(AWK_DIR "${GIT_DIR}/../usr/bin")
set(SH_DIR "${GIT_DIR}/../usr/bin")

#set(AWK_EXECUTABLE ${MSYS_ROOT}/usr/bin/awk.exe)
#set(SH ${MSYS_ROOT}/usr/bin/sh.exe)
#set(M4_EXECUTABLE ${MSYS_ROOT}/usr/bin/m4.exe)
#set(M4_DIR ${MSYS_ROOT}/usr/bin)

#find_program(AWK_EXECUTABLE NAMES awk mawk gawk PATHS ${MSYS_ROOT}/usr/bin)
#find_program(CMAKE_SH NAMES sh PATHS ${MSYS_ROOT}/usr/bin)
#find_program(M4_EXECUTABLE NAMES m4 PATHS ${MSYS_ROOT}/usr/bin)

#find_package_handle_standard_args(AWK DEFAULT_MSG AWK_EXECUTABLE)
#find_package_handle_standard_args(SH DEFAULT_MSG CMAKE_SH)
vcpkg_find_acquire_program(PYTHON3)
#vcpkg_find_acquire_program(QT5)
#vcpkg_find_acquire_program(TEXLIVE)
#vcpkg_find_acquire_program(XGETTEXT)
#vcpkg_find_acquire_program(DOXYGEN)
#vcpkg_find_acquire_program(DOXYGEN)
vcpkg_find_acquire_program(PERL)
#vcpkg_find_acquire_program(FLEX)
#vcpkg_find_acquire_program(BISON)
#get_filename_component(FLEX_DIR "${FLEX}" DIRECTORY)
#get_filename_component(BISON_DIR "${BISON}" DIRECTORY)
#get_filename_component(DOXYGEN_DIR "${DOXYGEN}" DIRECTORY)
get_filename_component(PERL_DIR "${PERL}" DIRECTORY)
#get_filename_component(QT5_DIR "${QT5}" DIRECTORY)
get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
#get_filename_component(DOXYGEN_DIR "${DOXYGEN}" DIRECTORY)
#get_filename_component(XGETTEXT_DIR "${XGETTEXT}" DIRECTORY)
#get_filename_component(TEXLIVE_DIR "${TEXLIVE}" DIRECTORY)
#set(ENV{PATH} ";$ENV{PATH};${QT5_DIR};${PYTHON3_DIR};${DOXYGEN_DIR};${XGETTEXT_DIR};${TEXLIVE_DIR};${FLEX_DIR};${BISON_DIR};${DOXYGEN_DIR};${PERL_DIR}")
#vcpkg_find_acquire_program(YASM)
#get_filename_component(YASM_EXE_PATH ${YASM} DIRECTORY)
#set(ENV{PATH} "$ENV{PATH};${YASM_EXE_PATH}")
#set(M4_DIR ${M4_EXECUTABLE} DIRECTORY)
set(ENV{PATH} ";${PYTHON3_DIR};${PERL_DIR};${SH_DIR};$ENV{PATH}")

#set(AWK ${AWK_EXECUTABLE})
#set(SH ${CMAKE_SH})
#set(M4 ${M4_EXECUTABLE})

#FIND_PROGRAM(CMAKE_MAKE_PROGRAM mingw32-make.exe PATHS c:/MinGW/bin /MinGW/bin)

#set(BASH ${MSYS_ROOT}/usr/bin/bash.exe)
#set(AWK ${MSYS_ROOT}/usr/bin/awk.exe)
#set(SH ${MSYS_ROOT}/usr/bin/sh.exe)
#set(M4 ${MSYS_ROOT}/usr/bin/m4.exe)

#set(AWK_DIR "${GIT_DIR}/../usr/bin")
#set(SH_DIR "${GIT_DIR}/../usr/bin")
#set(ENV{PATH} ";$ENV{PATH};${SH_DIR};${AWK_DIR}")

# https://mesonbuild.com/Configuring-a-build-directory.html
vcpkg_configure_meson(
	SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
		--backend=ninja
		-Dman=false
		-Dtests=false		
)

vcpkg_install_meson()

vcpkg_copy_pdbs()

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/pulseaudio RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME pulseaudio)
