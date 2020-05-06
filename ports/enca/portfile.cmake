include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/ShiftMediaProject/enca/archive/7ac22d19a8463cd2f770f2925b150595b05b58e4.zip"
    FILENAME "7ac22d19a8463cd2f770f2925b150595b05b58e4.zip"
    SHA512 02e5e9e519a6acd34ab24dae801af7b96f499c0cab35264e1663897e099ffa5defc11d643befe63a0280e714a1e4d7c59520e7696fa603560d5bb62125264092
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE} 
)


vcpkg_install_msbuild(
    SOURCE_PATH ${SOURCE_PATH}
    PROJECT_SUBPATH SMP/libenca.sln
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
	LICENSE_SUBPATH COPYING.LESSERv3
	ALLOW_ROOT_INCLUDES ON
	USE_VCPKG_INTEGRATION
)

## https://github.com/Voskrese/vcpkg/blob/master/scripts/cmake/vcpkg_install_msbuild.cmake
set(PREBUILT ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel)
file(COPY ${PREBUILT}/msvc/include DESTINATION ${CURRENT_PACKAGES_DIR})