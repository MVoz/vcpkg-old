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
set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src)
vcpkg_download_distfile(ARCHIVE
    URLS "http://files.mcneel.com/dujour/exe/201801/opennurbs_6.1.18014.22401.zip"
    FILENAME "opennurbs_6.1.18014.22401.zip"
    SHA512 28292f2dcf00cae50b5c9808bae302c89eb7a8a3942966a7630abebdfc79c613fcf65b5782e6cda80d3f5e7ce633227e88d796c75b76bfd5e345b6c43ed0cd03
)
vcpkg_extract_source_archive(${ARCHIVE})

vcpkg_apply_patches(
    SOURCE_PATH ${SOURCE_PATH}
    PATCHES
    ${CMAKE_CURRENT_LIST_DIR}/fixed_freetype263_build.patch
)

vcpkg_build_msbuild(
    PROJECT_PATH ${SOURCE_PATH}/opennurbs_public.sln
    TARGET opennurbs_public
)

if(VCPKG_TARGET_ARCHITECTURE STREQUAL x64)
    set(TARGET_ARCH x64)
else()
    set(TARGET_ARCH Win32)
endif()

file(GLOB INSTALL_FILES ${SOURCE_PATH}/bin/${TARGET_ARCH}/Debug/*.dll)
file(INSTALL ${INSTALL_FILES} DESTINATION ${CURRENT_PACKAGES_DIR}/debug/bin)
file(INSTALL ${SOURCE_PATH}/bin/${TARGET_ARCH}/Debug/opennurbs_public.lib DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)

file(GLOB INSTALL_FILES ${SOURCE_PATH}/opennurbs*.h)
file(INSTALL ${INSTALL_FILES} DESTINATION ${CURRENT_PACKAGES_DIR}/include)
file(GLOB INSTALL_FILES ${SOURCE_PATH}/bin/${TARGET_ARCH}/Release/*.dll)
file(INSTALL ${INSTALL_FILES} DESTINATION ${CURRENT_PACKAGES_DIR}/bin)
file(INSTALL ${SOURCE_PATH}/bin/${TARGET_ARCH}/Release/opennurbs_public.lib DESTINATION ${CURRENT_PACKAGES_DIR}/lib)

vcpkg_copy_pdbs()

# Handle copyright
file(INSTALL ${SOURCE_PATH}/readme.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/opennurbs RENAME copyright)
