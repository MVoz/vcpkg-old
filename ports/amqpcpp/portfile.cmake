include(vcpkg_common_functions)

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO CopernicaMarketingSoftware/AMQP-CPP
    REF v4.1.2
    SHA512 e2015d3958d434532591f9a304c625bdebb9bb075af1e2b684c9b8b061df8a2fd6a407200c802ad7b88ee954bcdad854f44a43512f76adf225addf145fc0fb44
    HEAD_REF master
    PATCHES
        find-openssl.patch
)

if(VCPKG_CMAKE_SYSTEM_NAME STREQUAL "Linux")
    set(LINUX_TCP ON)
else()
    set(LINUX_TCP OFF)
endif()

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DAMQP-CPP_BUILD_SHARED=OFF
        -DAMQP-CPP_LINUX_TCP=${LINUX_TCP}
)

vcpkg_install_cmake()
vcpkg_fixup_cmake_targets(CONFIG_PATH cmake)

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/amqpcpp RENAME copyright)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)
