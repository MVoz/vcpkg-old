# v8 has a quite convoluted build system. 
# This is the general sequence of events:
# 1. Fetch and unzip Google's "depot_tools"
# 2. Update depot_tools
# 3. Pull v8 code via depot_tools
# 4. Generate build framework via depot_tools
# 5. Append commands to build config file
# 6. Call ninja to perform the build
# 7. Install header and library files

# Make sure to initialize the Visual Studio command line envronment before running
# `vcpkg install v8:x64-windows`
# i.e. run `"C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvars64.bat"`
# or the equivalent on your system



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
    URLS "https://storage.googleapis.com/chrome-infra/depot_tools.zip"
    FILENAME "depot_tools.zip"
    SHA512 442d971eac852b2691916b2b8d708aceb6c8197a723f366263c5ab5f6a47c379491c9b8652fafb77be8a4008362836a7d51487ee64d30f67329ee6947de3bba6
)
vcpkg_extract_source_archive(${ARCHIVE})

set(ENV{PATH} "${SOURCE_PATH};$ENV{PATH}")
set(ENV{DEPOT_TOOLS_WIN_TOOLCHAIN} 0)
set(ENV{DEPOT_TOOLS_UPDATE} 0)
set(ENV{GYP_MSVS_VERSION} 2017)

# message(STATUS "Updating depot_tools...")

vcpkg_execute_required_process(
    COMMAND ${SOURCE_PATH}/gclient.bat config https://chromium.googlesource.com/v8/v8.git
    WORKING_DIRECTORY ${SOURCE_PATH}
    LOGNAME ${TARGET_TRIPLET}
)

vcpkg_execute_required_process(
    COMMAND ${SOURCE_PATH}/gclient.bat sync
    WORKING_DIRECTORY ${SOURCE_PATH}
    LOGNAME ${TARGET_TRIPLET}
)

find_program(GIT NAMES git.cmd)
	if(Git_FOUND)
	message("Git found: ${GIT_EXECUTABLE}")
endif()

if(VCPKG_TARGET_ARCHITECTURE STREQUAL "x86")
    set(BUILDTYPE ia32.optdebug)
elseif(VCPKG_TARGET_ARCHITECTURE STREQUAL "x64")
    set(BUILDTYPE x64.optdebug)
else()
    message(FATAL_ERROR "Unsupported target architecture: ${VCPKG_TARGET_ARCHITECTURE}")
endif()

message(STATUS "Generating build directory ${BUILDTYPE}")

vcpkg_execute_required_process(
    COMMAND ${SOURCE_PATH}/python.bat ${SOURCE_PATH}/v8/v8/tools/dev/v8gen.py ${BUILDTYPE}
    WORKING_DIRECTORY ${SOURCE_PATH}/v8/v8
    LOGNAME ${TARGET_TRIPLET}-dbg
)

message(STATUS "Setting configuration for shared library build")

# Make DLLS
file(APPEND ${SOURCE_PATH}/v8/v8/out.gn/${BUILDTYPE}/args.gn "is_component_build = true\n" )
# You might need to change this if you have a different VS version installed.
file(APPEND ${SOURCE_PATH}/v8/v8/out.gn/${BUILDTYPE}/args.gn "visual_studio_version = \"2017\"" )
# Embed snapshot data into the binaries.
file(APPEND ${SOURCE_PATH}/v8/v8/out.gn/${BUILDTYPE}/args.gn "v8_use_external_startup_data = false" ) 

message(STATUS "Building ${BUILDTYPE} through ninja")

vcpkg_execute_required_process(
#    COMMAND ninja -C out.gn/${BUILDTYPE}/ v8.dll v8_shell -v
    COMMAND ninja -C out.gn/${BUILDTYPE}/ v8_libbase.lib v8_libplatform.lib v8.dll v8_shell -v
    WORKING_DIRECTORY ${SOURCE_PATH}/v8/v8
    LOGNAME ${TARGET_TRIPLET}-dbg
)

if(VCPKG_TARGET_ARCHITECTURE STREQUAL "x86")
    set(BUILDTYPE ia32.release)
elseif(VCPKG_TARGET_ARCHITECTURE STREQUAL "x64")
    set(BUILDTYPE x64.release)
else()
    message(FATAL_ERROR "Unsupported target architecture: ${VCPKG_TARGET_ARCHITECTURE}")
endif()

message(STATUS "Generating build directory ${BUILDTYPE}")

vcpkg_execute_required_process(
    COMMAND ${SOURCE_PATH}/python.bat ${SOURCE_PATH}/v8/v8/tools/dev/v8gen.py ${BUILDTYPE}
    WORKING_DIRECTORY ${SOURCE_PATH}/v8/v8
    LOGNAME ${TARGET_TRIPLET}-rel
)

message(STATUS "Setting configuration for shared library build")

file(APPEND ${SOURCE_PATH}/v8/v8/out.gn/${BUILDTYPE}/args.gn "is_component_build = true\n" )
file(APPEND ${SOURCE_PATH}/v8/v8/out.gn/${BUILDTYPE}/args.gn "visual_studio_version = \"2017\"" )
file(APPEND ${SOURCE_PATH}/v8/v8/out.gn/${BUILDTYPE}/args.gn "v8_use_external_startup_data = false" ) 
message(STATUS "Building ${BUILDTYPE} through ninja")

vcpkg_execute_required_process(
    COMMAND ninja -C out.gn/${BUILDTYPE}/ v8_libbase.lib v8_libplatform.lib v8.dll v8_shell -v
    WORKING_DIRECTORY ${SOURCE_PATH}/v8/v8
    LOGNAME ${TARGET_TRIPLET}-rel
)

set(LIBRARY_FILES v8.dll v8_libbase.dll v8_libplatform.dll icui18n.dll icuuc.dll)


# Handle copyright
file(INSTALL ${SOURCE_PATH}/v8/v8/LICENSE.v8 DESTINATION ${CURRENT_PACKAGES_DIR}/share/v8 RENAME copyright)

file(INSTALL ${SOURCE_PATH}/v8/v8/include DESTINATION ${CURRENT_PACKAGES_DIR} FILES_MATCHING PATTERN "*.h")

foreach(ITEM ${LIBRARY_FILES})
    file(INSTALL "${SOURCE_PATH}/v8/v8/out.gn/${VCPKG_TARGET_ARCHITECTURE}.release/${ITEM}" DESTINATION ${CURRENT_PACKAGES_DIR}/bin )
    file(INSTALL "${SOURCE_PATH}/v8/v8/out.gn/${VCPKG_TARGET_ARCHITECTURE}.release/${ITEM}.lib" DESTINATION ${CURRENT_PACKAGES_DIR}/lib )
    file(INSTALL "${SOURCE_PATH}/v8/v8/out.gn/${VCPKG_TARGET_ARCHITECTURE}.optdebug/${ITEM}" DESTINATION ${CURRENT_PACKAGES_DIR}/debug/bin )
    file(INSTALL "${SOURCE_PATH}/v8/v8/out.gn/${VCPKG_TARGET_ARCHITECTURE}.optdebug/${ITEM}.lib" DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib )
endforeach()

vcpkg_copy_pdbs()