include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://sourceforge.net/projects/libwpd/files/libwpd/libwpd-0.10.2/libwpd-0.10.2.tar.gz/download"
    FILENAME "libwpd-0.10.2.tar.gz"
    SHA512 19da5016429db4d404068f4cbdb92ee3d225f583c61811498dc6e462b95742f75bd1193c2969d388f75315d071d92cb89d3dff5c88570d7c9649a5a7f74ee2c7
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE} 

)

if(VCPKG_LIBRARY_LINKAGE STREQUAL dynamic)
	vcpkg_install_msbuild(
#		CURRENT_BUILDTREES_DIR ${SOURCE_PATH}
		SOURCE_PATH ${SOURCE_PATH}
#		CURRENT_INSTALLED_DIR ${CURRENT_INSTALLED_DIR}
		PROJECT_SUBPATH build/win32/libwpd.vcxproj.sln
#		PLATFORM ${PLATFORM}
		OPTIONS
#		OPTIONS_RELEASE
			"/p:ConfigurationType=DynamicLibrary"
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

		SKIP_CLEAN
		LICENSE_SUBPATH CREDITS
		ALLOW_ROOT_INCLUDES ON
		USE_VCPKG_INTEGRATION

)
#elseif(VCPKG_LIBRARY_LINKAGE STREQUAL static)
#	vcpkg_install_msbuild(
#		CURRENT_BUILDTREES_DIR ${SOURCE_PATH}
#		SOURCE_PATH ${SOURCE_PATH}
#		CURRENT_INSTALLED_DIR ${CURRENT_INSTALLED_DIR}
#		PROJECT_SUBPATH win32/cyrus-sasl-core.sln
#		PLATFORM ${PLATFORM}
#		OPTIONS
#			"/p:ConfigurationType=StaticLibrary"
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
#)
endif()

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

# Handle copyright
#file(INSTALL ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/cyrus-sasl RENAME copyright)

# Handle copyright
# file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/libwpd RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME libwpd)
