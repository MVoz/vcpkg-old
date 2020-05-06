include(vcpkg_common_functions)

find_program(GIT NAMES git git.cmd)
set(GIT_URL "https://github.com/EttusResearch/uhd")
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
vcpkg_find_acquire_program(XGETTEXT)
vcpkg_find_acquire_program(DOXYGEN)
vcpkg_find_acquire_program(PERL)
get_filename_component(DOXYGEN_DIR "${DOXYGEN}" DIRECTORY)
get_filename_component(PERL_DIR "${PERL}" DIRECTORY)
get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
get_filename_component(XGETTEXT_DIR "${XGETTEXT}" DIRECTORY)
set(ENV{PATH} ";$ENV{PATH};${PYTHON3_DIR};${DOXYGEN_DIR};${XGETTEXT_DIR};${PERL_DIR}")

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}/host
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
#    DISABLE_PARALLEL_CONFIGURE
    OPTIONS_DEBUG # automatic templates
        -DDISABLE_INSTALL_HEADERS=ON # automatic templates
#        -D =OFF
#    OPTIONS_RELEASE
#        -D =OFF
    OPTIONS 
        -DPYTHON_EXECUTABLE=${PYTHON3}
        -DRUNTIME_PYTHON_EXECUTABLE=${PYTHON3_DIR}
#		-DENABLE_STATIC_LIBS=OFF # ON UHD_LIBRARIES, and UHD_STATIC_LIB_DEPS
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE.md ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
