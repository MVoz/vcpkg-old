# Common Ambient Variables:
#   CURRENT_BUILDTREES_DIR    = ${VCPKG_ROOT_DIR}\buildtrees\${PORT}
#   CURRENT_PACKAGES_DIR      = ${VCPKG_ROOT_DIR}\packages\${PORT}_${TARGET_TRIPLET}
#   CURRENT_PORT DIR          = ${VCPKG_ROOT_DIR}\ports\${PORT}
#   PORT                      = current port name (zlib, etc)
#   TARGET_TRIPLET            = current triplet (x86-windows, x64-windows-static, etc)
#   VCPKG_CRT_LINKAGE         = C runtime linkage type (static, dynamic)
#   VCPKG_LIBRARY_LINKAGE     = target library linkage type (static, dynamic)
#   VCPKG_ROOT_DIR            = <C:\path\to\current\vcpkg>
#   VCPKG_TARGET_ARCHITECTURE = target architecture (x64, x86, arm)
#

include(vcpkg_common_functions)

if(VCPKG_CMAKE_SYSTEM_NAME STREQUAL "WindowsStore")
    message(FATAL_ERROR "LuaJIT currently only supports being built for desktop")
endif()

set(GIT_NAME torch7)
set(GIT_REF 89ede3ba90c906a8ec6b9a0f4bef188ba5bb2fd8)

set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/${GIT_NAME}-${GIT_REF})

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO torch/${GIT_NAME}
    REF ${GIT_REF}
    SHA512 0b28762768129f5e59e24d505e271418bb4513db0e99acb293f01095949700711116463b299fe42d65ca07c1f0a9f6d0d1d72e21275a2825a4a9fb0197525e72
    HEAD_REF master
)

vcpkg_apply_patches(
    SOURCE_PATH ${SOURCE_PATH}
    PATCHES "${CMAKE_CURRENT_LIST_DIR}/debug.patch"
)

set(LINKER_FLAGS_REL "/machine:${VCPKG_TARGET_ARCHITECTURE} ${VCPKG_ROOT_DIR}/installed/${TARGET_TRIPLET}/lib/libluajit.lib")
set(LINKER_FLAGS_DBG "/machine:${VCPKG_TARGET_ARCHITECTURE} ${VCPKG_ROOT_DIR}/installed/${TARGET_TRIPLET}/debug/lib/libluajit.lib")
set(ENV{INCLUDE} "${VCPKG_ROOT_DIR}/installed/${TARGET_TRIPLET}/include;$ENV{INCLUDE}")
set(ENV{LUA_PATH} "${SOURCE_PATH}/?.lua;${VCPKG_ROOT_DIR}/installed/${TARGET_TRIPLET}/lua/?;${VCPKG_ROOT_DIR}/installed/${TARGET_TRIPLET}/lua/?.lua;${VCPKG_ROOT_DIR}/installed/${TARGET_TRIPLET}/lua/?/init.lua;")

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    GENERATOR "NMake Makefiles"
    DISABLE_PARALLEL_CONFIGURE
    OPTIONS -DLUA=${VCPKG_ROOT_DIR}/installed/${TARGET_TRIPLET}/tools/luajit-rocks/luajit.exe
            -DLUADIR=${CURRENT_PACKAGES_DIR}/lua
            -DLUA_INCDIR=${CURRENT_PACKAGES_DIR}/include
    OPTIONS_RELEASE -DCMAKE_MODULE_LINKER_FLAGS=${LINKER_FLAGS_REL}
                    -DCMAKE_SHARED_LINKER_FLAGS=${LINKER_FLAGS_REL}
                    -DCMAKE_STATIC_LINKER_FLAGS=${LINKER_FLAGS_REL}
                    -DLUA_BINDIR=${CURRENT_PACKAGES_DIR}/bin
                    -DLUA_LIBDIR=${CURRENT_PACKAGES_DIR}/lib
                    -DLIBDIR=${CURRENT_PACKAGES_DIR}/lib
    OPTIONS_DEBUG -DCMAKE_MODULE_LINKER_FLAGS=${LINKER_FLAGS_DBG}
                  -DCMAKE_SHARED_LINKER_FLAGS=${LINKER_FLAGS_DBG}
                  -DCMAKE_STATIC_LINKER_FLAGS=${LINKER_FLAGS_DBG}
                  -DLUA_BINDIR=${CURRENT_PACKAGES_DIR}/debug/bin
                  -DLUA_LIBDIR=${CURRENT_PACKAGES_DIR}/debug/lib
                  -DLIBDIR=${CURRENT_PACKAGES_DIR}/debug/lib
)

set(_VCPKG_CMAKE_GENERATOR "NMake")
vcpkg_install_cmake()

file(COPY ${CURRENT_PACKAGES_DIR}/lib/libtorch.dll DESTINATION ${CURRENT_PACKAGES_DIR}/bin)
file(COPY ${CURRENT_PACKAGES_DIR}/debug/lib/libtorch.dll DESTINATION ${CURRENT_PACKAGES_DIR}/debug/bin)
file(COPY ${CURRENT_PACKAGES_DIR}/debug/share/cmake/torch/TorchExports-debug.cmake DESTINATION ${CURRENT_PACKAGES_DIR}/share/cmake/torch)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)
file(REMOVE ${CURRENT_PACKAGES_DIR}/lib/libtorch.dll)
file(REMOVE ${CURRENT_PACKAGES_DIR}/debug/lib/libtorch.dll)

set(INSTALL_DIR ${VCPKG_ROOT_DIR}/installed/${TARGET_TRIPLET})

file(READ ${CURRENT_PACKAGES_DIR}/lua/torch/paths.lua CONTENT)
string(REPLACE "${CURRENT_PACKAGES_DIR}" "${INSTALL_DIR}" CONTENT "${CONTENT}")
file(WRITE ${CURRENT_PACKAGES_DIR}/lua/torch/paths.lua "${CONTENT}")

file(READ ${CURRENT_PACKAGES_DIR}/share/cmake/torch/luaTConfig.cmake CONTENT)
string(REPLACE "${CURRENT_PACKAGES_DIR}" "${INSTALL_DIR}" CONTENT "${CONTENT}")
file(WRITE ${CURRENT_PACKAGES_DIR}/share/cmake/torch/luaTConfig.cmake "${CONTENT}")

file(READ ${CURRENT_PACKAGES_DIR}/share/cmake/torch/THConfig.cmake CONTENT)
string(REPLACE "${CURRENT_PACKAGES_DIR}" "${INSTALL_DIR}" CONTENT "${CONTENT}")
file(WRITE ${CURRENT_PACKAGES_DIR}/share/cmake/torch/THConfig.cmake "${CONTENT}")

file(READ ${CURRENT_PACKAGES_DIR}/share/cmake/torch/TorchConfig.cmake CONTENT)
string(REPLACE "${CURRENT_PACKAGES_DIR}" "${INSTALL_DIR}" CONTENT "${CONTENT}")
string(REPLACE "SET(CMAKE_INSTALL_PREFIX" "# SET(CMAKE_INSTALL_PREFIX" CONTENT "${CONTENT}")
file(WRITE ${CURRENT_PACKAGES_DIR}/share/cmake/torch/TorchConfig.cmake "${CONTENT}")

vcpkg_copy_pdbs()

file(INSTALL ${SOURCE_PATH}/COPYRIGHT.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/torch7 RENAME copyright)