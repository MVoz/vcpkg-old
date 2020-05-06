include(vcpkg_common_functions)

find_program(GIT NAMES git git.cmd)
set(GIT_URL "https://github.com/airspy/airspyhf")
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

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
#    DISABLE_PARALLEL_CONFIGURE
    OPTIONS_DEBUG # automatic templates
        -DDISABLE_INSTALL_HEADERS=ON # automatic templates
		-DLIBUSB_LIBRARIES=${CURRENT_INSTALLED_DIR}/debug/lib/libusb-1.0.lib
		-DTHREADS_PTHREADS_WIN32_LIBRARY=${CURRENT_INSTALLED_DIR}/debug/lib/pthreadVC3d.lib
    OPTIONS 
        -DBUILD_SHARED_LIBS=ON # automatic templates
		-DLIBUSB_LIBRARIES=${CURRENT_INSTALLED_DIR}/lib/libusb-1.0.lib
		-DTHREADS_PTHREADS_WIN32_LIBRARY=${CURRENT_INSTALLED_DIR}/lib/pthreadVC3.lib
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
