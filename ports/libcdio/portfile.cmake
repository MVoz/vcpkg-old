include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/ShiftMediaProject/libcdio/archive/c7816cbcaed64045309be2d317e466891f2e3991.zip"
    FILENAME "libcdio.zip"
    SHA512 0647aca9f4687d04bb513597d62421afe21bdb9fce447c7953ed912becca8812885e8963293b7ac780b1d69a1dc90cd5af75bc0444e8f964d6094809742ed38d
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    PATCHES
      001_libcdio_patch.patch
)

vcpkg_install_msbuild(
    SOURCE_PATH ${SOURCE_PATH}
    PROJECT_SUBPATH SMP/libcdio.sln
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
