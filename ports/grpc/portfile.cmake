include(vcpkg_common_functions)

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

# This snippet is a workaround for users who are upgrading from an extremely old version of this
# port, which cloned directly into `src\`
if(EXISTS "${CURRENT_BUILDTREES_DIR}/src/.git")
    file(REMOVE_RECURSE ${CURRENT_BUILDTREES_DIR}/src)
endif()

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO grpc/grpc
    REF v1.19.1
    SHA512 4bb127d946fc16887fd4cf75215f0bc9f6d17dbd36fc4f1b191a64914f96c49dddb41f1b6c72fd24ea0a40f242b4398248f32fcb1fe9a764367be1c2edda9142
    HEAD_REF master
    PATCHES 
        00001-fix-uwp.patch
        00002-static-linking-in-linux.patch
)

if(VCPKG_CMAKE_SYSTEM_NAME STREQUAL "WindowsStore")
    set(gRPC_BUILD_CODEGEN OFF)
else()
    set(gRPC_BUILD_CODEGEN ON)
endif()

if(VCPKG_CRT_LINKAGE STREQUAL "static")
    set(gRPC_MSVC_STATIC_RUNTIME ON)
else()
    set(gRPC_MSVC_STATIC_RUNTIME OFF)
endif()

if(VCPKG_LIBRARY_LINKAGE STREQUAL "static")
    set(gRPC_STATIC_LINKING ON)
else()
    set(gRPC_STATIC_LINKING OFF)
endif()

if(VCPKG_CMAKE_SYSTEM_NAME STREQUAL "WindowsStore")
    set(cares_CARES_PROVIDER OFF)
else()
    set(cares_CARES_PROVIDER "package")
endif()

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DgRPC_INSTALL=ON
        -DgRPC_BUILD_TESTS=OFF
        -DgRPC_STATIC_LINKING=${gRPC_STATIC_LINKING}
        -DgRPC_MSVC_STATIC_RUNTIME=${gRPC_MSVC_STATIC_RUNTIME}
        -DgRPC_ZLIB_PROVIDER=package
        -DgRPC_SSL_PROVIDER=package
        -DgRPC_PROTOBUF_PROVIDER=package
        -DgRPC_PROTOBUF_PACKAGE_TYPE=CONFIG
        -DgRPC_CARES_PROVIDER=${cares_CARES_PROVIDER}
        -DgRPC_GFLAGS_PROVIDER=none
        -DgRPC_BENCHMARK_PROVIDER=none
        -DgRPC_INSTALL_CSHARP_EXT=OFF
        -DgRPC_INSTALL_BINDIR:STRING=bin
        -DgRPC_INSTALL_LIBDIR:STRING=lib
        -DgRPC_INSTALL_INCLUDEDIR:STRING=include
        -DgRPC_INSTALL_CMAKEDIR:STRING=share/grpc
        -DgRPC_BUILD_CODEGEN=${gRPC_BUILD_CODEGEN}
)

vcpkg_install_cmake(ADD_BIN_TO_PATH)

vcpkg_fixup_cmake_targets(CONFIG_PATH "share/grpc")

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/grpc RENAME copyright)

# Install tools
file(GLOB TOOLS "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/*.exe")
if(TOOLS)
    file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/tools/grpc)
    file(COPY ${TOOLS} DESTINATION ${CURRENT_PACKAGES_DIR}/tools/grpc)
    vcpkg_copy_tool_dependencies(${CURRENT_PACKAGES_DIR}/tools/grpc)
endif()

file(GLOB EXES "${CURRENT_PACKAGES_DIR}/bin/*.exe" "${CURRENT_PACKAGES_DIR}/debug/bin/*.exe")
if(EXES)
    file(REMOVE ${EXES})
endif()

# Ignore the C# extension DLL in bin/
SET(VCPKG_POLICY_EMPTY_PACKAGE enabled)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

vcpkg_copy_pdbs()
##