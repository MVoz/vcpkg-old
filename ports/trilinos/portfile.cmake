include(vcpkg_common_functions)

find_program(GIT NAMES git git.cmd)
set(GIT_URL "https://github.com/trilinos/Trilinos")
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

set(GIT_URL "https://github.com/trilinos/ForTrilinos")
set(GIT_REV master)
set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/${PORT}/ForTrilinos)
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

set(VCPKG_FORTRAN_ENABLED ON)
vcpkg_enable_fortran(intel)

vcpkg_find_acquire_program(PYTHON3)
vcpkg_find_acquire_program(SWIG)
get_filename_component(SWIG_DIR "${SWIG}" DIRECTORY)
get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)

get_filename_component(GIT_EXE_PATH ${GIT} DIRECTORY)
set(SH_EXE_PATH "${GIT_EXE_PATH}/../usr/bin")
set(ENV{PATH} "$ENV{PATH};${SWIG_DIR};${PYTHON3_DIR};${SH_EXE_PATH}")

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates
    OPTIONS
      -DTrilinos_ENABLE_Amesos=ON
      -DTrilinos_ENABLE_EpetraExt=ON
      -DTrilinos_ENABLE_Ifpack=ON
      -DTrilinos_ENABLE_AztecOO=ON
      -DTrilinos_ENABLE_Sacado=ON
      -DTrilinos_ENABLE_Teuchos=ON
      -DTrilinos_ENABLE_MueLu=ON
      -DTrilinos_ENABLE_ML=ON
      -DTrilinos_ENABLE_ROL=ON
      -DTrilinos_ENABLE_Tpetra=ON
      -DTpetra_INST_COMPLEX_DOUBLE=ON
      -DTpetra_INST_COMPLEX_FLOAT=ON
      -DTrilinos_ENABLE_Zoltan=ON
      -DTrilinos_VERBOSE_CONFIGURE=OFF
      -DTPL_ENABLE_MPI=ON
#      -DBUILD_SHARED_LIBS=ON
      -DCMAKE_VERBOSE_MAKEFILE=OFF
      -DTrilinos_ENABLE_Fortran=OFF
      -DTrilinos_ENABLE_EXPLICIT_INSTANTIATION=ON
      -DTpetra_INST_INT_INT=OFF
      -DTpetra_INST_INT_LONG=OFF
      -DTpetra_INST_INT_LONG_LONG=ON
      -DTeuchos_ENABLE_LONG_LONG_INT=OFF
      -DTrilinos_ENABLE_ALL_PACKAGES=OFF
      -DTrilinos_ENABLE_ALL_OPTIONAL_PACKAGES=ON
      -DTrilinos_ENABLE_TESTS=OFF
      -DTrilinos_ENABLE_EXAMPLES=OFF
      -DTrilinos_EXTRA_REPOSITORIES="ForTrilinos"
      -DTrilinos_ENABLE_TriKota=OFF
      -DTrilinos_ENABLE_ThyraTpetraAdapters=OFF
      -DTrilinos_ENABLE_Amesos2=OFF
      -DTrilinos_ENABLE_Epetra=ON
      -DTrilinos_ENABLE_Ifpack2=OFF
      -DTrilinos_ENABLE_ForTrilinos=ON
      -DForTrilinos_ENABLE_EXAMPLES=OFF
      -DForTrilinos_ENABLE_TESTS=OFF
      -DTPL_ENABLE_BLAS=ON
      -DTPL_ENABLE_LAPACK=ON
      -DForTrlinos_ENABLE_ReadTheDocs=OFF
      -DTrilinos_ENABLE_Kokkos=OFF
      -DTPL_ENABLE_CUDA=OFF
      -DTrilinos_ENABLE_COMPLEX=OFF
      -DTrilinos_ENABLE_Belos=OFF
      -DTrilinos_ENABLE_Anasazi=OFF
      -DTrilinos_ENABLE_Thyra=OFF
      -DTrilinos_ENABLE_Stratimikos=OFF
      
      ###https://github.com/trilinos/Trilinos/wiki/BlockCRS-Benchmark
#      -DKOKKOS_DEVICES="OpenMP,Cuda"
#      -DKOKKOS_ARCH="SNB,Kepler35"

#      -DTrilinos_ENABLE_KokkosCore:BOOL=ON
#      -DTrilinos_ENABLE_KokkosAlgorithms:BOOL=ON
#      -DTrilinos_ENABLE_ALL_PACKAGES:BOOL=OFF   
#      -DTrilinos_ENABLE_ALL_OPTIONAL_PACKAGES:BOOL=OFF
#      -DTeuchos_ENABLE_LONG_LONG_INT:BOOL=OFF
#      -DCMAKE_BUILD_TYPE:STRING=${BUILD_TYPE}
#      -DCMAKE_CXX_COMPILER:FILEPATH="mpicxx"
#      -DCMAKE_SKIP_RULE_DEPENDENCY=ON
#      -DCMAKE_INSTALL_PREFIX:PATH=${INSTALL_DIR}
      -DTPL_ENABLE_GLM=OFF
#      -DTPL_ENABLE_LAPACK:BOOL=ON
#      -DTPL_ENABLE_BLAS:BOOL=ON
#      -DCMAKE_SKIP_RULE_DEPENDENCY=ON
#      -DTrilinos_ENABLE_OpenMP=${USE_OPENMP}
#      -DKokkos_ENABLE_OpenMP:BOOL=${USE_OPENMP}
#      -DKokkos_ENABLE_TESTS:BOOL=ON
#      -DTPL_ENABLE_CUDA:BOOL=${USE_CUDA}
#      -DTPL_ENABLE_CUSPARSE:BOOL=${USE_CUDA}
#      -DKokkos_ENABLE_Cuda:BOOL=${USE_CUDA}
#      -DKokkos_ENABLE_Cuda_UVM:BOOL=${USE_CUDA}
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
