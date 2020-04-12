include(vcpkg_common_functions)

find_program(GIT NAMES git git.cmd)

set(GIT_URL "https://gitlab.com/graphviz/graphviz.git")
set(GIT_REV "b29d8e369011b832f72e0d250a05a0a15dcb5daa")

set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/${PORT})

if(NOT EXISTS "${SOURCE_PATH}/.git")
	message(STATUS "Cloning and fetching submodules")
	set(error_code 1)
	set(number_of_tries 0)
	while(error_code AND number_of_tries LESS 3)
	  execute_process(
	  COMMAND ${GIT} clone --recurse-submodules --progress ${GIT_URL} ${SOURCE_PATH}
	  WORKING_DIRECTORY ${SOURCE_PATH}
	  RESULT_VARIABLE error_code
	)
	math(EXPR number_of_tries "${number_of_tries} + 1")
	endwhile()
	if(number_of_tries GREATER 1)
		message(STATUS "Had to git clone more than once:	${number_of_tries} times.")
	endif()
	if(error_code)
		message(FATAL_ERROR "Failed to clone repository: '${GIT_URL}'")
	endif()
	message(STATUS "Checkout revision ${GIT_REV}")
	vcpkg_execute_required_process(
	  COMMAND ${GIT} checkout ${GIT_REV}
	  WORKING_DIRECTORY ${SOURCE_PATH}
	  LOGNAME checkout
	)
endif()

file(COPY ${CURRENT_PORT_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH}/plugin/core)
file(COPY ${CURRENT_PORT_DIR}/gvc.def DESTINATION ${SOURCE_PATH}/lib/gvc)

# sed and awk are installed with git but in a different directory
get_filename_component(GIT_EXE_PATH ${GIT} DIRECTORY)
set(AWK_EXE_PATH "${GIT_EXE_PATH}/../usr/bin")
set(ENV{PATH} ";$ENV{PATH};${AWK_EXE_PATH}")

vcpkg_find_acquire_program(TEXLIVE)
vcpkg_find_acquire_program(XGETTEXT)
vcpkg_find_acquire_program(FLEX)
vcpkg_find_acquire_program(BISON)
vcpkg_find_acquire_program(PYTHON3)
vcpkg_find_acquire_program(DOXYGEN)
vcpkg_find_acquire_program(PERL)
get_filename_component(TEXLIVE_DIR "${TEXLIVE}" DIRECTORY)
get_filename_component(XGETTEXT_DIR "${XGETTEXT}" DIRECTORY)
get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
get_filename_component(DOXYGEN_DIR "${DOXYGEN}" DIRECTORY)
get_filename_component(FLEX_DIR "${FLEX}" DIRECTORY)
get_filename_component(BISON_DIR "${BISON}" DIRECTORY)
get_filename_component(PERL_DIR "${PERL}" DIRECTORY)
set(ENV{PATH} ";$ENV{PATH};${XGETTEXT_DIR};${TEXLIVE_DIR};${PYTHON3_DIR};${FLEX_DIR};${BISON_DIR};${DOXYGEN_DIR};PERL_DIR")

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
#    OPTIONS 
#        -DANN_INCLUDE_DIR:PATH=
#        -DANN_LIBRARY:FILEPATH=
#        -DANN_RUNTIME_LIBRARY:FILEPATH=
#        -DCAIRO_INCLUDE_DIR:PATH=
#        -DCAIRO_LIBRARY:FILEPATH=
#        -DCAIRO_RUNTIME_LIBRARY:FILEPATH=
#        -DEXPAT_INCLUDE_DIR:PATH=
#        -DEXPAT_LIBRARY:FILEPATH=
#        -DEXPAT_RUNTIME_LIBRARIES:FILEPATH=
#        -DEXPAT_RUNTIME_LIBRARY:FILEPATH=
#        -DFL_LIBRARY:FILEPATH=
#        -DFONTCONFIG_RUNTIME_LIBRARY:FILEPATH=
#        -DGD_INCLUDE_DIR:PATH=
#        -DGD_LIBRARY:FILEPATH=
#        -DGD_RUNTIME_LIBRARY:FILEPATH=
#        -DGLIBCONFIG_INCLUDE_DIR:PATH=
#        -DGLIB_INCLUDE_DIR:PATH=
#        -DGLIB_LIBRARY:FILEPATH=
#        -DGLIB_RUNTIME_LIBRARY:FILEPATH=
#        -DGOBJECT_LIBRARY:FILEPATH=
#        -DGOBJECT_RUNTIME_LIBRARY:FILEPATH=
#        -DHARFBUZZ_RUNTIME_LIBRARY:FILEPATH=
#        -DLTDL_INCLUDE_DIR:PATH=
#        -DMSVC_REDIST_DIR:PATH=
#        -DPANGOCAIRO_INCLUDE_DIR:PATH=
#        -DPANGOCAIRO_LIBRARY:FILEPATH=
#        -DPANGOCAIRO_RUNTIME_LIBRARY:FILEPATH=
#        -DPANGOFT_RUNTIME_LIBRARY:FILEPATH=
#        -DPANGOWIN_RUNTIME_LIBRARY:FILEPATH=
#        -DPANGO_LIBRARY:FILEPATH=
#        -DPANGO_RUNTIME_LIBRARY:FILEPATH=
#        -DPIXMAN_RUNTIME_LIBRARY:FILEPATH=
#        -DRXSPENCER_INCLUDE_DIR:PATH=
#        -DRXSPENCER_LIBRARY:FILEPATH=
#        -DZLIB_INCLUDE_DIR:PATH=
#        -DZLIB_LIBRARY_DEBUG:FILEPATH=
#        -DZLIB_LIBRARY_RELEASE:FILEPATH=
#        -Dpkgcfg_lib_PC_EXPAT_expat:FILEPATH=
#        -Denable_ltdl:BOOL=ON
#        -Dwith_digcola:BOOL=ON
#        -Dwith_ipsepcola:BOOL=OFF
#        -Dwith_ortho:BOOL=ON
#        -Dwith_sfdp:BOOL=ON
#        -Dwith_smyrna:BOOL=OFF

#        -DAWK_EXECUTABLE:FILEPATH=
#        -DBISON_EXECUTABLE:FILEPATH=
#        -DCYGWIN_BAT:FILEPATH=C:/cygwin/Cygwin.bat
#        -DFLEX_EXECUTABLE:FILEPATH=
#        -DFLEX_INCLUDE_DIR:PATH=E:/tools/vcpkg/installed/x64-windows/include
#        -DGIT_EXECUTABLE:FILEPATH=
#        -DMSYS_RUNTIME_LIBRARIES:FILEPATH=E:/tools/vcpkg/downloads/MinGit-2.16.2-32-bit/usr/bin/msys-2.0.dll
#        -DNSIS_MAKE:FILEPATH=
#        -DPERL_EXECUTABLE:FILEPATH=
#        -DPKG_CONFIG_EXECUTABLE:FILEPATH=E:/tools/vcpkg/installed/x64-windows/bin/pkg-config.exe
#        -DPYTHON_EXECUTABLE:FILEPATH=E:/tools/vcpkg/downloads/tools/python/python3/python.exe
)

vcpkg_install_cmake()

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/graphviz RENAME copyright)

file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/tools)
file(RENAME ${CURRENT_PACKAGES_DIR}/debug/bin ${CURRENT_PACKAGES_DIR}/tools/graphviz)
file(REMOVE_RECURSE 
    ${CURRENT_PACKAGES_DIR}/debug/include 
    ${CURRENT_PACKAGES_DIR}/bin 
    ${CURRENT_PACKAGES_DIR}/debug/share
)
# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME graphviz)
