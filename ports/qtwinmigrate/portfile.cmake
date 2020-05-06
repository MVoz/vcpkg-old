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
set(GIT_URL "https://github.com/qtproject/qt-solutions.git")
set(GIT_REF "ee17851b42f21bb92c4b7581e80c0319e5384e6b")

if(NOT EXISTS "${DOWNLOADS}/qt-solutions.git.git")
    message(STATUS "Cloning")
    vcpkg_execute_required_process(
        COMMAND ${GIT} clone --bare ${GIT_URL} ${DOWNLOADS}/qt-solutions.git.git
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
        WORKING_DIRECTORY ${DOWNLOADS}/qt-solutions.git.git
        LOGNAME worktree
    )
    message(STATUS "Patching")
endif()
message(STATUS "Adding worktree done")
set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/)

vcpkg_apply_patches(
    SOURCE_PATH ${SOURCE_PATH}
    PATCHES
    ${CURRENT_PORT_DIR}/fixed_include.patch
)

file(WRITE ${SOURCE_PATH}/CMakeLists.txt "cmake_minimum_required(VERSION 3.8)\n add_subdirectory(qtwinmigrate)")
file(COPY ${CURRENT_PORT_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH}/qtwinmigrate)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
)

vcpkg_install_cmake()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

file(INSTALL ${CURRENT_PORT_DIR}/Qt5WinMigrateConfig.cmake DESTINATION ${CURRENT_PACKAGES_DIR}/share/cmake/Qt5WinMigrate)
file(INSTALL ${CURRENT_PORT_DIR}/Qt5WinMigrateConfigVersion.cmake DESTINATION ${CURRENT_PACKAGES_DIR}/share/cmake/Qt5WinMigrate)

# Handle copyright
file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/share/qtwinmigrate)
file(WRITE ${CURRENT_PACKAGES_DIR}/share/qtwinmigrate/copyright "LGPL")