include(vcpkg_common_functions)

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

find_program(GIT NAMES git git.cmd)
set(GIT_URL "https://github.com/acados/acados")
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
#      -D =OFF # automatic templates
      -DACADOS_EXAMPLES=OFF
      -DACADOS_LINT=OFF
      -DACADOS_MATLAB=OFF
      -DACADOS_OCTAVE=OFF
      -DACADOS_UNIT_TESTS=OFF
      -DACADOS_WITH_HPMPC=OFF #HPMPC has been disabled, not compatible with MSVC
      -DACADOS_WITH_OOQP=OFF
      -DACADOS_WITH_OSQP=OFF #CMake Error at CMakeLists.txt:220 (add_custom_target)  "acados/external/osqp/lin_sys/direct/qdldl/qdldl_sources"
      -DACADOS_WITH_QORE=OFF
      -DACADOS_WITH_QPDUNES=ON
      -DACADOS_WITH_QPOASES=ON
      -DBLASFEO_BENCHMARKS=OFF
      -DBLASFEO_EXAMPLES=OFF
      -DBLASFEO_HEADERS_INSTALLATION_DIRECTORY=include/blasfeo/include
	  -DBLASFEO_PATH=${CURRENT_INSTALLED_DIR}
      -DBLASFEO_LIB=ON
      -DBLASFEO_TARGET=GENERIC # MSVC compiler only supported for TARGET=GENERIC #X64_INTEL_HASWELL
      -DBLASFEO_TESTING=OFF
      -DDEV_MATLAB=OFF
      -DEXTERNAL_BLAS=1
      -DEXT_DEP=ON
      -DHPIPM_TARGET=AVX
      -DK_MAX_STACK=300
      -DLA=HIGH_PERFORMANCE
      -DSWIG_MATLAB=OFF
      -DSWIG_PYTHON=OFF
      -DTARGET=GENERIC # MSVC compiler only supported for TARGET=GENERIC #X64_INTEL_HASWELL
      -DTEMPLATE_MATLAB=OFF
      -DTEMPLATE_PYTHON=OFF
      -DUSE_C99_MATH=ON
      -DHPIPM_BLASFEO_LIB=ON
      -DHPIPM_BLASFEO_PATH=${CURRENT_INSTALLED_DIR}
      -DHPIPM_HEADERS_INSTALLATION_DIRECTORY=include/hpipm/include
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
