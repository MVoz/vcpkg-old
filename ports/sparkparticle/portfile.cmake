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
set(GIT_URL "https://github.com/Synxis/SPARK.git")
set(GIT_REF "579423b32844a85ef14b589b2886422fea4d5b3c")

if(NOT EXISTS "${DOWNLOADS}/SPARK.git")
    message(STATUS "Cloning")
    vcpkg_execute_required_process(
        COMMAND ${GIT} clone --bare ${GIT_URL} ${DOWNLOADS}/SPARK.git
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
        WORKING_DIRECTORY ${DOWNLOADS}/SPARK.git
        LOGNAME worktree
    )
    message(STATUS "Patching")
endif()
message(STATUS "Adding worktree done")

set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/)

file(COPY ${CURRENT_PORT_DIR}/vc2015 DESTINATION ${SOURCE_PATH}/projects)

if (VCPKG_TARGET_ARCHITECTURE STREQUAL "x86")
    set(PLATFORM "Win32")
    set(OUT_PLATFORM_DIR "")
else()
    set(PLATFORM "${VCPKG_TARGET_ARCHITECTURE}")
    set(OUT_PLATFORM_DIR "${VCPKG_TARGET_ARCHITECTURE}")
endif()

message(STATUS "PLATFORM = ${PLATFORM}")
vcpkg_build_msbuild(PROJECT_PATH "${SOURCE_PATH}/projects/vc2015/SPARK_engine.sln"
                    TARGET "SPARK Engine GL DLL"
                    PLATFORM "${PLATFORM}")

file(GLOB FILES "${SOURCE_PATH}/projects/vc2015/${OUT_PLATFORM_DIR}/Debug/*.lib")
file(INSTALL ${FILES} DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)
file(GLOB FILES "${SOURCE_PATH}/projects/vc2015/${OUT_PLATFORM_DIR}/Debug/*.dll"
                "${SOURCE_PATH}/projects/vc2015/${OUT_PLATFORM_DIR}/Debug/*.pdb")
file(INSTALL ${FILES} DESTINATION ${CURRENT_PACKAGES_DIR}/debug/bin)

file(GLOB FILES "${SOURCE_PATH}/projects/vc2015/${OUT_PLATFORM_DIR}/Release/*.lib")
file(INSTALL ${FILES} DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
file(GLOB FILES "${SOURCE_PATH}/projects/vc2015/${OUT_PLATFORM_DIR}/Release/*.dll"
                "${SOURCE_PATH}/projects/vc2015/${OUT_PLATFORM_DIR}/Release/*.pdb")
file(INSTALL ${FILES} DESTINATION ${CURRENT_PACKAGES_DIR}/bin)

file(GLOB FILES LIST_DIRECTORIES true ${SOURCE_PATH}/include/*)
file(INSTALL ${FILES} DESTINATION ${CURRENT_PACKAGES_DIR}/include)

file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/share/sparkparticle)
file(WRITE ${CURRENT_PACKAGES_DIR}/share/sparkparticle/copyright "SPARK Particle Engine")