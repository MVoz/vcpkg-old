include(vcpkg_common_functions)

find_program(GIT git)
set(GIT_URL "https://github.com/pothosware/PothosCore.git")
set(GIT_REV "427ef696e06b7b6b19a7d7ec11868bda0d26beaf")
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
set(ENV{PATH} ";$ENV{PATH};${PYTHON3_DIR}")

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
#    DISABLE_PARALLEL_CONFIGURE
    OPTIONS_DEBUG # automatic templates
        -DDISABLE_INSTALL_HEADERS=ON
#        -D =OFF
#    OPTIONS_RELEASE
#        -D =OFF
#    OPTIONS 
#        -DAPACHE_INCLUDE_DIR:PATH=
#        -DAPPDATA_ENV:STRING=APPDATA
#        -DAPRUTIL_INCLUDE_DIR:PATH=
#        -DAPRUTIL_LIBRARY:FILEPATH=
#        -DAPR_INCLUDE_DIR:PATH=
#        -DAPR_LIBRARY:FILEPATH=
#        -DATOMIC_LIBRARIES:FILEPATH=
#        -DCYGWIN_BAT:FILEPATH=C:/cygwin/Cygwin.bat
#        -DDISABLE_CPP11:BOOL=OFF
#        -DDISABLE_CPP14:BOOL=OFF
#        -DDOXYGEN_DOT_EXECUTABLE:FILEPATH=E:/tools/vcpkg/installed/x64-windows/tools/graphviz/dot.exe
#        -DDOXYGEN_EXECUTABLE:FILEPATH=E:/tools/vcpkg/installed/x64-windows/tools/doxygen/doxygen.exe
#        -DENABLE_BLOCKS:BOOL=ON
#        -DENABLE_BLOCKS_EVENT:BOOL=ON
#        -DENABLE_BLOCKS_FILE:BOOL=ON
#        -DENABLE_BLOCKS_NETWORK:BOOL=ON
#        -DENABLE_BLOCKS_PACKET:BOOL=ON
#        -DENABLE_BLOCKS_SERIALIZE:BOOL=ON
#        -DENABLE_BLOCKS_STREAM:BOOL=ON
#        -DENABLE_BLOCKS_TESTERS:BOOL=ON
#        -DENABLE_COMMS:BOOL=ON
#        -DENABLE_COMMS_DEMOD:BOOL=ON
#        -DENABLE_COMMS_DIGITAL:BOOL=ON
#        -DENABLE_COMMS_FFT:BOOL=ON
#        -DENABLE_COMMS_FILTER:BOOL=ON
#        -DENABLE_COMMS_MAC:BOOL=ON
#        -DENABLE_COMMS_MATH:BOOL=ON
#        -DENABLE_COMMS_UTILITY:BOOL=ON
#        -DENABLE_COMMS_WAVEFORM:BOOL=ON
#        -DENABLE_CPPPARSER:BOOL=OFF
#        -DENABLE_DATA_MYSQL:BOOL=ON
#        -DENABLE_DATA_ODBC:BOOL=ON
#        -DENABLE_DATA_SQLITE:BOOL=ON
#        -DENABLE_ENCODINGS:BOOL=ON
#        -DENABLE_ENCODINGS_COMPILER:BOOL=OFF
#        -DENABLE_INTERNAL_POCO:BOOL=ON
#        -DENABLE_JSON:BOOL=ON
#        -DENABLE_LIBRARY:BOOL=ON
#        -DENABLE_LIBRARY_APPS:BOOL=ON
#        -DENABLE_LIBRARY_CMAKE:BOOL=ON
#        -DENABLE_LIBRARY_DOCS:BOOL=ON
#        -DENABLE_LIBRARY_INCLUDE:BOOL=ON
#        -DENABLE_LIBRARY_LIB:BOOL=ON
#        -DENABLE_MSVC_MP:BOOL=OFF
#        -DENABLE_NET:BOOL=ON
#        -DENABLE_NETSSL_WIN:BOOL=OFF
#        -DENABLE_PAGECOMPILER:BOOL=ON
#        -DENABLE_PAGECOMPILER_FILE2PAGE:BOOL=ON
#        -DENABLE_POCODOC:BOOL=OFF
#        -DENABLE_PYTHON:BOOL=ON
#        -DENABLE_REDIS:BOOL=ON
#        -DENABLE_TESTS:BOOL=OFF
#        -DENABLE_TOOLKITS:BOOL=ON
#        -DENABLE_UTIL:BOOL=ON
#        -DENABLE_XML:BOOL=ON
#        -DFORCE_OPENSSL:BOOL=OFF
#        -DGIT_EXECUTABLE:FILEPATH=
#        -DJSON_HPP_INCLUDE_DIR:PATH=
#        -DLIB_EAY_DEBUG:FILEPATH=
#        -DLIB_EAY_LIBRARY_DEBUG:FILEPATH=
#        -DLIB_EAY_RELEASE:FILEPATH=
#        -DLIB_SUFFIX:STRING=
#        -DMSVC_REDIST_DIR:PATH=
#        -DMUPARSERX_INCLUDE_DIR:PATH=
#        -DMUPARSERX_LIBRARY:FILEPATH=
#        -DNUMA_LIBRARIES:FILEPATH=
#        -DOPENSSL_INCLUDE_DIR:PATH=
#        -DPKG_CONFIG_EXECUTABLE:FILEPATH=
#        -DPOCO_INCLUDE_DIR:PATH=
#        -DPOCO_LIBRARY_DBG:FILEPATH=
#        -DPOCO_LIBRARY_REL:FILEPATH=
#        -DPOCO_MIN_BUILD:BOOL=ON
#        -DPOCO_MT:BOOL=OFF
#        -DPOCO_STATIC:BOOL=OFF
#        -DPOCO_UNBUNDLED:BOOL=OFF
#        -DPORTAUDIO_INCLUDE_DIR:PATH=
#        -DPORTAUDIO_LIBRARY:FILEPATH=
#        -DPORTAUDIO_LIBRARY_DIR:PATH=
#        -DPOTHOS_PYTHON_DIR:STRING=
#        -DPOTHOS_ROOT:PATH=
#        -DPOTHOS_ROOT_ENV:STRING=
#        -DPYTHON_CONFIG_EXECUTABLE:FILEPATH=I:/DocSysMicro/MSVCShared/Anaconda3_64/python.exe-config
#        -DPYTHON_DEBUG_LIBRARY:FILEPATH=
#        -DPYTHON_EXECUTABLE:FILEPATH=
#        -DPYTHON_INCLUDE_DIR:PATH=
#        -DPYTHON_LIBRARY:FILEPATH=
#        -DPYTHON_LIBRARY_DEBUG:FILEPATH=
#        -DPoco_DIR:PATH=
#        -DQWT_INCLUDE_DIR:PATH=
#        -DQWT_LIBRARY:FILEPATH=
#        -DQt5Concurrent_DIR:PATH=
#        -DQt5OpenGL_DIR:PATH=
#        -DQt5PrintSupport_DIR:PATH=
#        -DQt5Svg_DIR:PATH=
#        -DQt5Widgets_DIR:PATH=
#        -DRT_LIBRARIES:FILEPATH=
#        -DSPUCE_INCLUDE_DIR:PATH=
#        -DSPUCE_LIBRARY:FILEPATH=
#        -DSSL_EAY_DEBUG:FILEPATH=
#        -DSSL_EAY_LIBRARY_DEBUG:FILEPATH=
#        -DSSL_EAY_RELEASE:FILEPATH=
#        -DSTATIC_POSTFIX:STRING=md
#        -DSoapySDR_DIR:PATH=
#        -DSpuce_DIR:PATH=
#        -Dmuparserx_DIR:PATH=
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE_1_0.txt ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
