include(vcpkg_common_functions)

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

if(NOT VCPKG_CRT_LINKAGE STREQUAL "dynamic")
    message(FATAL_ERROR "DirectXMesh only supports dynamic CRT linkage")
endif()

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Microsoft/DirectXMesh
    REF jun2019
    SHA512 6d42cd4d3e34e7f3bd5cee1a9ad90c9f89eafa55951a0a8d776034a05caa06b0fd17629547d14c8f2b4d0c5fafdbd24ae05c2a6582b5d069093d6b4dadac09a0
    HEAD_REF master
)

IF (TRIPLET_SYSTEM_ARCH MATCHES "x86")
    SET(BUILD_ARCH "Win32")
ELSE()
    SET(BUILD_ARCH ${TRIPLET_SYSTEM_ARCH})
ENDIF()

if (VCPKG_PLATFORM_TOOLSET STREQUAL "v140")
    set(VS_VERSION "2015")
elseif (VCPKG_PLATFORM_TOOLSET STREQUAL "v141")
    set(VS_VERSION "2017")
elseif (VCPKG_PLATFORM_TOOLSET STREQUAL "v142")
    set(VS_VERSION "2019")
else()
    message(FATAL_ERROR "Unsupported platform toolset.")
endif()

if(VCPKG_CMAKE_SYSTEM_NAME STREQUAL "WindowsStore")
    set(SLN_NAME "Windows10_${VS_VERSION}")
else()
    set(SLN_NAME "Desktop_${VS_VERSION}")
endif()

vcpkg_build_msbuild(
    PROJECT_PATH ${SOURCE_PATH}/DirectXMesh_${SLN_NAME}.sln
    PLATFORM ${BUILD_ARCH}
)

file(INSTALL
    ${SOURCE_PATH}/DirectXMesh/DirectXMesh.h
    ${SOURCE_PATH}/DirectXMesh/DirectXMesh.inl
    DESTINATION ${CURRENT_PACKAGES_DIR}/include
)

file(INSTALL
    ${SOURCE_PATH}/DirectXMesh/Bin/${SLN_NAME}/${BUILD_ARCH}/Debug/DirectXMesh.lib
    DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)
file(INSTALL
    ${SOURCE_PATH}/DirectXMesh/Bin/${SLN_NAME}/${BUILD_ARCH}/Release/DirectXMesh.lib
    DESTINATION ${CURRENT_PACKAGES_DIR}/lib)

if(NOT VCPKG_CMAKE_SYSTEM_NAME STREQUAL "WindowsStore")
    set(TOOL_PATH ${CURRENT_PACKAGES_DIR}/tools/directxmesh)
    file(MAKE_DIRECTORY ${TOOL_PATH})
    file(INSTALL
        ${SOURCE_PATH}/Meshconvert/Bin/${SLN_NAME}/${BUILD_ARCH}/Release/Meshconvert.exe
        DESTINATION ${TOOL_PATH})
endif()

# Handle copyright
file(COPY ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/directxmesh)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/directxmesh/LICENSE ${CURRENT_PACKAGES_DIR}/share/directxmesh/copyright)
