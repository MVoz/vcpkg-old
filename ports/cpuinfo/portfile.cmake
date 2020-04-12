include(vcpkg_common_functions)

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

find_program(GIT NAMES git git.cmd)
set(GIT_URL "https://github.com/hunter-packages/cpuinfo")
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
#    GENERATOR "NMake Makefiles" # automatic templates
#    DISABLE_PARALLEL_CONFIGURE
    OPTIONS_DEBUG # automatic templates
      -DDISABLE_INSTALL_HEADERS=ON # automatic templates
      -DINSTALL_HEADERS_TOOLS=OFF
      -DINSTALL_HEADERS=OFF
    OPTIONS_RELEASE 
      -DINSTALL_HEADERS=ON # automatic templates
#      -D =OFF
    OPTIONS 
#      -DBENCHMARK_BUILD_32_BITS=OFF
      -DBENCHMARK_ENABLE_EXCEPTIONS=ON
      -DBENCHMARK_ENABLE_LTO=OFF
      -DBENCHMARK_ENABLE_TESTING=OFF
      -DBENCHMARK_USE_LIBCXX=OFF
      -DBUILD_GMOCK=OFF
      -DBUILD_GTEST=OFF
      -DBUILD_SHARED_LIBS=OFF
      -DCLOG_BUILD_TESTS=OFF
      -DCLOG_LOG_TO_STDIO=ON
      -DCPUINFO_BUILD_BENCHMARKS=OFF
      -DCPUINFO_BUILD_MOCK_TESTS=OFF
      -DCPUINFO_BUILD_TOOLS=OFF
      -DCPUINFO_BUILD_UNIT_TESTS=OFF
      -Dgmock_build_tests=OFF
      -Dgtest_build_samples=OFF
      -Dgtest_build_tests=OFF
      -Dgtest_disable_pthreads=OFF
      -Dgtest_force_shared_crt=OFF
      -Dgtest_hide_internal_symbols=OFF
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
