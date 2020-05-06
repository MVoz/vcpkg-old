include(vcpkg_common_functions)

#vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

find_program(GIT NAMES git git.cmd)
set(GIT_URL "https://github.com/arrayfire/arrayfire")
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

vcpkg_find_acquire_program(PYTHON3)
#vcpkg_find_acquire_program(DOXYGEN)
#get_filename_component(DOXYGEN_DIR "${DOXYGEN}" DIRECTORY)
get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
set(ENV{PATH} "$ENV{PATH};${PYTHON3_DIR}")

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates
    OPTIONS 
      -DAF_BUILD_CPU:BOOL=ON
      -DAF_BUILD_CUDA:BOOL=ON
      -DAF_BUILD_DOCS:BOOL=OFF
      -DAF_BUILD_EXAMPLES:BOOL=OFF
      -DAF_BUILD_FORGE:BOOL=OFF
      -DAF_BUILD_OPENCL:BOOL=ON
      -DAF_BUILD_UNIFIED:BOOL=ON
#      -DAF_OPENCL_BLAS_LIBRARY:STRING=CLBlast
      -DAF_TEST_WITH_MTX_FILES:BOOL=OFF
      -DAF_WITH_IMAGEIO:BOOL=ON
      -DAF_WITH_LOGGING:BOOL=ON
      -DAF_WITH_NONFREE:BOOL=ON
      -DAF_WITH_RELATIVE_TEST_DIR:BOOL=OFF
      -DAF_WITH_STATIC_FREEIMAGE:BOOL=OFF
#      -DArrayFire_DIR:PATH=E:/tools/vcpkg/buildtrees/arrayfire/x64-windows-rel
      -DBUILD_GMOCK:BOOL=OFF
      -DBUILD_TESTING:BOOL=OFF
#      -DCUDA_SDK_ROOT_DIR:PATH=${CUDA_TOOLKIT_ROOT_DIR}
#      -DCUDA_TOOLKIT_ROOT_DIR:PATH=C:/Program Files/PGI/win64/2018/cuda/10.0
      -DINSTALL_GTEST:BOOL=OFF
#      -DMKL_THREAD_LAYER=Intel OpenMP
)

vcpkg_install_cmake() #(DISABLE_PARALLEL)

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
