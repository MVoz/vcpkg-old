include(vcpkg_common_functions)

if(VCPKG_CMAKE_SYSTEM_NAME OR VCPKG_CMAKE_SYSTEM_NAME STREQUAL "WindowsStore")
	message(FATAL_ERROR "\n-- Build port ${PORT} only supported Windows Desktop")
endif()

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/ShiftMediaProject/libgpg-error/archive/124da5e5679a38b93129f53095d0a5e90b9afec2.zip"
    FILENAME "libgpg-error.zip"
    SHA512 56bc8766b22885a133b20c583b8a73aa7fb7be22f91583b8ddf10197431ed66efee6f47253227a977e4394e6538cf3b3da88fce4a2f7fc63c50eec2f66908bd8
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE} 
)

vcpkg_install_msbuild(
    SOURCE_PATH ${SOURCE_PATH}
    PROJECT_SUBPATH SMP/libgpg-error.sln
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

