
include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/resiprocate/msrp/archive/44da1ee1f4cd1096f856d14578a460453b1c0d95.zip"
    FILENAME "44da1ee1f4cd1096f856d14578a460453b1c0d95.zip"
    SHA512 ba4e7753d846700fd331078851a7c715cd41039eb284f2b5ee5f5b4ce1427ea7fa3433acb4f4ba6e482553328514a91fd5610a4012e9d1774cd49ba2536ffc5d
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

file(COPY ${CMAKE_CURRENT_LIST_DIR}/msrp.vcxproj.filters ${CMAKE_CURRENT_LIST_DIR}/msrp.vcxproj DESTINATION ${SOURCE_PATH}/src)

	vcpkg_install_msbuild(
		SOURCE_PATH ${SOURCE_PATH}
		PROJECT_SUBPATH "src/msrp.vcxproj"
		OPTIONS
			"/p:TargetPlatformVersion=10.0.17134.0" #${TargetPlatformVersion} #${windowsSDK} ?
			"/p:WindowsTargetPlatformVersion=10.0.17134.0" #${TargetPlatformVersion} #${windowsSDK} ?
			"/p:BuildInParallel=true"
			"/p:PreprocessorDefinitions=_LIB _WIN32" # _WIN64
			"/p:OutputType=Library"
			"/p:BuildProjectReferences=true"
			"/p:UseEnvironment=true"
			"/p:DisabledWarnings=MSB4011"
			"/p:ErrorReport=none"
			"/p:Utf8Output=true"
			"/p:WarningsNotAsErrors=true"
#		OPTIONS_RELEASE
#			"/p:RuntimeLibrary=MultiThreadedDll"

#		OPTIONS_DEBUG
#			"/p:RuntimeLibrary=MultiThreadedDebugDll"

		USE_VCPKG_INTEGRATION
		LICENSE_SUBPATH COPYING
		SKIP_CLEAN

	)

#file(GLOB_RECURSE TMP_FILES "${SOURCE_PATH}/include/*.hin" "${SOURCE_PATH}/include/*.orig" "${SOURCE_PATH}/include/*.in")
#file(REMOVE_RECURSE ${TMP_FILES})

#remove_srcs_file("${SOURCE_PATH}/include/*.hin" "${SOURCE_PATH}/include/*.orig" "${SOURCE_PATH}/include/*.in")

#file(COPY ${SOURCE_PATH}/include DESTINATION ${CURRENT_PACKAGES_DIR}/include)
#file(RENAME ${CURRENT_PACKAGES_DIR}/include/include ${CURRENT_PACKAGES_DIR}/include/openldap)

#file(TO_NATIVE_PATH "${CURRENT_INSTALLED_DIR}/include" PGSQL_INCLUDE_DIR)

#file(COPY ${SOURCE_PATH}/greatest.h DESTINATION ${CURRENT_PACKAGES_DIR}/include)

#vcpkg_fixup_cmake_targets(CONFIG_PATH "lib/cmake/${PORT}")
#vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/nlohmann_json TARGET_PATH share/nlohmann_json)
#file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/bin)
#file(RENAME ${CURRENT_PACKAGES_DIR}/lib/${LIB_NAME}.dll ${CURRENT_PACKAGES_DIR}/bin/${LIB_NAME}.dll
#file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/msrp RENAME copyright)

#file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/lib ${CURRENT_PACKAGES_DIR}/debug)
#file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin ${CURRENT_PACKAGES_DIR}/debug/bin ${CURRENT_PACKAGES_DIR}/debug/share ${CURRENT_PACKAGES_DIR}/debug/include)

#file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/tools)
#file(RENAME ${CURRENT_PACKAGES_DIR}/debug/bin ${CURRENT_PACKAGES_DIR}/tools/${PORT})

#vcpkg_copy_tool_dependencies(${CURRENT_PACKAGES_DIR}/tools/openexr)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME msrp)

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
###
