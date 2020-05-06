include(vcpkg_common_functions)

find_program(GIT NAMES git git.cmd)
set(GIT_URL "https://github.com/thp/psmoveapi")
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
vcpkg_find_acquire_program(SWIG)

get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
get_filename_component(SWIG_DIR "${SWIG}" DIRECTORY)

set(ENV{PATH} "$ENV{PATH};${SWIG_DIR};${PYTHON3_DIR}")

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates

    OPTIONS 
      -DPSMOVE_BUILD_CSHARP_BINDINGS=OFF
      -DPSMOVE_BUILD_EXAMPLES=OFF
      -DPSMOVE_BUILD_JAVA_BINDINGS=OFF
      -DPSMOVE_BUILD_OPENGL_EXAMPLES=OFF
      -DPSMOVE_BUILD_PROCESSING_BINDINGS=ON
      -DPSMOVE_BUILD_PYTHON_BINDINGS=OFF
      -DPSMOVE_BUILD_TESTS=OFF
      -DPSMOVE_USE_PSEYE=ON
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/COPYING ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###