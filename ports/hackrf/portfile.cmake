
include(vcpkg_common_functions)

find_program(GIT NAMES git git.cmd)
set(GIT_URL "https://github.com/mossmann/hackrf")
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

# https://anaconda.org/omnia/fftw3f/3.3.4/download/win-64/fftw3f-3.3.4-2.tar.bz2
# libfftwf-3.3.lib(assert.obj) : error LNK2019: unresolved external symbol __iob_func referenced in function fftwf_assertion_failed

# libfftw3f-3.lib(timer.obj) : error LNK2019: unresolved external symbol __imp_clock referenced in function fftwf_elapsed_since
vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}/host
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
#    DISABLE_PARALLEL_CONFIGURE
    OPTIONS_DEBUG # automatic templates
        -DDISABLE_INSTALL_HEADERS=ON # automatic templates
		-DFFTW_LIBRARIES=${CURRENT_INSTALLED_DIR}/debug/lib/libfftwf-3.3.lib 
		-DLIBUSB_LIBRARIES=${CURRENT_INSTALLED_DIR}/debug/lib/libusb-1.0.lib
		-DTHREADS_PTHREADS_WIN32_LIBRARY=${CURRENT_INSTALLED_DIR}/debug/lib/pthreadVC3d.lib
    OPTIONS 
		-DFFTW_LIBRARIES=${CURRENT_INSTALLED_DIR}/lib/libfftwf-3.3.lib 
		-DLIBUSB_INCLUDE_DIR=${CURRENT_INSTALLED_DIR}/include/libusb-1.0
		-DFFTW_INCLUDES=${CURRENT_INSTALLED_DIR}/include
		-DLIBUSB_LIBRARIES=${CURRENT_INSTALLED_DIR}/lib/libusb-1.0.lib
		-DTHREADS_PTHREADS_WIN32_LIBRARY=${CURRENT_INSTALLED_DIR}/lib/pthreadVC3.lib
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
