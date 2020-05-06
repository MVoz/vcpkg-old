include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/BrianGladman/aes/archive/0337bc72a240c759eadd9aa3122fed062c6de75f.zip"
    FILENAME "0337bc72a240c759eadd9aa3122fed062c6de75f.zip"
    SHA512 a000993b6d40905661c5f6f94fb6923ac402d7c7f09081823cd483522a9ab03bc43bd515174ac69fe4e2819790e0c4ee53e8323667c9524aa66a02b8f04c8986
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE} 
)

vcpkg_find_acquire_program(YASM)
get_filename_component(YASM_EXE_PATH ${YASM} DIRECTORY)
set(ENV{PATH} "$ENV{PATH};${YASM_EXE_PATH}")

#if(VCPKG_LIBRARY_LINKAGE STREQUAL dynamic)
	vcpkg_install_msbuild(
#		CURRENT_BUILDTREES_DIR ${SOURCE_PATH}
		SOURCE_PATH ${SOURCE_PATH}
#		CURRENT_INSTALLED_DIR ${CURRENT_INSTALLED_DIR}
		PROJECT_SUBPATH aes.sln
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
# file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/libaes RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME libaes)
