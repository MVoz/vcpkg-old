include(vcpkg_common_functions)

if(VCPKG_CMAKE_SYSTEM_NAME OR VCPKG_CMAKE_SYSTEM_NAME STREQUAL "WindowsStore")
	message(FATAL_ERROR "\n-- Build port ${PORT} only supported Windows Desktop")
endif()

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/ShiftMediaProject/nettle/archive/c180b4d7afbda4049ad265d1366567f62a7a4a3a.zip"
    FILENAME "c180b4d7afbda4049ad265d1366567f62a7a4a3a.zip"
    SHA512 b9b78350127d545d7f4b9b925d1112224ecbdf48cb953855bc0c4fd5eb9368582f09ba09d57f453f2a9d1c4145e079a2501f96db12a16f5c05460ec2b9cf079c
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE} 
)

## https://github.com/Voskrese/vcpkg/blob/master/scripts/cmake/vcpkg_replace_string.cmake
vcpkg_replace_regex(${SOURCE_PATH}/SMP/libnettle.vcxproj ".\.\.\\msvc" "msvc")
vcpkg_replace_regex(${SOURCE_PATH}/SMP/libhogweed.vcxproj ".\.\.\\msvc" "msvc")

vcpkg_install_msbuild(
    SOURCE_PATH ${SOURCE_PATH}
    PROJECT_SUBPATH SMP/libnettle.sln
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