include(vcpkg_common_functions)

if(VCPKG_CMAKE_SYSTEM_NAME OR VCPKG_CMAKE_SYSTEM_NAME STREQUAL "WindowsStore")
	message(FATAL_ERROR "\n-- Build port ${PORT} only supported Windows Desktop")
endif()

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/ShiftMediaProject/libbluray/archive/cc2b9429b103ad75935ee32da825712adfa5a21f.zip"
    FILENAME "cc2b9429b103ad75935ee32da825712adfa5a21f.zip"
    SHA512 082fb806530ec5adddbe439533b35ef4998c9cdac0da93c1a11ce783bf547cccf6519452fb647e5d11e7ce295825b45bf5ddc69013bd79a0305c76cd87376792
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE} 
)


## https://github.com/Voskrese/vcpkg/blob/master/scripts/cmake/vcpkg_replace_string.cmake
vcpkg_replace_regex(${SOURCE_PATH}/SMP/libbluray.vcxproj ".\.\.\\msvc" "msvc")

#if(VCPKG_LIBRARY_LINKAGE STREQUAL static)
	vcpkg_replace_regex(${SOURCE_PATH}/SMP/libbluray.vcxproj "libfreetype" "freetype")
	vcpkg_replace_regex(${SOURCE_PATH}/SMP/libbluray.vcxproj "libiconvd" "libiconv")
	vcpkg_replace_regex(${SOURCE_PATH}/SMP/libbluray.vcxproj "libxml2d" "libxml2")
	vcpkg_replace_regex(${SOURCE_PATH}/SMP/libbluray.vcxproj "fontconfigd" "fontconfig")
	vcpkg_replace_regex(${SOURCE_PATH}/SMP/libbluray.vcxproj "libfontconfig" "fontconfig")
#endif()

vcpkg_install_msbuild(
    SOURCE_PATH ${SOURCE_PATH}
    PROJECT_SUBPATH SMP/libbluray.sln
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

