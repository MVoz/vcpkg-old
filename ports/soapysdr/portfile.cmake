include(vcpkg_common_functions)

find_program(GIT NAMES git git.cmd)
set(GIT_URL "https://github.com/pothosware/SoapySDR.git")
set(GIT_REV 59c501cd0e00ce3124b831f094360a5621d0a557)
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
vcpkg_find_acquire_program(SWIG)
get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
get_filename_component(SWIG_DIR "${SWIG}" DIRECTORY)
set(ENV{PATH} ";$ENV{PATH};${PYTHON3_DIR};${SWIG_DIR}")

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
#    DISABLE_PARALLEL_CONFIGURE
    OPTIONS_DEBUG # automatic templates
        -DDISABLE_INSTALL_HEADERS=ON # automatic templates
#        -D =OFF
#    OPTIONS_RELEASE
#        -D =OFF
    OPTIONS
#        -DDOXYGEN_DOT_EXECUTABLE:FILEPATH=E:/tools/vcpkg/installed/x64-windows/tools/graphviz/dot.exe
#        -DDOXYGEN_EXECUTABLE:FILEPATH=E:/tools/vcpkg/installed/x64-windows/tools/doxygen/doxygen.exe
#        -DENABLE_APPS:BOOL=ON
        -DENABLE_DOCS:BOOL=OFF
#        -DENABLE_LIBRARY:BOOL=ON
        -DENABLE_TESTS:BOOL=OFF
#        -DLIB_SUFFIX:STRING=
#        -DPYTHON3_CONFIG_EXECUTABLE:FILEPATH=
#        -DPYTHON_CONFIG_EXECUTABLE:FILEPATH=I:/DocSysMicro/MSVCShared/Anaconda3_64/python.exe-config
#        -DSOAPY_SDR_ROOT:PATH=
#        -DSOAPY_SDR_ROOT_ENV:STRING=
#        -DSWIG_DIR:PATH=E:/tools/swigwin/3.0.12/bin/Lib
#        -DSWIG_EXECUTABLE:FILEPATH=E:/tools/swigwin/3.0.12/bin/swig.exe
#        -DSWIG_VERSION:STRING=3.0.12
#        -DUSE_PYTHON_CONFIG:BOOL=ON
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE_1_0.txt ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
