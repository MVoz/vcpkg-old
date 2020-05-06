include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/LLNL/sundials/archive/4270cd115373268df6585a2db4053fadb4bf79e8.zip"
    FILENAME "sundials.zip"
    SHA512 7857e06ecd6af7a54199e747c1ab73422a43b7f10a27c567bdea7f5da4239c46debf99fcd957d76e1a7bb35a22ebcbedd8779651000a74f04511d4cd593a92aa
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

#set(VCPKG_FORTRAN_ENABLED ON)
#vcpkg_enable_fortran(intel)

#include(FindCUDA)
#find_package(CUDA REQUIRED)
#set(CUDA_NVCC_FLAGS ${CUDA_NVCC_FLAGS} -gencode arch=compute_30,code=sm_30)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates
    OPTIONS
      -DBUILD_ARKODE=ON
      -DBUILD_CVODE=ON
      -DBUILD_CVODES=ON
      -DBUILD_IDA=ON
      -DBUILD_IDAS=ON
      -DBUILD_KINSOL=ON
      -DBUILD_TESTING=OFF
      -DCUDA_ENABLE=OFF # No CMAKE_CUDA_COMPILER could be found
      -DEXAMPLES_ENABLE_C=OFF
      -DEXAMPLES_ENABLE_CXX=OFF
      -DEXAMPLES_INSTALL=OFF
#      -DF2003_INTERFACE_ENABLE=OFF
#      -DF77_INTERFACE_ENABLE=OFF
      -DHYPRE_ENABLE=ON
#      -DKLU_ENABLE=OFF
      -DLAPACK_ENABLE=OFF # LAPACK is not compatible with 64 integers
      -DMPI_ENABLE=OFF # for MPI-2 support... FAILED
#      -DOPENMP_DEVICE_ENABLE=OFF
#      -DOPENMP_ENABLE=OFF
      -DPETSC_ENABLE=OFF
#      -DPTHREAD_ENABLE=OFF
      -DRAJA_ENABLE=OFF
#      -DSUNDIALS_INDEX_SIZE:STRING=64
#      -DSUNDIALS_PRECISION:STRING=double
      -DSUPERLUDIST_ENABLE=OFF # Could not find SuperLU_DIST. SUPERLUDIST_INCLUDE_DIR and SUPERLUDIST_LIBRARY_DIR
#      -DSUPERLUMT_ENABLE=OFF
#      -DTrilinos_ENABLE=OFF
#      -DUSE_XSDK_DEFAULTS=OFF	  
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
