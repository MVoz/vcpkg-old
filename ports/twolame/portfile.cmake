include(vcpkg_common_functions)

# https://github.com/mwgoldsmith/twolame/archive/a71c95b0fcf0709fb524e4552f6cfecdf6ffaef0.zip

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/njh/twolame/archive/273a420b48ff66559148f8840f9a25d194c58660.zip"
    FILENAME "273a420b48ff66559148f8840f9a25d194c58660.zip"
    SHA512 e15f548588236b8387c5a982f43f3f818200dc13cf6dac50f0df2f796407fdd04a0902045c1056ad7480ccc6d60fc2f3acbe7e53b9f308ffcddccf07afa391f8
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

file(GLOB vcxproj "${CMAKE_CURRENT_LIST_DIR}/*.vcxproj*")
file(COPY ${vcxproj} DESTINATION ${SOURCE_PATH}/win32)

if(VCPKG_LIBRARY_LINKAGE STREQUAL dynamic)
	vcpkg_install_msbuild(
		SOURCE_PATH ${SOURCE_PATH}
		PROJECT_SUBPATH "win32/libtwolame_dll.vcxproj"
		OPTIONS
			"/p:TargetPlatformVersion=10.0.17134.0" #${TargetPlatformVersion} #${windowsSDK} ?
			"/p:WindowsTargetPlatformVersion=10.0.17134.0" #${TargetPlatformVersion} #${windowsSDK} ?
#			"/p:Configuration=Single Release"
#			"/p:ConfigurationType=DynamicLibrary" # only DLL
			"/p:BuildInParallel=true"
			"/p:PreprocessorDefinitions=_LIB WIN32" # _WIN64
			"/p:OutputType=Library"
			"/p:BuildProjectReferences=true"
			"/p:UseEnvironment=true"
			"/p:DisabledWarnings=MSB4011"
			"/p:ErrorReport=none"
			"/p:Utf8Output=true"
			"/p:WarningsNotAsErrors=true"
		OPTIONS_RELEASE
			"/p:RuntimeLibrary=MultiThreadedDll"

		OPTIONS_DEBUG
			"/p:RuntimeLibrary=MultiThreadedDebugDll"

		USE_VCPKG_INTEGRATION
		LICENSE_SUBPATH COPYING
		SKIP_CLEAN

	)
elseif(VCPKG_LIBRARY_LINKAGE STREQUAL static)
	vcpkg_install_msbuild(
		SOURCE_PATH ${SOURCE_PATH}
		PROJECT_SUBPATH "win32/libtwolame_static.vcxproj"
		OPTIONS
			"/p:TargetPlatformVersion=10.0.17134.0" #${TargetPlatformVersion} #${windowsSDK} ?
			"/p:WindowsTargetPlatformVersion=10.0.17134.0" #${TargetPlatformVersion} #${windowsSDK} ?
#			"/p:VisualStudioVersion=14.0"
#			"/p:Configuration=Single Release"
#			"/p:ConfigurationType=DynamicLibrary" # only DLL
			"/p:BuildInParallel=true"
			"/p:PreprocessorDefinitions=_LIB WIN32" # _WIN64
			"/p:OutputType=Library"
			"/p:BuildProjectReferences=true"
			"/p:UseEnvironment=true"
			"/p:DisabledWarnings=MSB4011"
			"/p:ErrorReport=none"
			"/p:Utf8Output=true"
			"/p:WarningsNotAsErrors=true"
		OPTIONS_RELEASE
			"/p:RuntimeLibrary=MultiThreaded"

		OPTIONS_DEBUG
			"/p:RuntimeLibrary=MultiThreadedDebug"

		USE_VCPKG_INTEGRATION
		LICENSE_SUBPATH COPYING
		SKIP_CLEAN
	)
endif()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
