include(vcpkg_common_functions)

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

find_program(GIT NAMES git git.cmd)
set(GIT_URL "https://github.com/eProsima/Fast-RTPS")
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

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates

    OPTIONS 
#      -DAsio_DIR:PATH=Asio_DIR-NOTFOUND
      -DBUILD_DOCUMENTATION=OFF
      -DBUILD_JAVA=OFF
      -DBUILD_TESTING=OFF
      -DCOMPILE_EXAMPLES=OFF
      -DEPROSIMA_BUILD=OFF
      -DEPROSIMA_BUILD_TESTS=OFF
      -DEPROSIMA_GMOCK=OFF
      -DEPROSIMA_GTEST=OFF
      -DEPROSIMA_INSTALLER=OFF
      -DGTEST_INDIVIDUAL=OFF
      -DINSTALL_EXAMPLES=OFF
      -DINTERNAL_DEBUG=OFF
      -DLICENSE_INSTALL_DIR:PATH=share/fastrtps
      -DNO_TLS=OFF
      -DPERFORMANCE_TESTS=OFF
      -DPROFILING_TESTS=OFF
      -DSECURITY=OFF
      -DTEST_JAVA=OFF
	  
      -DTHIRDPARTY=OFF
      -DTHIRDPARTY_Asio=OFF
      -DTHIRDPARTY_TinyXML2=OFF
      -DTHIRDPARTY_UPDATE=OFF
      -DTHIRDPARTY_fastcdr=OFF
      -DTINYXML2_FROM_SOURCE=OFF
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
