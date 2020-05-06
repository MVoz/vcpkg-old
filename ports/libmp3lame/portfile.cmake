include(vcpkg_common_functions)

if(VCPKG_CMAKE_SYSTEM_NAME OR VCPKG_CMAKE_SYSTEM_NAME STREQUAL "WindowsStore")
	message(FATAL_ERROR "\n-- Build port ${PORT} only supported Windows Desktop")
endif()

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/ShiftMediaProject/lame/archive/d765345379dc6a7c9c853e12e00ab58f8c9901d2.zip"
    FILENAME "d765345379dc6a7c9c853e12e00ab58f8c9901d2.zip"
    SHA512 1b30cdce2f842336f76e12c3cd07c68f6a868c5ef7d60c1fb5005de57faf916bf9279eed1a54793aaf4e2c41e175dcef15437093d3cd5f3634da3261a004c85d
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

## https://github.com/Voskrese/vcpkg/blob/master/scripts/cmake/vcpkg_replace_string.cmake
vcpkg_replace_regex(${SOURCE_PATH}/SMP/libmp3lame.vcxproj ".\.\.\\msvc" "msvc")

vcpkg_install_msbuild(
    SOURCE_PATH ${SOURCE_PATH}
    PROJECT_SUBPATH SMP/libmp3lame.sln
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
	LICENSE_SUBPATH LICENSE
	ALLOW_ROOT_INCLUDES ON
	USE_VCPKG_INTEGRATION
)

## https://github.com/Voskrese/vcpkg/blob/master/scripts/cmake/vcpkg_install_msbuild.cmake
set(PREBUILT ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel)
file(COPY ${PREBUILT}/msvc/include DESTINATION ${CURRENT_PACKAGES_DIR})