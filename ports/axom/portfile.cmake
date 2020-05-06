include(vcpkg_common_functions)

find_program(GIT NAMES git git.cmd)
set(GIT_URL "https://github.com/LLNL/axom")
set(GIT_REV develop)
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

set(VCPKG_FORTRAN_ENABLED ON)
vcpkg_enable_fortran(intel)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}/src
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
      -DAXOM_ENABLE_ALL_COMPONENTS=OFF
      -DAXOM_ENABLE_DOCS=OFF
      -DAXOM_ENABLE_EXAMPLES=OFF
      -DAXOM_ENABLE_SPARSEHASH=ON
      -DAXOM_ENABLE_TESTS=OFF
      -DBUILD_GMOCK=OFF
      -DBUILD_GTEST=OFF
      -DBUILD_SHARED_LIBS=ON
      -DBUILD_TESTING=OFF
      -DENABLE_ALL_WARNINGS=ON
      -DENABLE_ASTYLE=OFF
      -DENABLE_BENCHMARKS=OFF
      -DENABLE_COPY_HEADERS=ON
      -DENABLE_COVERAGE=OFF
      -DENABLE_CPPCHECK=OFF
      -DENABLE_CUDA=OFF
      -DENABLE_DOCS=OFF
      -DENABLE_DOXYGEN=OFF
      -DENABLE_EXAMPLES=OFF
      -DENABLE_FOLDERS=OFF
      -DENABLE_FORTRAN=ON
      -DENABLE_FRUIT=ON
      -DENABLE_GIT=ON
      -DENABLE_GMOCK=OFF
      -DENABLE_GTEST=OFF
      -DENABLE_HCC=OFF
      -DENABLE_HIP=OFF
      -DENABLE_MPI=ON
      -DENABLE_OPENMP=ON
      -DENABLE_SPHINX=OFF
      -DENABLE_TESTS=OFF
      -DENABLE_UNCRUSTIFY=OFF
      -DENABLE_VALGRIND=OFF
      -DENABLE_WARNINGS_AS_ERRORS=OFF
      -Dgtest_build_samples=OFF
      -Dgtest_build_tests=OFF
      -Dgtest_disable_pthreads=OFF
      -Dgtest_force_shared_crt=OFF
      -Dgtest_hide_internal_symbols=OFF
)

vcpkg_install_cmake()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/include/fmt ${CURRENT_PACKAGES_DIR}/debug/include)

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
