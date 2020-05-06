include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/winlibs/openldap/archive/2615a35b32b3596a1e8f872f0c244bc4a41a047e.zip"
    FILENAME "2615a35b32b3596a1e8f872f0c244bc4a41a047e.zip"
    SHA512 40913df5e2448ff3280ec471128d424c60436aea1cdf9c8cabdd7e4a95db2d14cf86e7e4eb500a8fa26980fc8576bb94ecbeab008b58d4d83c1a4037539f1439
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

#file(GLOB_RECURSE TMP_FILES RELATIVE "${SOURCE_PATH}/include/*.hin" "${SOURCE_PATH}/include/*.orig" "${SOURCE_PATH}/include/*.in")
#file(REMOVE_RECURSE ${TMP_FILES})

function(remove_srcs)
      file(GLOB_RECURSE to_remove ${ARGN})
#      list(REMOVE_ITEM srcs ${to_remove})
      file(REMOVE_RECURSE srcs ${to_remove})
      set(srcs ${srcs} PARENT_SCOPE)
endfunction()

remove_srcs(
	"${SOURCE_PATH}/include/*.hin"
	"${SOURCE_PATH}/include/*.orig"
	"${SOURCE_PATH}/include/*.in"
)

if(VCPKG_LIBRARY_LINKAGE STREQUAL dynamic)
	vcpkg_install_msbuild(
		SOURCE_PATH ${SOURCE_PATH}
		PROJECT_SUBPATH "win32/vs16/liblber.sln"
		OPTIONS
			"/p:TargetPlatformVersion=10.0.17134.0" #${TargetPlatformVersion} #${windowsSDK} ?
			"/p:WindowsTargetPlatformVersion=10.0.17134.0" #${TargetPlatformVersion} #${windowsSDK} ?
			"/p:Configuration=Single Release"
#			"/p:ConfigurationType=DynamicLibrary" # only DLL
			"/p:BuildInParallel=true"
			"/p:PreprocessorDefinitions=_LIB _WIN32" # _WIN64
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
		LICENSE_SUBPATH COPYRIGHT
		SKIP_CLEAN

	)
elseif(VCPKG_LIBRARY_LINKAGE STREQUAL static)
	vcpkg_install_msbuild(
		SOURCE_PATH ${SOURCE_PATH}
		PROJECT_SUBPATH "win32/vs16/liblber.sln"
		OPTIONS
			"/p:TargetPlatformVersion=10.0.17134.0" #${TargetPlatformVersion} #${windowsSDK} ?
			"/p:WindowsTargetPlatformVersion=10.0.17134.0" #${TargetPlatformVersion} #${windowsSDK} ?
#			"/p:VisualStudioVersion=14.0"
			"/p:Configuration=Single Release"
#			"/p:ConfigurationType=DynamicLibrary" # only DLL
			"/p:BuildInParallel=true"
			"/p:PreprocessorDefinitions=_LIB _WIN32" # _WIN64
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
		LICENSE_SUBPATH COPYRIGHT
		SKIP_CLEAN
	)
endif()

file(COPY ${SOURCE_PATH}/include DESTINATION ${CURRENT_PACKAGES_DIR}/include)
file(RENAME ${CURRENT_PACKAGES_DIR}/include/include ${CURRENT_PACKAGES_DIR}/include/openldap)

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
###
