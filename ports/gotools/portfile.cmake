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
set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/GoTools.git)
find_program(GIT git)
set(GIT_URL "https://github.com/SINTEF-Geometry/GoTools.git")
set(GIT_REF "d66af5cc1f34e2a528e35469b5af91c00dd3b1c8")

if(NOT EXISTS "${DOWNLOADS}/GoTools.git")
    message(STATUS "Cloning")
    vcpkg_execute_required_process(
        COMMAND ${GIT} clone --bare ${GIT_URL} ${DOWNLOADS}/GoTools.git
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
        WORKING_DIRECTORY ${DOWNLOADS}/GoTools.git
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
    ${CURRENT_PORT_DIR}/fixed_gotools_build.patch
)

vcpkg_apply_patches(
    SOURCE_PATH ${SOURCE_PATH}/sisl
    PATCHES
    ${CURRENT_PORT_DIR}/fixed_sisl_build.patch
)

vcpkg_apply_patches(
    SOURCE_PATH ${SOURCE_PATH}/ttl
    PATCHES
    ${CURRENT_PORT_DIR}/fixed_ttl_build.patch
)

if(VCPKG_LIBRARY_LINKAGE STREQUAL dynamic)
    set(OPTIONS -DBUILD_AS_SHARED_LIBRARY=ON)
endif()

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    OPTIONS -DGoTools_COMPILE_TESTS=OFF
            -DGoTools_USE_Qt4=OFF
            -DGoTools_COMPILE_APPS=OFF
            -DGoTools_COMPILE_MODULE_viewlib=OFF
            ${OPTIONS}
    OPTIONS_RELEASE "-DGoTools_INSTALL_PREFIX=${CURRENT_PACKAGES_DIR}"
                    "-Dnewmat_INSTALL_PREFIX=${CURRENT_PACKAGES_DIR}"
                    "-Dsisl_INSTALL_PREFIX=${CURRENT_PACKAGES_DIR}"
                    "-Dttl_INSTALL_PREFIX=${CURRENT_PACKAGES_DIR}"
    OPTIONS_DEBUG "-DGoTools_INSTALL_PREFIX=${CURRENT_PACKAGES_DIR}/debug"
                  "-Dnewmat_INSTALL_PREFIX=${CURRENT_PACKAGES_DIR}/debug"
                  "-Dsisl_INSTALL_PREFIX=${CURRENT_PACKAGES_DIR}/debug"
                  "-Dttl_INSTALL_PREFIX=${CURRENT_PACKAGES_DIR}/debug"
)

vcpkg_install_cmake()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

# Handle copyright
file(INSTALL ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/gotools RENAME copyright)
