include(vcpkg_common_functions)

find_program(GIT NAMES git git.cmd)
set(GIT_URL "https://github.com/Project-OSRM/osrm-backend")
set(GIT_REV master)
set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/${PORT})
if(NOT EXISTS "${SOURCE_PATH}/.git")
    message(STATUS "Cloning")
    vcpkg_execute_required_process(
      COMMAND ${GIT} clone --recurse-submodules -q --depth=20 --branch=${GIT_REV} ${GIT_URL} ${SOURCE_PATH}
      WORKING_DIRECTORY ${SOURCE_PATH}
      LOGNAME clone
    )
    message(STATUS "Fetching submodules")
    vcpkg_execute_required_process(
      COMMAND ${GIT} submodule update --init --recursive
      WORKING_DIRECTORY ${SOURCE_PATH}
      LOGNAME submodules
    )
endif()

#vcpkg_find_acquire_program(NPM)
#get_filename_component(NPM_DIR "${NPM}" DIRECTORY)
#set(ENV{PATH} "$ENV{PATH};${NPM_DIR}")

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates
	DISABLE_PARALLEL_CONFIGURE

    OPTIONS 
      -DWITH_COVERAGE:BOOL=OFF
      -DWITH_CXX11ABI:BOOL=OFF
      -DWITH_EGL:BOOL=OFF
      -DWITH_ERROR:BOOL=OFF
      -DWITH_NODEJS:BOOL=OFF
      -DWITH_OSMESA:BOOL=OFF
#      -Dnpm_EXECUTABLE="C:/Program Files (x86)/nodejs/npm"
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
