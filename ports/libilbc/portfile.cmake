include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/ShiftMediaProject/libilbc/archive/44afeae9e3c74ed9303aeae2480bfbbb0ce61af7.zip"
    FILENAME "44afeae9e3c74ed9303aeae2480bfbbb0ce61af7.zip"
    SHA512 11a3acf5f650dc0506048072dfa563c7470c44414994a666abd4a8d08eea33bec831608278ad5f8da135a651c55cabac17c0c3a75470ac08748a32a56dde1b5b
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    PATCHES
      001_libilbc_patch.patch
)

vcpkg_install_msbuild(
    SOURCE_PATH ${SOURCE_PATH}
    PROJECT_SUBPATH "SMP/libilbc.vcxproj"
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
	USE_VCPKG_INTEGRATION
)

set(PREBUILT ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel)
file(COPY ${PREBUILT}/msvc/include DESTINATION ${CURRENT_PACKAGES_DIR})

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
###
