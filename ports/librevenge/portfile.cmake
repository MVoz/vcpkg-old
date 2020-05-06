include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/Distrotech/librevenge/archive/librevenge-0.0.4.tar.gz"
    FILENAME "librevenge-0.0.4.tar.gz"
    SHA512 b00653df56a9bb35ddef1c0d09522f94eddcf463ea2210a52edcba3fd3db363557b578154d914b6735d48ed52d5e56382e6288c938b4f356d8a5d34ce2bb68c6
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
		PROJECT_SUBPATH build/win32/librevenge.vcxproj.sln
#		PLATFORM ${PLATFORM}
		OPTIONS
#		OPTIONS_RELEASE
#			"/p:ConfigurationType=DynamicLibrary"
#			"/p:RuntimeLibrary=MultiThreadedDll"
#			"/p:BuildInParallel=true"
#			"/p:BuildProjectReferences=true"
#			"/p:UseEnvironment=true"
#			"/p:UseEnv=true"
			"/p:DisabledWarnings=MSB4011"
#			"/p:ErrorReport=none"
#			"/p:Utf8Output=true"
			"/p:WarningsNotAsErrors=true"
			
#		OPTIONS_DEBUG
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
			"/p:ConfigurationType=StaticLibrary"
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
		LICENSE_SUBPATH COPYING.LGPL
		ALLOW_ROOT_INCLUDES ON
		USE_VCPKG_INTEGRATION
)
#endif()

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

# Handle copyright
# file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/librevenge RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME librevenge)
