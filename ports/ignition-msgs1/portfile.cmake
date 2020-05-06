# Common Ambient Variables:
#   CURRENT_BUILDTREES_DIR    = ${VCPKG_ROOT_DIR}\buildtrees\${PORT}
#   CURRENT_PACKAGES_DIR      = ${VCPKG_ROOT_DIR}\packages\${PORT}_${TARGET_TRIPLET}
#   CURRENT_PORT_DIR          = ${VCPKG_ROOT_DIR}\ports\${PORT}
#   PORT                      = current port name (zlib, etc)
#   TARGET_TRIPLET            = current triplet (x86-windows, x64-windows-static, etc)
#   VCPKG_CRT_LINKAGE         = C runtime linkage type (static, dynamic)
#   VCPKG_LIBRARY_LINKAGE     = target library linkage type (static, dynamic)
#   VCPKG_ROOT_DIR            = <C:\path\to\current\vcpkg>
#   VCPKG_TARGET_ARCHITECTURE = target architecture (x64, x86, arm)
#

include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://osrf-distributions.s3.amazonaws.com/ign-msgs/releases/ignition-msgs-1.0.0.tar.bz2"
    FILENAME "ignition-msgs-1.0.0.tar.bz2"
    SHA512 3ec16d68c35b1c7d77373eb3ed72304f5a990f57fc15a91f49af49bf0c6b43e6f31e888e4b0a8308cc63840aa995dd423d5b23d28a98f132b4be13c46f5d7d6e
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE} 
)

if(CMAKE_HOST_WIN32 AND NOT VCPKG_TARGET_ARCHITECTURE MATCHES "x64" AND NOT VCPKG_TARGET_ARCHITECTURE MATCHES "x86")
  message(FATAL_ERROR "Cross-targetting ignition-msgs1 is currently not supported..")
endif()

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    # PREFER_NINJA ignition-msgs1 does not support ninja
    OPTIONS -DBUILD_TESTING=OFF
)

# For generating the messages, the custom generated protobuf generated needs to have 
# protobuf libraries in the path 
#set(_path $ENV{PATH})
#set(ENV{PATH})
#vcpkg_add_to_path(${CURRENT_INSTALLED_DIR}/bin)
#vcpkg_add_to_path(${CURRENT_INSTALLED_DIR}/debug/bin)

vcpkg_install_cmake()
# Restore old path 
#set(ENV{PATH} ${_path})


# Fix cmake targets location
vcpkg_fixup_cmake_targets(CONFIG_PATH "lib/cmake/ignition-msgs1")

# Remove debug files
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include 
                    ${CURRENT_PACKAGES_DIR}/debug/lib/cmake
                    ${CURRENT_PACKAGES_DIR}/debug/share)

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/ignition-msgs1 RENAME copyright)

# Post-build test for cmake libraries
vcpkg_test_cmake(PACKAGE_NAME ignition-msgs1)
