include(vcpkg_common_functions)

find_program(GIT NAMES git git.cmd)
set(GIT_URL "https://github.com/LLNL/zfp")
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

set(VCPKG_FORTRAN_ENABLED ON)
vcpkg_enable_fortran(intel)

### BUILD_ZFPY=ON _ CYTHON

#vcpkg_find_acquire_program(PYTHON3)
#get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)

#set(ENV{PYTHONHOME} ${PYTHON3_DIR})
#set(ENV{PYTHONPATH} ${PYTHONHOME}/Lib;${PYTHONHOME}/Lib/site-packages;${PYTHONHOME}/DLL)

#set(ENV{PYTHONSCRIPT} "${PYTHONHOME}/Scripts")
#set(ENV{PYTHON_EXECUTABLE} "${PYTHONHOME}/python.exe")
#set(ENV{PYTHON_INCLUDE_DIR} "${PYTHONHOME}/include")
#set(ENV{PYTHON_LIBRARY} "${PYTHONHOME}/libs/python37.lib;${PYTHONHOME}/libs")

#set(CYTHON_DIR "${PYTHON3_DIR}/Scripts")
#set(ENV{PATH} "$ENV{PATH};${PYTHON3_DIR};${CYTHON_DIR}")

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
      -DBUILD_ALL=OFF
      -DBUILD_CFP=ON
      -DBUILD_EXAMPLES=OFF
      -DBUILD_GMOCK=OFF
      -DBUILD_SHARED_LIBS=ON
      -DBUILD_TESTING=OFF
      -DBUILD_UTILITIES=OFF
      -DBUILD_ZFORP=OFF
      -DBUILD_ZFPY=OFF
      -DINSTALL_GTEST=OFF
#      -DZFP_BIT_STREAM_WORD_SIZE:STRING=64
      -DZFP_BUILD_TESTING_LARGE=OFF
      -DZFP_BUILD_TESTING_SMALL=OFF
      -DZFP_ENABLE_PIC=ON
      -DZFP_WITH_ALIGNED_ALLOC=OFF
      -DZFP_WITH_BIT_STREAM_STRIDED=OFF
      -DZFP_WITH_CACHE_FAST_HASH=OFF
      -DZFP_WITH_CACHE_PROFILE=OFF
      -DZFP_WITH_CACHE_TWOWAY=OFF
      -DZFP_WITH_CUDA=OFF
      -DZFP_WITH_OPENMP=ON
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
