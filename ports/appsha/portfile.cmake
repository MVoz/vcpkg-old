include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/BrianGladman/sha/archive/df4ed74db83ea9ebc1486c247d3855dde8224481.zip"
    FILENAME "df4ed74db83ea9ebc1486c247d3855dde8224481.zip"
    SHA512 564de75dbc459ab4b5c85f803258c8260dfcf31b654f5df383bf696dd45c1d9ddc3feeaaaf6e9b6f92f0965ec9125b7de38960f174064949ae9c3d952bda92b5
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE} 
)

#if(VCPKG_LIBRARY_LINKAGE STREQUAL dynamic)
	vcpkg_install_msbuild(
#		CURRENT_BUILDTREES_DIR ${SOURCE_PATH}
		SOURCE_PATH ${SOURCE_PATH}
#		CURRENT_INSTALLED_DIR ${CURRENT_INSTALLED_DIR}
		PROJECT_SUBPATH sha.sln
#		PLATFORM ${PLATFORM}
#		OPTIONS
#		OPTIONS_RELEASE

#			"/p:ConfigurationType=DynamicLibrary"	## работает приоритет и выполняет задачу
#			"/p:TargetName=hmac"

#			"/p:TargetExt=.exe"
#			"/p:TargetExt=.lib"
#			"/p:TargetExt=.dll"
#			"/p:TargetExt=.pyd"

#			"/p:RuntimeLibrary=MultiThreadedDll"
#			"/p:BuildInParallel=true"
#			"/p:BuildProjectReferences=true"
#			"/p:UseEnvironment=true"
#			"/p:UseEnv=true"
#			"/p:DisabledWarnings=MSB4011"
#			"/p:ErrorReport=none"
#			"/p:Utf8Output=true"
#			"/p:WarningsNotAsErrors=true"
		OPTIONS
#			"/p:TargetExt=.dll"
			"/p:DisabledWarnings=MSB4011"
			"/p:WarningsNotAsErrors=true"
			"/p:ConfigurationType=DynamicLibrary"	## работает приоритет и выполняет задачу
			"/p:OutputType=Library"
			"/p:RuntimeLibrary=MultiThreadedDll"
		OPTIONS_DEBUG
			"/p:RuntimeLibrary=MultiThreadedDebugDll"
			
			
#		OPTIONS_RELEASE
#			"/p:RuntimeLibrary=MultiThreadedDll"
			
			
#			"/p:ConfigurationType=DynamicLibrary"
#			"/p:RuntimeLibrary=MultiThreadedDebugDll"
#			"/p:BuildInParallel=true"
#			"/p:BuildProjectReferences=true"
#			"/p:UseEnvironment=true"
#			"/p:DisabledWarnings=MSB4011"
#			"/p:ErrorReport=none"
#			"/p:Utf8Output=true"
#			"/p:WarningsNotAsErrors=true"
#			

#		SKIP_CLEAN
#		LICENSE_SUBPATH COPYING.LGPL
#		ALLOW_ROOT_INCLUDES ON
#		USE_VCPKG_INTEGRATION

#)
#elseif(VCPKG_LIBRARY_LINKAGE STREQUAL static)
#	vcpkg_install_msbuild(
#		CURRENT_BUILDTREES_DIR ${SOURCE_PATH}
#		SOURCE_PATH ${SOURCE_PATH}
#		CURRENT_INSTALLED_DIR ${CURRENT_INSTALLED_DIR}
#		PROJECT_SUBPATH win32/cyrus-sasl-core.sln
#		PLATFORM ${PLATFORM}
#		OPTIONS

###			"/p:ConfigurationType=StaticLibrary" ## работает приоритет и выполняет задачу

#			"/p:OutputType=Library"
#			"/p:RuntimeLib=static_library"
#		OPTIONS_RELEASE 
#			"/p:ConfigurationType=StaticLibrary"
#			"/p:RuntimeLibrary=MultiThreaded"
#			"/p:BuildInParallel=true"
#			"/p:BuildProjectDependencies=true"
#			"/p:OutputType=Library"
#			"/p:OnlyReferenceAndBuildProjectsEnabledInSolutionConfiguration=false"
#			"/p:RuntimeLib=dynamic_library"
#			"/p:RuntimeLib=static_library"
#			/p:Platform=x86
			
#		OPTIONS_DEBUG 
#			"/p:ConfigurationType=StaticLibrary"
#			"/p:RuntimeLibrary=MultiThreadedDebug"
#			"/p:BuildInParallel=true"
#			"/p:BuildProjectDependencies=true"
#			"/p:OutputType=Library"
#			"/p:OnlyReferenceAndBuildProjectsEnabledInSolutionConfiguration=false"
#			"/p:RuntimeLib=static_library"
#			/p:Platform=x86

#		USE_VCPKG_INTEGRATION
#		ALLOW_ROOT_INCLUDES

		SKIP_CLEAN
#		LICENSE_SUBPATH COPYING.LGPL
		ALLOW_ROOT_INCLUDES ON
		USE_VCPKG_INTEGRATION
)
#endif()

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

# Handle copyright
# file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/libsha RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME libsha)
