include(vcpkg_common_functions)

if(VCPKG_CMAKE_SYSTEM_NAME OR VCPKG_CMAKE_SYSTEM_NAME STREQUAL "WindowsStore")
	message(FATAL_ERROR "\n-- Build port ${PORT} only supported Windows Desktop")
endif()

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/ShiftMediaProject/libgcrypt/archive/63025e264a22caef3e9d8c932561fa2d55a0c3e8.zip"
    FILENAME "libgcrypt.zip"
    SHA512 b4a3734db258d8743caa7c0df502f2973ffe7314238b3f7d1a00fd2ef038b4ae82aab6af0ddc238277dcca5ce1394ed445a9f18d899d8c88b896a409679dc974
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
	PATCHES
	  001_libgcrypt_patch.patch
)

vcpkg_install_msbuild(
    SOURCE_PATH ${SOURCE_PATH}
    PROJECT_SUBPATH SMP/libgcrypt.sln
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
	LICENSE_SUBPATH COPYING.LIB
	USE_VCPKG_INTEGRATION
)

set(PREBUILT ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel)
file(COPY ${PREBUILT}/msvc/include DESTINATION ${CURRENT_PACKAGES_DIR})
file(REMOVE ${CURRENT_PACKAGES_DIR}/debug/lib/COPYING.LIB)
file(REMOVE ${CURRENT_PACKAGES_DIR}/lib/COPYING.LIB)