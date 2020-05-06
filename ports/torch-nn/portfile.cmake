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

set(GIT_NAME nn)
set(GIT_REF 872682558c48ee661ebff693aa5a41fcdefa7873)

set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/${GIT_NAME}-${GIT_REF})

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO torch/${GIT_NAME}
    REF ${GIT_REF}
    SHA512 bad74ddadfb98b8aea722214771a0278d1e1a6df80051b9dd4a8d15868492699bfa6cd74d85b23b6e7258a0a595ced61b6484a9627f343e799caa472669f922b
    HEAD_REF master
)

vcpkg_apply_patches(
    SOURCE_PATH ${SOURCE_PATH}
    PATCHES "${CMAKE_CURRENT_LIST_DIR}/fixed_compile_error.patch"
)

set(LINKER_FLAGS_REL "/machine:${VCPKG_TARGET_ARCHITECTURE} ${VCPKG_ROOT_DIR}/installed/${TARGET_TRIPLET}/lib/libluajit.lib")
set(LINKER_FLAGS_DBG "/machine:${VCPKG_TARGET_ARCHITECTURE} ${VCPKG_ROOT_DIR}/installed/${TARGET_TRIPLET}/debug/lib/libluajit.lib")
set(ENV{INCLUDE} "${VCPKG_ROOT_DIR}/installed/${TARGET_TRIPLET}/include;$ENV{INCLUDE}")
set(ENV{LUA_PATH} "${SOURCE_PATH}/?.lua;${VCPKG_ROOT_DIR}/installed/${TARGET_TRIPLET}/lua/?;${VCPKG_ROOT_DIR}/installed/${TARGET_TRIPLET}/lua/?.lua;${VCPKG_ROOT_DIR}/installed/${TARGET_TRIPLET}/lua/?/init.lua;")

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
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

set(_VCPKG_CMAKE_GENERATOR "Ninja")
vcpkg_install_cmake()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

file(COPY ${CURRENT_PACKAGES_DIR}/lib/libTHNN.dll DESTINATION ${CURRENT_PACKAGES_DIR}/bin)
file(REMOVE ${CURRENT_PACKAGES_DIR}/lib/libTHNN.dll)
file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/lib/THNN/libTHNN.lib DESTINATION ${CURRENT_PACKAGES_DIR}/lib)

file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/lib/THNN/libTHNN.lib DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)
file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/libTHNN.dll DESTINATION ${CURRENT_PACKAGES_DIR}/debug/bin)

vcpkg_copy_pdbs()

file(INSTALL ${SOURCE_PATH}/COPYRIGHT.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/torch-nn RENAME copyright)