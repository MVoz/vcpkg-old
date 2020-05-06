include(vcpkg_common_functions)

find_program(GIT NAMES git git.cmd)
set(GIT_URL "https://github.com/mfontanini/libtins")
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
    message(STATUS "clean")
    vcpkg_execute_required_process(
      COMMAND ${GIT} clean -xfd
      WORKING_DIRECTORY ${SOURCE_PATH}
      LOGNAME clean
    )
endif()

string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "dynamic" LIBTINS_BUILD_SHARED)

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
      -DLIBTINS_BUILD_EXAMPLES=OFF
      -DLIBTINS_BUILD_SHARED=${LIBTINS_BUILD_SHARED}
      -DLIBTINS_BUILD_TESTS=OFF
      -DLIBTINS_ENABLE_ACK_TRACKER=ON
      -DLIBTINS_ENABLE_CXX11=ON
      -DLIBTINS_ENABLE_DOT11=ON
      -DLIBTINS_ENABLE_PCAP=ON
      -DLIBTINS_ENABLE_TCPIP=ON
      -DLIBTINS_ENABLE_TCP_STREAM_CUSTOM_DATA=ON
      -DLIBTINS_ENABLE_WPA2=ON
      -DLIBTINS_ENABLE_WPA2_CALLBACKS=ON
      -DLIBTINS_USE_PCAP_SENDPACKET=ON
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
