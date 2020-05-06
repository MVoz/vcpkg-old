include(vcpkg_common_functions)

find_program(GIT NAMES git git.cmd)
set(GIT_URL "https://github.com/atframework/libatbus")
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
get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
set(ENV{PATH} "$ENV{PATH};${PYTHON3_DIR}")

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates

    OPTIONS 
      -DCOMPILER_OPTION_MSVC_ZC_CPP:BOOL=ON
      -DCRYPTO_DISABLED:BOOL=ON
      -DENABLE_NETWORK:BOOL=OFF
      -DGTEST_ROOT=${CURRENT_INSTALLED_DIR}
      -DLIBUNWIND_ENABLED:BOOL=OFF
      -DLIBUV_ROOT=${CURRENT_INSTALLED_DIR}
      -DLOCK_DISABLE_MT:BOOL=ON
      -DLOG_WRAPPER_CHECK_LUA:BOOL=OFF
      -DLOG_WRAPPER_ENABLE_LUA_SUPPORT:BOOL=OFF
      -DLOG_WRAPPER_ENABLE_STACKTRACE:BOOL=ON
      -DPROJECT_ENABLE_SAMPLE:BOOL=OFF
      -DPROJECT_ENABLE_UNITTEST:BOOL=OFF
      -DPROJECT_TEST_ENABLE_BOOST_UNIT_TEST:BOOL=OFF
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
