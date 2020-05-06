include(vcpkg_common_functions)

if(VCPKG_CMAKE_SYSTEM_NAME OR VCPKG_CMAKE_SYSTEM_NAME STREQUAL "WindowsStore")
	message(FATAL_ERROR "\n-- Build port ${PORT} only supported Windows Desktop")
endif()

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/ShiftMediaProject/libdvdread/archive/d2f39607bfc0709e442640914371e3c10e8144a3.zip"
    FILENAME "d2f39607bfc0709e442640914371e3c10e8144a3.zip"
    SHA512 65806cbdb84de04dd34eb578ed753947fac16b466cbee8bea7c604de6c4b21f91e4761c86eee7bd87f0f935faaa324ad3469f83b9b2c2dbcdc5d97c50ba8119a
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE} 
)

## https://github.com/Voskrese/vcpkg/blob/master/scripts/cmake/vcpkg_replace_string.cmake
vcpkg_replace_regex(
    ${SOURCE_PATH}/SMP/libdvdread.vcxproj
    ".\.\.\\msvc"
    "msvc"
)

vcpkg_install_msbuild(
    SOURCE_PATH ${SOURCE_PATH}
    PROJECT_SUBPATH SMP/libdvdread.sln
	OPTIONS
#		CustomBuildAfterTargets and CustomBuildBeforeTargets ## <-- CustomBuildStep
#		/p:PostBuildEventUseInBuild=false
		/p:PreBuildEventUseInBuild=false  # error build ## Custom Clean Step ### del and rd
		/p:CustomBuildAfterTargets=false  # error build ## Custom Clean Step ### del and rd
#		/p:OutDir=${CURRENT_BUILDTREES_DIR}/../../msvc/
#	OPTIONS_RELEASE
#		/p:OutDir=${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/msvc/
#	OPTIONS_DEBUG
#		/p:OutDir=${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/msvc/
	SKIP_CLEAN
	LICENSE_SUBPATH COPYING
	ALLOW_ROOT_INCLUDES ON
	USE_VCPKG_INTEGRATION
)

## https://github.com/Voskrese/vcpkg/blob/master/scripts/cmake/vcpkg_install_msbuild.cmake
set(PREBUILT ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel)
file(COPY ${PREBUILT}/msvc/include DESTINATION ${CURRENT_PACKAGES_DIR})
