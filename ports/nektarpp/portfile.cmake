include(vcpkg_common_functions)

#vcpkg_download_distfile(ARCHIVE
#    URLS "https://www.nektar.info/downloads/file/nektar-source-tar-gz-3/"
#    FILENAME "nektar-4.4.1.tar.gz"
#    SHA512 38a7777d83dee6ae5dd4480a59b23843ee774de90476c81b0f4912d7b1ea8730209976605bb4228d2464a6407f2f26b4dd7bf0d876397f3fb5b158d217b793f1
#)
#vcpkg_extract_source_archive_ex(
#    OUT_SOURCE_PATH SOURCE_PATH
#    ARCHIVE ${ARCHIVE}
#)

find_program(GIT NAMES git git.cmd)
set(GIT_URL "https://gitlab.nektar.info/nektar/nektar")
set(GIT_REV master)
set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/${PORT})
if(NOT EXISTS "${SOURCE_PATH}/.git")
    message(STATUS "Cloning and fetching submodules")
    vcpkg_execute_required_process(
      COMMAND ${GIT} clone ${GIT_URL} ${SOURCE_PATH}
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

vcpkg_find_acquire_program(PYTHON3)
#vcpkg_find_acquire_program(QT5)
#vcpkg_find_acquire_program(TEXLIVE)
#vcpkg_find_acquire_program(XGETTEXT)
#vcpkg_find_acquire_program(DOXYGEN)
#vcpkg_find_acquire_program(DOXYGEN)
vcpkg_find_acquire_program(PERL)
vcpkg_find_acquire_program(FLEX)
vcpkg_find_acquire_program(BISON)
vcpkg_find_acquire_program(YASM)
get_filename_component(FLEX_DIR "${FLEX}" DIRECTORY)
get_filename_component(BISON_DIR "${BISON}" DIRECTORY)
#get_filename_component(DOXYGEN_DIR "${DOXYGEN}" DIRECTORY)
get_filename_component(PERL_DIR "${PERL}" DIRECTORY)
#get_filename_component(QT5_DIR "${QT5}" DIRECTORY)
get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
#get_filename_component(DOXYGEN_DIR "${DOXYGEN}" DIRECTORY)
#get_filename_component(XGETTEXT_DIR "${XGETTEXT}" DIRECTORY)
#get_filename_component(TEXLIVE_DIR "${TEXLIVE}" DIRECTORY)

get_filename_component(YASM_EXE_PATH ${YASM} DIRECTORY)

get_filename_component(GIT_EXE_PATH ${GIT} DIRECTORY)
set(SH_EXE_PATH "${GIT_EXE_PATH}/../usr/bin")
set(ENV{PATH} ";$ENV{PATH};${YASM_EXE_PATH};${PYTHON3_DIR};${FLEX_DIR};${BISON_DIR};${PERL_DIR};${SH_EXE_PATH}")
#${NEKTAR_SRC}/ThirdParty

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates

    OPTIONS 
      -DNEKTAR_BUILD_DEMOS=OFF
      -DNEKTAR_BUILD_DOC=OFF
      -DNEKTAR_BUILD_LIBRARY=ON
      -DNEKTAR_BUILD_SOLVERS=OFF
      -DNEKTAR_BUILD_TESTS=OFF
      -DNEKTAR_BUILD_TIMINGS=OFF
      -DNEKTAR_BUILD_UNIT_TESTS=OFF
      -DNEKTAR_BUILD_UTILITIES=OFF
#      -DNEKTAR_SOLVER_ADR=ON
#      -DNEKTAR_SOLVER_APE=ON
#      -DNEKTAR_SOLVER_CARDIAC_EP=ON
#      -DNEKTAR_SOLVER_COMPRESSIBLE_FLOW=ON
#      -DNEKTAR_SOLVER_DIFFUSION=ON
#      -DNEKTAR_SOLVER_ELASTICITY=ON
#      -DNEKTAR_SOLVER_INCNAVIERSTOKES=ON
#      -DNEKTAR_SOLVER_PULSEWAVE=ON
#      -DNEKTAR_SOLVER_SHALLOW_WATER=ON
      -DNEKTAR_TEST_ALL=OFF
#	  -DNEKTAR_SOLVER_=ON	  
      -DNEKTAR_TEST_USE_HOSTFILE=OFF
      -DTHIRDPARTY_USE_SSL=ON
      -DTHIRDPARTY_BUILD_GSMPI=ON
	  -DTHIRDPARTY_BUILD_BLAS_LAPACK=OFF
      -DTHIRDPARTY_BUILD_METIS=ON
      -DTHIRDPARTY_BUILD_PETSC=ON
      -DTHIRDPARTY_BUILD_SCOTCH=ON
      -DTHIRDPARTY_BUILD_BOOST=OFF
      -DTHIRDPARTY_BUILD_LOKI=ON
      -DTHIRDPARTY_BUILD_SMV=ON
      -DTHIRDPARTY_BUILD_TINYXML=OFF
      -DTHIRDPARTY_BUILD_ZLIB=OFF
      -DTHIRDPARTY_BUILD_OCE=ON
      -DNEKTAR_USE_ACML=OFF
	  -DNEKTAR_USE_ACCELERATE_FRAMEWORK=OFF
      -DNEKTAR_USE_ARPACK=ON
      -DNEKTAR_USE_SYSTEM_BLAS_LAPACK=OFF
      -DNEKTAR_USE_BOOST=OFF
	  -DNEKTAR_USE_CWIPI=OFF
	  -DNEKTAR_USE_GSMPI=OFF
	  -DNEKTAR_USE_METIS=OFF
      -DNEKTAR_USE_BLAS_LAPACK=OFF
      -DNEKTAR_USE_CCM=OFF #Use the ccmio library provided with the Star-CCM package for reading ccm files
      -DNEKTAR_USE_FFTW=OFF #Found FFTW: lib/fftw3.lib CMake Error at cmake/ThirdPartyFFTW.cmake:63
      -DNEKTAR_USE_HDF5=OFF #This option requires that Nektar++ be built with MPI support with NEKTAR_USE_MPI enabled and that HDF5 is compiled with MPI support
      -DNEKTAR_USE_MKL=ON
      -DNEKTAR_USE_TINYXML=ON
      -DNEKTAR_USE_OCE=OFF
	  -DNEKTAR_USE_MESHGEN=OFF #Open CASCADE Community Edition – Library used in mesh generation
      -DNEKTAR_USE_MPI=OFF
      -DNEKTAR_USE_OPENBLAS=ON
      -DNEKTAR_USE_PETSC=OFF
      -DNEKTAR_USE_SMV=OFF #Build Nektar++ with support for optimised sparse matrix-vector operations
      -DNEKTAR_USE_VTK=OFF
      -DNEKTAR_USE_WIN32_LAPACK=ON
    OPTIONS_DEBUG # automatic templates
#      -DWIN32_BLAS=${CURRENT_INSTALLED_DIR}/debug/lib/libblas.lib
#      -DWIN32_LAPACK=${CURRENT_INSTALLED_DIR}/debug/lib/liblapack.lib
	  -DZLIB_ROOT=${CURRENT_INSTALLED_DIR}/debug #cmake/ThirdPartyZlib.cmake:19 (FIND_PACKAGE)
	  -DTINYXML_ROOT=${CURRENT_INSTALLED_DIR}/debug
      -DLAPACK_DIR=${CURRENT_INSTALLED_DIR}/debug/lib
    OPTIONS_RELEASE 
#      -DWIN32_BLAS=${CURRENT_INSTALLED_DIR}/lib/libblas.lib
#      -DWIN32_LAPACK=${CURRENT_INSTALLED_DIR}/lib/liblapack.lib
	  -DZLIB_ROOT=${CURRENT_INSTALLED_DIR} #cmake/ThirdPartyZlib.cmake:19 (FIND_PACKAGE)
	  -DTINYXML_ROOT=${CURRENT_INSTALLED_DIR}
      -DLAPACK_DIR=${CURRENT_INSTALLED_DIR}/lib
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
