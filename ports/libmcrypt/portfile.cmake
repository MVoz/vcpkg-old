include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/winlibs/libmcrypt/archive/8c262217d4f3c5600b8df2e1c28a66383975c719.zip"
    FILENAME "8c262217d4f3c5600b8df2e1c28a66383975c719.zip"
    SHA512 5929aca60c14398cd91aeb2666ca58a88b62fdf592db199f45c6770d226c8494f8a0d617531124e5d414af4e2bd3ebae4fe826dab9ad65aa6c24e9a9f66738e2
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    PATCHES
      patch.patch
)

if(VCPKG_LIBRARY_LINKAGE STREQUAL dynamic)
	vcpkg_install_msbuild(
		SOURCE_PATH ${SOURCE_PATH}
		PROJECT_SUBPATH "win32/vc14/libmcrypt.sln"
		OPTIONS
			"/p:TargetPlatformVersion=10.0.17134.0" #${TargetPlatformVersion} #${windowsSDK} ?
			"/p:WindowsTargetPlatformVersion=10.0.17134.0" #${TargetPlatformVersion} #${windowsSDK} ?
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
			"/p:Configuration=Release dll" # "Release lib"

		OPTIONS_DEBUG
			"/p:RuntimeLibrary=MultiThreadedDebugDll"

		USE_VCPKG_INTEGRATION
		LICENSE_SUBPATH COPYING.LIB
		SKIP_CLEAN

	)
elseif(VCPKG_LIBRARY_LINKAGE STREQUAL static)
	vcpkg_install_msbuild(
		SOURCE_PATH ${SOURCE_PATH}
		PROJECT_SUBPATH "win32/vc14/libmcrypt.sln"
		OPTIONS
			"/p:TargetPlatformVersion=10.0.17134.0" #${TargetPlatformVersion} #${windowsSDK} ?
			"/p:WindowsTargetPlatformVersion=10.0.17134.0" #${TargetPlatformVersion} #${windowsSDK} ?
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
			"/p:Configuration=Release lib"

		OPTIONS_DEBUG
			"/p:RuntimeLibrary=MultiThreadedDebug"
			
		USE_VCPKG_INTEGRATION
		LICENSE_SUBPATH COPYING.LIB
		SKIP_CLEAN
	)
endif()

remove_srcs_file(
	"${SOURCE_PATH}/include/*.am"
	"${SOURCE_PATH}/include/*.in"
	"${CURRENT_PACKAGES_DIR}/debug/lib/COPYING.LIB"
	"${CURRENT_PACKAGES_DIR}/lib/COPYING.LIB"
)
file(COPY ${SOURCE_PATH}/include DESTINATION ${CURRENT_PACKAGES_DIR})

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
###
