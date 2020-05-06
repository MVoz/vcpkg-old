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
find_program(GIT git)
set(GIT_URL "https://github.com/wang-bin/QtAV.git")
# set(GIT_REF "f672e4a6964463e13403d55d58aa71876c798ed2")
set(GIT_REF "65483f5300b4f98ef0561a3e240ed82e252ec357")

if(NOT EXISTS "${DOWNLOADS}/QtAV.git")
    message(STATUS "Cloning")
    vcpkg_execute_required_process(
        COMMAND ${GIT} clone --bare ${GIT_URL} ${DOWNLOADS}/QtAV.git
        WORKING_DIRECTORY ${DOWNLOADS}
        LOGNAME clone
    )
endif()
message(STATUS "Cloning done")

if(NOT EXISTS "${CURRENT_BUILDTREES_DIR}/src/.git")
    message(STATUS "Adding worktree and patching")
    file(MAKE_DIRECTORY ${CURRENT_BUILDTREES_DIR})
    vcpkg_execute_required_process(
        COMMAND ${GIT} worktree add -f --detach ${CURRENT_BUILDTREES_DIR}/src ${GIT_REF}
        WORKING_DIRECTORY ${DOWNLOADS}/QtAV.git
        LOGNAME worktree
    )
    message(STATUS "Patching")
endif()
message(STATUS "Adding worktree done")
set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/)

message(STATUS "Updating Submodule")
vcpkg_execute_required_process(
    COMMAND ${GIT} submodule update --init --recursive
    WORKING_DIRECTORY ${SOURCE_PATH}
    LOGNAME update-submodule
)

vcpkg_apply_patches(
    SOURCE_PATH ${SOURCE_PATH}
    PATCHES
    ${CURRENT_PORT_DIR}/fixed_configure_check_xaudio_and_d3d11.patch
)

set(VCPKG_CXX_FLAGS "/I\"${VCPKG_ROOT_DIR}/installed/${TARGET_TRIPLET}/include\"")
set(VCPKG_C_FLAGS ${VCPKG_CXX_FLAGS})

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    # PREFER_NINJA
    OPTIONS -DBUILD_TESTS=OFF
            -DBUILD_EXAMPLES=OFF
            -DCMAKE_EXE_LINKER_FLAGS=/entry:mainCRTStartup
            -DCMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT=OFF
    OPTIONS_DEBUG -DCMAKE_DEBUG_POSTFIX=d
)

# set(_VCPKG_CMAKE_GENERATOR "Visual Studio")
vcpkg_install_cmake()

set(CONFS QmlAV QtAV QtAVWidgets)
set(OLDPORT ${PORT})
file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/lib/tmp)
file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/debug/lib/tmp)
foreach(CONF ${CONFS})
    file(RENAME ${CURRENT_PACKAGES_DIR}/lib/cmake/${CONF} ${CURRENT_PACKAGES_DIR}/lib/tmp/${CONF})
    file(RENAME ${CURRENT_PACKAGES_DIR}/debug/lib/cmake/${CONF} ${CURRENT_PACKAGES_DIR}/debug/lib/tmp/${CONF})
endforeach()
foreach(CONF ${CONFS})
    file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/lib/cmake)
    file(RENAME ${CURRENT_PACKAGES_DIR}/lib/tmp/${CONF} ${CURRENT_PACKAGES_DIR}/lib/cmake/${CONF})
    file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/debug/lib/cmake)
    file(RENAME ${CURRENT_PACKAGES_DIR}/debug/lib/tmp/${CONF} ${CURRENT_PACKAGES_DIR}/debug/lib/cmake/${CONF})
    set(PORT ${CONF})
    vcpkg_fixup_cmake_targets(CONFIG_PATH "lib/cmake/${CONF}")
endforeach()
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/lib/tmp)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/lib/tmp)
set(PORT ${OLDPORT})

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/tools/qtav)
file(RENAME ${CURRENT_PACKAGES_DIR}/bin/Player.exe ${CURRENT_PACKAGES_DIR}/tools/qtav/Player.exe)
file(RENAME ${CURRENT_PACKAGES_DIR}/bin/QMLPlayer.exe ${CURRENT_PACKAGES_DIR}/tools/qtav/QMLPlayer.exe)

file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/debug/tools/qtav)
file(RENAME ${CURRENT_PACKAGES_DIR}/debug/bin/Player.exe ${CURRENT_PACKAGES_DIR}/debug/tools/qtav/Player.exe)
file(RENAME ${CURRENT_PACKAGES_DIR}/debug/bin/QMLPlayer.exe ${CURRENT_PACKAGES_DIR}/debug/tools/qtav/QMLPlayer.exe)

# Handle copyright
file(INSTALL ${SOURCE_PATH}/lgpl-2.1.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/qtav RENAME copyright)