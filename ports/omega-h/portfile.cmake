include(vcpkg_common_functions)

find_program(GIT NAMES git git.cmd)
set(GIT_URL "https://github.com/SNLComputation/omega_h")
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
    NO_CHARSET_FLAG # automatic templates

    OPTIONS 
#      -DEGADS_PREFIX=
      -DOmega_h_USE_OpenMP=OFF
      -DOmega_h_USE_CUDA=ON
      -DOmega_h_USE_SEACASExodus=OFF
      -DSEACASExodus_PREFIX=OFF
      -DBUILD_TESTING=OFF
#      -DKokkos_PREFIX=
#      -DOmega_h_ARCH=
#      -DOmega_h_CHECK_BOUNDS=OFF
#      -DOmega_h_CMAKE_ARGS=-DCMAKE_INSTALL_PREFIX="E:/tools/vcpkg/packages/omega-h_x64-windows" -DOmega_h_USE_OpenMP="OFF" -DOmega_h_USE_CUDA="OFF" -DOmega_h_ARCH=""
#      -DOmega_h_CXX_FLAGS=
#      -DOmega_h_CXX_OPTIMIZE=ON
#      -DOmega_h_CXX_SYMBOLS=ON
#      -DOmega_h_CXX_WARNINGS=ON
#      -DOmega_h_DATA=
      -DOmega_h_EXAMPLES=OFF
#      -DOmega_h_EXTRA_CXX_FLAGS=
#      -DOmega_h_NORMAL_CXX_FLAGS=OFF
#      -DOmega_h_THROW=OFF
#      -DOmega_h_USE_CUDA=OFF
#      -DOmega_h_USE_CUDA_AWARE_MPI=OFF
#      -DOmega_h_USE_DOLFIN=OFF
#      -DOmega_h_USE_EGADS=OFF
#      -DOmega_h_USE_Gmodel=OFF
#      -DOmega_h_USE_Kokkos=OFF
      -DOmega_h_USE_MPI=ON
#      -DOmega_h_USE_OpenMP=OFF
#      -DOmega_h_USE_SEACASExodus=OFF
      -DOmega_h_USE_ZLIB=ON
#      -DOmega_h_USE_libMeshb=OFF
      -DOmega_h_USE_pybind11=OFF
#      -DOmega_h_VALGRIND=
#      -DUSE_XSDK_DEFAULTS=OFF
#      -DZLIB_PREFIX=${CURRENT_INSTALLED_DIR}
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
