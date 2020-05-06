include(vcpkg_common_functions)

#if(VCPKG_TARGET_ARCHITECTURE MATCHES "x86" AND VCPKG_LIBRARY_LINKAGE MATCHES dynamic)
#    set(PLATFORM x86)
#elseif(VCPKG_TARGET_ARCHITECTURE MATCHES "x86" AND VCPKG_LIBRARY_LINKAGE MATCHES static)
#    set(PLATFORM Win32)
#endif()

if(VCPKG_TARGET_ARCHITECTURE MATCHES "x86")
    set(PLATFORM x86)
elseif(VCPKG_TARGET_ARCHITECTURE MATCHES "x86" AND VCPKG_LIBRARY_LINKAGE MATCHES static)
    set(PLATFORM Win32)
endif()

if(VCPKG_CMAKE_SYSTEM_NAME)
    message(FATAL_ERROR "Unsupported platform. Port ${PORT} currently only supports Windows Desktop.")
endif()

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/cyrusimap/cyrus-sasl/archive/9c4ee5d0665c323fd7867eddd560bc67fda307e6.zip"
    FILENAME "cyrus-sasl.zip"
    SHA512 9a43387d0234f4f39f1018dc7a29a340c0c0634cf84053fc97c84a48415b2ff7124a890ab276bbb9e679fc96b43bb107481368de7843ec4ed6601a9ec1cd8110
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
		PROJECT_SUBPATH win32/cyrus-sasl-core.sln
		OPTIONS
			"/p:TargetPlatformVersion=10.0.17134.0"
			"/p:WindowsTargetPlatformVersion=10.0.17134.0"
			"/p:BuildInParallel=true"
			"/p:BuildProjectReferences=true"
			"/p:UseEnvironment=true"
			"/p:DisabledWarnings=MSB4011"
			"/p:ErrorReport=none"
			"/p:Utf8Output=true"
			"/p:WarningsNotAsErrors=true"
		OPTIONS_RELEASE
#			"/p:ConfigurationType=DynamicLibrary"
			"/p:RuntimeLibrary=MultiThreadedDll"

		OPTIONS_DEBUG
#			"/p:ConfigurationType=DynamicLibrary"
			"/p:RuntimeLibrary=MultiThreadedDebugDll"

		USE_VCPKG_INTEGRATION
		LICENSE_SUBPATH COPYING
)
elseif(VCPKG_LIBRARY_LINKAGE STREQUAL static)
	vcpkg_install_msbuild(
		SOURCE_PATH ${SOURCE_PATH}
		PROJECT_SUBPATH win32/cyrus-sasl-all-in-one.sln
#		PLATFORM ${PLATFORM}
		OPTIONS_RELEASE
#			"/p:ConfigurationType=StaticLibrary"
#			"/p:RuntimeLibrary=MultiThreaded"
			"/p:BuildInParallel=true"
#			"/p:BuildProjectDependencies=true"
#			"/p:OutputType=Library"
#			"/p:OnlyReferenceAndBuildProjectsEnabledInSolutionConfiguration=false"
#			"/p:RuntimeLib=dynamic_library"
#			"/p:RuntimeLib=static_library"
#			/p:Platform=x86
			
		OPTIONS_DEBUG 
#			"/p:ConfigurationType=StaticLibrary"
#			"/p:RuntimeLibrary=MultiThreadedDebug"
			"/p:BuildInParallel=true"
#			"/p:BuildProjectDependencies=true"
#			"/p:OutputType=Library"
#			"/p:OnlyReferenceAndBuildProjectsEnabledInSolutionConfiguration=false"
#			"/p:RuntimeLib=static_library"
#			/p:Platform=x86
		USE_VCPKG_INTEGRATION
		LICENSE_SUBPATH COPYING
)
endif()

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
