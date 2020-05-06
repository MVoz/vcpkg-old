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

set(GIT_NAME luajit-rocks)
set(GIT_REF 2c7496b905f6f972673effda4884766433b7583b)

set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/${GIT_NAME}-${GIT_REF})

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO torch/${GIT_NAME}
    REF ${GIT_REF}
    SHA512 96b85cfe05b9e0aa35872a6e8dea0ab6b4ebdbc7c7a48f6fcdc0fb638520d99b6ef58b2f6189faae5ee744a578ef4fc524e7600f3f291241d65bbaed11007333
    HEAD_REF master
)


vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    GENERATOR "NMake Makefiles"
    DISABLE_PARALLEL_CONFIGURE
    OPTIONS -DINSTALL_BIN_SUBDIR=bin
            -DINSTALL_LIB_SUBDIR=lib
            # -DINSTALL_LUAROCKS_ROCKS_SUBDIR=share/luajit-rocks/luarocks
            # -DINSTALL_LUAROCKS_SYSCONF_SUBDIR=share/luajit-rocks/luarocks
)

set(_VCPKG_CMAKE_GENERATOR "NMake")
vcpkg_install_cmake()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/bin/tools)
file(REMOVE ${CURRENT_PACKAGES_DIR}/debug/bin/luajit.exe)
file(REMOVE ${CURRENT_PACKAGES_DIR}/debug/bin/luarocks.bat)
file(REMOVE ${CURRENT_PACKAGES_DIR}/debug/bin/luarocks-admin.bat)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/lua)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)

file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/tools/luajit-rocks)
file(COPY ${CURRENT_PACKAGES_DIR}/bin/tools DESTINATION ${CURRENT_PACKAGES_DIR}/tools/luajit-rocks)
file(COPY ${CURRENT_PACKAGES_DIR}/bin/libluajit.dll DESTINATION ${CURRENT_PACKAGES_DIR}/tools/luajit-rocks)
file(COPY ${CURRENT_PACKAGES_DIR}/bin/luajit.exe DESTINATION ${CURRENT_PACKAGES_DIR}/tools/luajit-rocks)
file(COPY ${CURRENT_PACKAGES_DIR}/bin/luarocks.bat DESTINATION ${CURRENT_PACKAGES_DIR}/tools/luajit-rocks)
file(COPY ${CURRENT_PACKAGES_DIR}/bin/luarocks-admin.bat DESTINATION ${CURRENT_PACKAGES_DIR}/tools/luajit-rocks)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin/tools)
file(REMOVE ${CURRENT_PACKAGES_DIR}/bin/luajit.exe)
file(REMOVE ${CURRENT_PACKAGES_DIR}/bin/luarocks.bat)
file(REMOVE ${CURRENT_PACKAGES_DIR}/bin/luarocks-admin.bat)

set(INSTALL_DIR ${VCPKG_ROOT_DIR}/installed/${TARGET_TRIPLET})

file(READ ${CURRENT_PACKAGES_DIR}/tools/luajit-rocks/luarocks.bat CONTENT)
string(REPLACE "${CURRENT_PACKAGES_DIR}/bin" "${INSTALL_DIR}/tools/luajit-rocks" CONTENT "${CONTENT}")
string(REPLACE "${CURRENT_PACKAGES_DIR}" "${INSTALL_DIR}" CONTENT "${CONTENT}")
file(WRITE ${CURRENT_PACKAGES_DIR}/tools/luajit-rocks/luarocks.bat "${CONTENT}")

file(READ ${CURRENT_PACKAGES_DIR}/tools/luajit-rocks/luarocks-admin.bat CONTENT)
string(REPLACE "${CURRENT_PACKAGES_DIR}/bin" "${INSTALL_DIR}/tools/luajit-rocks" CONTENT "${CONTENT}")
string(REPLACE "${CURRENT_PACKAGES_DIR}" "${INSTALL_DIR}" CONTENT "${CONTENT}")
file(WRITE ${CURRENT_PACKAGES_DIR}/tools/luajit-rocks/luarocks-admin.bat "${CONTENT}")

file(READ ${CURRENT_PACKAGES_DIR}/luarocks/config.lua CONTENT)
string(REPLACE "${CURRENT_PACKAGES_DIR}/bin" "${INSTALL_DIR}/tools/luajit-rocks" CONTENT "${CONTENT}")
string(REPLACE "${CURRENT_PACKAGES_DIR}" "${INSTALL_DIR}" CONTENT "${CONTENT}")
file(WRITE ${CURRENT_PACKAGES_DIR}/luarocks/config.lua "${CONTENT}")

file(READ ${CURRENT_PACKAGES_DIR}/lua/luarocks/site_config.lua CONTENT)
string(REPLACE "${CURRENT_PACKAGES_DIR}/bin" "${INSTALL_DIR}/tools/luajit-rocks" CONTENT "${CONTENT}")
string(REPLACE "LUAROCKS_PREFIX=[[${CURRENT_PACKAGES_DIR}" "LUAROCKS_PREFIX=[[${INSTALL_DIR}/tools/luajit-rocks" CONTENT "${CONTENT}")
string(REPLACE "${CURRENT_PACKAGES_DIR}" "${INSTALL_DIR}" CONTENT "${CONTENT}")
file(WRITE ${CURRENT_PACKAGES_DIR}/lua/luarocks/site_config.lua "${CONTENT}")

file(INSTALL ${SOURCE_PATH}/luarocks/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/luajit-rocks RENAME copyright)