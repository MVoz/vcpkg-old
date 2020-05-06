include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://gitlab.linphone.org/BC/public/external/libupnp/-/archive/master/libupnp-master.tar.gz"
    FILENAME "libupnp-master.tar.gz"
    SHA512 d1fb59e8e56f3d1baffe64fb70fb326912dc04a303e1bee3f991c817c2074d213ee3fa4497e1f08437c240dab38008af11ee601ee940c42708252f823dbc5e71
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
		PROJECT_SUBPATH build/vc10/libupnp.sln
#		PLATFORM ${PLATFORM}
#		OPTIONS
#			"/p:ConfigurationType=DynamicLibrary"	## работает приоритет и выполняет задачу
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
			
#		OPTIONS_DEBUG
#			"/p:RuntimeLibrary=MultiThreadedDebugDll"
#			"/p:TargetExt=.lib"
#			"/p:DisabledWarnings=MSB4011"
#			"/p:WarningsNotAsErrors=true"
#			"/p:ConfigurationType=DynamicLibrary"	## работает приоритет и выполняет задачу

#		OPTIONS_RELEASE
#			"/p:RuntimeLibrary=MultiThreadedDll"
#			"/p:TargetExt=.lib"
#			"/p:DisabledWarnings=MSB4011"
#			"/p:WarningsNotAsErrors=true"
#			"/p:ConfigurationType=DynamicLibrary"	## работает приоритет и выполняет задачу

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
# file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/libupnp RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME libupnp)
