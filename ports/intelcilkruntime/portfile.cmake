#   CURRENT_BUILDTREES_DIR    = ${VCPKG_ROOT_DIR}\buildtrees\${PORT}
#   CURRENT_PACKAGES_DIR      = ${VCPKG_ROOT_DIR}\packages\${PORT}_${TARGET_TRIPLET}
#   CURRENT_PORT_DIR          = ${VCPKG_ROOT_DIR}\ports\${PORT}
#   CMAKE_CURRENT_LIST_DIR    = ${VCPKG_ROOT_DIR}\ports\${PORT}
#   PORT                      = current port name (zlib, etc)
#   TARGET_TRIPLET            = current triplet (x86-windows, x64-windows-static, etc)
#   VCPKG_CRT_LINKAGE         = C runtime linkage type (static, dynamic)
#   VCPKG_LIBRARY_LINKAGE     = target library linkage type (static, dynamic)
#   VCPKG_ROOT_DIR            = <C:\path\to\current\vcpkg>
#   VCPKG_TARGET_ARCHITECTURE = target architecture (x64, x86, arm)
###

include(vcpkg_common_functions)

### https://mesonbuild.com/Configuring-a-build-directory.html
#vcpkg_configure_meson(
#	SOURCE_PATH ${SOURCE_PATH}
#    OPTIONS
#		--backend=ninja
#)

#vcpkg_install_meson()

###

#vcpkg_build_msbuild(
#    PROJECT_PATH ${SOURCE_PATH}/ports/MSVC++/2015/win32/libmpg123/libmpg123.vcxproj
#    RELEASE_CONFIGURATION Release_x86${MPG123_CONFIGURATION_SUFFIX}
#    DEBUG_CONFIGURATION Debug_x86${MPG123_CONFIGURATION_SUFFIX}
#)


#vcpkg_from_bitbucket(
#set(OPENEXR_VERSION 2.3.0)
#set(OPENEXR_HASH 268ae64b40d21d662f405fba97c307dad1456b7d996a447aadafd41b640ca736d4851d9544b4741a94e7b7c335fe6e9d3b16180e710671abfc0c8b2740b147b2)
#vcpkg_from_github(
#  OUT_SOURCE_PATH SOURCE_PATH
#  REPO openexr/openexr
#  REF v${OPENEXR_VERSION}
#  SHA512 ${OPENEXR_HASH}
#  HEAD_REF master
#  PATCHES
#    fix_clang_not_setting_modern_cplusplus.patch
#    fix_install_ilmimf.patch
#)
vcpkg_download_distfile(ARCHIVE
    URLS "https://bitbucket.org/intelcilkruntime/intel-cilk-runtime/get/39ad15ad8e56.zip"
    FILENAME "39ad15ad8e56.zip"
    SHA512 88a8f9149e9dae3d1127b7f8d88ef5142078f4c7f67cef785dea2453cd40a94010dd79f551daa4ec18fb82a5a6f551f6498f234716a91d30fe42b145537c377d
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
#    PATCHES
#        001_port_fixes.patch
#        002_more_port_fixes.patch
)

#vcpkg_find_acquire_program(YASM)
#get_filename_component(YASM_EXE_PATH ${YASM} DIRECTORY)
#set(ENV{PATH} "$ENV{PATH};${YASM_EXE_PATH}")

#file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH})

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
#    DISABLE_PARALLEL_CONFIGURE
#    OPTIONS 
#        -D =ON
#        -D =OFF
#    OPTIONS_RELEASE
#        -D =ON
#        -D =OFF
#    OPTIONS_DEBUG
#        -D =ON
#        -D =OFF
)

vcpkg_install_cmake()


#file(COPY ${SOURCE_PATH}/greatest.h DESTINATION ${CURRENT_PACKAGES_DIR}/include)

#vcpkg_fixup_cmake_targets(CONFIG_PATH "lib/cmake/${PORT}")
#vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/nlohmann_json TARGET_PATH share/nlohmann_json)
#file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/bin)
#file(RENAME ${CURRENT_PACKAGES_DIR}/lib/${LIB_NAME}.dll ${CURRENT_PACKAGES_DIR}/bin/${LIB_NAME}.dll
#file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/intelcilkruntime RENAME copyright)



#file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/lib ${CURRENT_PACKAGES_DIR}/debug)
#file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin ${CURRENT_PACKAGES_DIR}/debug/bin ${CURRENT_PACKAGES_DIR}/debug/share ${CURRENT_PACKAGES_DIR}/debug/include)

#file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/tools)
#file(RENAME ${CURRENT_PACKAGES_DIR}/debug/bin ${CURRENT_PACKAGES_DIR}/tools/${PORT})

#vcpkg_copy_tool_dependencies(${CURRENT_PACKAGES_DIR}/tools/openexr)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME intelcilkruntime)

configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
set(VCPKG_POLICY_EMPTY_PACKAGE enabled)
vcpkg_copy_pdbs()

###
