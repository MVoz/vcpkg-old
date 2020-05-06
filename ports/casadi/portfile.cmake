include(vcpkg_common_functions)

find_program(GIT NAMES git git.cmd)
set(GIT_URL "https://github.com/casadi/casadi")
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

#Python or Matlab/Octave requires SWIG

vcpkg_find_acquire_program(PYTHON3)
#vcpkg_find_acquire_program(SWIG)

#get_filename_component(SWIG_DIR "${SWIG}" DIRECTORY)
get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)

#set(ENV{PATH} "$ENV{PATH};${PYTHON3_DIR};${SWIG_DIR}")

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates

    OPTIONS 
      -DBIN_PREFIX=bin
      -DCMAKE_PREFIX=cmake
      -DENABLE_EXPORT_ALL=OFF
      -DFORTRAN_REQUIRED=OFF
      -DINCLUDE_PREFIX=include
      -DLIB_PREFIX=lib
      -DMATLAB_PREFIX=matlab
      -DOLD_LLVM=OFF
      -DPYTHON_PREFIX=${PYTHON3}
      -DSWIG_EXPORT=OFF
      -DSWIG_IMPORT=OFF
      -DWITH_AMPL=OFF
      -DWITH_BLASFEO=ON
      -DWITH_BLOCKSQP=OFF
      -DWITH_BONMIN=OFF
      -DWITH_BUILD_BLASFEO=OFF
      -DWITH_BUILD_CSPARSE=ON
      -DWITH_BUILD_DSDP=ON
      -DWITH_BUILD_HPMPC=ON
      -DWITH_BUILD_SNOPT_INTERFACE=ON
      -DWITH_BUILD_SUNDIALS=ON
      -DWITH_BUILD_TINYXML=ON
      -DWITH_CLANG=OFF
      -DWITH_CLANG_TIDY=OFF
      -DWITH_CLP=OFF
      -DWITH_COMMON=OFF
      -DWITH_COVERAGE=OFF
      -DWITH_CPLEX=OFF
      -DWITH_CPLEX_SHARED=OFF
      -DWITH_CSPARSE=ON
      -DWITH_DEEPBIND=ON
      -DWITH_DEPRECATED_FEATURES=ON
      -DWITH_DL=ON
      -DWITH_DOC=OFF
      -DWITH_DSDP=OFF
      -DWITH_EXAMPLES=OFF
      -DWITH_EXTENDING_CASADI=OFF
      -DWITH_EXTRA_CHECKS=OFF
      -DWITH_EXTRA_WARNINGS=OFF
      -DWITH_GUROBI=OFF
      -DWITH_HPMPC=OFF
      -DWITH_HSL=OFF
      -DWITH_IPOPT=OFF
      -DWITH_JSON=ON
      -DWITH_KNITRO=OFF
      -DWITH_LAPACK=ON
      -DWITH_LINT=OFF
      -DWITH_MATLAB=OFF
      -DWITH_NO_QPOASES_BANNER=OFF
      -DWITH_OCTAVE=OFF
      -DWITH_OCTAVE_IMPORT=OFF
      -DWITH_OOQP=OFF
      -DWITH_OPENCL=ON
      -DWITH_OPENMP=OFF
      -DWITH_PYTHON=OFF
      -DWITH_PYTHON3=OFF
      -DWITH_QPOASES=OFF
      -DWITH_REFCOUNT_WARNINGS=OFF
      -DWITH_SELFCONTAINED=OFF
      -DWITH_SLICOT=OFF
      -DWITH_SNOPT=OFF
      -DWITH_SNOPT_FORCE_DUMMY=OFF
      -DWITH_SO_VERSION=ON
      -DWITH_SPELL=OFF
      -DWITH_SQIC=OFF
      -DWITH_SUNDIALS=ON
      -DWITH_THREAD=OFF
      -DWITH_THREAD_MINGW=OFF
      -DWITH_TINYXML=ON
      -DWITH_WERROR=OFF
      -DWITH_WORHP=OFF
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
