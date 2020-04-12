include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO BlueBrain/HighFive
    REF v2.0
    SHA512 d6bc38ae421adfa3cb9ee761ec92819bebe385cb100a8227bd9ff436cd7ae31725a96264a7963cfe5ce806cdd3b7978a8a630e9312c1567f6df6029062c6b8a0
    HEAD_REF master
)

if(${VCPKG_LIBRARY_LINKAGE} MATCHES "static")
    set(HDF5_USE_STATIC_LIBRARIES ON)
endif()

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DHIGHFIVE_UNIT_TESTS=OFF
        -DHIGHFIVE_EXAMPLES=OFF
        -DUSE_BOOST=OFF
        -DHIGH_FIVE_DOCUMENTATION=OFF
        -DHDF5_USE_STATIC_LIBRARIES=${HDF5_USE_STATIC_LIBRARIES}
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(CONFIG_PATH share/HighFive/CMake)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug)
if(NOT WIN32 AND NOT APPLE)
  file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/share/HighFive)
endif()

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/highfive RENAME copyright)
