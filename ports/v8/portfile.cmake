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

include(vcpkg_common_functions)
#https://storage.googleapis.com/chrome-infra/depot_tools.zip
find_program(GIT NAMES git git.cmd)
set(GIT_URL "https://chromium.googlesource.com/chromium/tools/depot_tools.git")
set(GIT_REV master)
set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/${PORT})
if(NOT EXISTS "${SOURCE_PATH}/.git")
	message(STATUS "Cloning and fetching submodules")
	vcpkg_execute_required_process(
	  COMMAND ${GIT} clone --recurse-submodules ${GIT_URL} ${SOURCE_PATH}
	  WORKING_DIRECTORY ${SOURCE_PATH}
	  LOGNAME clone
	)
	message(STATUS "Checkout revision ${GIT_REV}")
	vcpkg_execute_required_process(
	  COMMAND ${GIT} checkout ${GIT_REV}
	  WORKING_DIRECTORY ${SOURCE_PATH}
	  LOGNAME checkout
	)
endif()

#DEPOT_TOOLS_WIN_TOOLCHAIN system variable in the same way, and set it to 0
#Visual Studio 2017 (the default) then set the GYP_MSVS_VERSION environment variable to 2019

set(ENV{PATH} "${SOURCE_PATH};$ENV{PATH}")
set(ENV{DEPOT_TOOLS_WIN_TOOLCHAIN} 0)
set(ENV{DEPOT_TOOLS_UPDATE} 0)
set(ENV{GYP_MSVS_VERSION} 2017)


message(STATUS "Updating depot_tools...")

vcpkg_execute_required_process(
    COMMAND ${SOURCE_PATH}/gclient.bat config https://chromium.googlesource.com/v8/v8.git
    WORKING_DIRECTORY ${SOURCE_PATH}
    LOGNAME "update-depot-tools-${TARGET_TRIPLET}"
)

file(MAKE_DIRECTORY ${SOURCE_PATH}/v8)

if(NOT EXISTS ${SOURCE_PATH}/v8/v8)
	message(STATUS "Initial fetch of v8 git repository")
	vcpkg_execute_required_process(
	    COMMAND fetch.bat --no-history v8
	    WORKING_DIRECTORY ${SOURCE_PATH}/v8
	    LOGNAME ${TARGET_TRIPLET}
	)
endif()

message(STATUS "Switching to checkout of v8 version 7.2")

vcpkg_execute_required_process(
    COMMAND ${GIT} checkout "branch-heads/7.2"
    WORKING_DIRECTORY ${SOURCE_PATH}/v8/v8
    LOGNAME ${TARGET_TRIPLET}
)

if(VCPKG_TARGET_ARCHITECTURE STREQUAL "x86")
    set(BUILDTYPE ia32.optdebug)
elseif(VCPKG_TARGET_ARCHITECTURE STREQUAL "x64")
    set(BUILDTYPE x64.optdebug)
else()
    message(FATAL_ERROR "Unsupported target architecture: ${VCPKG_TARGET_ARCHITECTURE}")
endif()

message(STATUS "Generating build directory ${BUILDTYPE}")
#COMMAND ${SOURCE_PATH}/python.bat ${SOURCE_PATH}/v8/v8/tools/dev/gm.py ${BUILDTYPE} -vv
vcpkg_execute_required_process(
    COMMAND ${SOURCE_PATH}/python.bat ${SOURCE_PATH}/v8/v8/tools/dev/v8gen.py ${BUILDTYPE} -vv
    WORKING_DIRECTORY ${SOURCE_PATH}/v8/v8
    LOGNAME ${TARGET_TRIPLET}-dbg
)
#gn gen out/lib --args="
#gn args out.gn\x64.release
#gn gen out/foo --args='is_debug=false target_cpu="x64" v8_target_cpu="arm64" use_goma=true'
#gn gen out/lib --args=
message(STATUS "Setting configuration for shared library build")

# Make DLLS
file(WRITE ${SOURCE_PATH}/v8/v8/out.gn/${BUILDTYPE}/args.gn "is_component_build = true\n" )
# You might need to change this if you have a different VS version installed.
file(APPEND ${SOURCE_PATH}/v8/v8/out.gn/${BUILDTYPE}/args.gn "visual_studio_version = \"2017\"" )
# Embed snapshot data into the binaries.
file(APPEND ${SOURCE_PATH}/v8/v8/out.gn/${BUILDTYPE}/args.gn "v8_use_external_startup_data = false" ) 
file(APPEND ${SOURCE_PATH}/v8/v8/out.gn/${BUILDTYPE}/args.gn "v8_static_library = false" ) 
file(APPEND ${SOURCE_PATH}/v8/v8/out.gn/${BUILDTYPE}/args.gn "use_custom_libcxx = false" ) 
file(APPEND ${SOURCE_PATH}/v8/v8/out.gn/${BUILDTYPE}/args.gn "use_custom_libcxx_for_host = false" ) 
file(APPEND ${SOURCE_PATH}/v8/v8/out.gn/${BUILDTYPE}/args.gn "is_clang = false" )
file(APPEND ${SOURCE_PATH}/v8/v8/out.gn/${BUILDTYPE}/args.gn "v8_use_snapshot = true" )
file(APPEND ${SOURCE_PATH}/v8/v8/out.gn/${BUILDTYPE}/args.gn "v8_monolithic = true" )
file(APPEND ${SOURCE_PATH}/v8/v8/out.gn/${BUILDTYPE}/args.gn "icu_use_data_file = false" )
file(APPEND ${SOURCE_PATH}/v8/v8/out.gn/${BUILDTYPE}/args.gn "v8_enable_embedded_builtins = false" )
#file(APPEND ${SOURCE_PATH}/v8/v8/out.gn/${BUILDTYPE}/args.gn "v8_use_external_startup_data = false" )

message(STATUS "Building ${BUILDTYPE} through ninja")

vcpkg_execute_required_process(
    COMMAND ninja -C out.gn/${BUILDTYPE}/ v8.dll v8_shell -v
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
    COMMAND ${SOURCE_PATH}/python.bat ${SOURCE_PATH}/v8/v8/tools/dev/v8gen.py ${BUILDTYPE} -vv
    WORKING_DIRECTORY ${SOURCE_PATH}/v8/v8
    LOGNAME ${TARGET_TRIPLET}-rel
)

message(STATUS "Setting configuration for shared library build")

file(WRITE ${SOURCE_PATH}/v8/v8/out.gn/${BUILDTYPE}/args.gn "is_component_build = true\n" )
file(APPEND ${SOURCE_PATH}/v8/v8/out.gn/${BUILDTYPE}/args.gn "visual_studio_version = \"2017\"" )
file(APPEND ${SOURCE_PATH}/v8/v8/out.gn/${BUILDTYPE}/args.gn "v8_use_external_startup_data = false" )
file(APPEND ${SOURCE_PATH}/v8/v8/out.gn/${BUILDTYPE}/args.gn "v8_static_library = false" ) 
file(APPEND ${SOURCE_PATH}/v8/v8/out.gn/${BUILDTYPE}/args.gn "use_custom_libcxx = false" ) 
file(APPEND ${SOURCE_PATH}/v8/v8/out.gn/${BUILDTYPE}/args.gn "use_custom_libcxx_for_host = false" ) 
file(APPEND ${SOURCE_PATH}/v8/v8/out.gn/${BUILDTYPE}/args.gn "is_clang = false" )
file(APPEND ${SOURCE_PATH}/v8/v8/out.gn/${BUILDTYPE}/args.gn "v8_use_snapshot = true" )
file(APPEND ${SOURCE_PATH}/v8/v8/out.gn/${BUILDTYPE}/args.gn "v8_monolithic = true" )
file(APPEND ${SOURCE_PATH}/v8/v8/out.gn/${BUILDTYPE}/args.gn "icu_use_data_file = false" )
file(APPEND ${SOURCE_PATH}/v8/v8/out.gn/${BUILDTYPE}/args.gn "v8_enable_embedded_builtins = false" )

message(STATUS "Building ${BUILDTYPE} through ninja")

vcpkg_execute_required_process(
    COMMAND ninja -C out.gn/${BUILDTYPE}/ v8.dll v8_shell -v
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