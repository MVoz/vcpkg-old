include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/MyCaffe/ethminer/archive/88472ff8212c359b41482233838b8b1062d4c4fd.zip"
    FILENAME "88472ff8212c359b41482233838b8b1062d4c4fd.zip"
    SHA512 38cde67f3210fbcec2713fcef2a0a688a48cbc336021554919ee48e818a8d1cbe78a62e1f133dca8c426f236413052fe927163b8773dc6c54d90245fb9481c90
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)


## https://github.com/Voskrese/vcpkg/blob/master/scripts/cmake/vcpkg_replace_string.cmake
#vcpkg_replace_regex(${SOURCE_PATH}/SMP/libbluray.vcxproj ".\.\.\\msvc" "msvc")

#if(VCPKG_LIBRARY_LINKAGE STREQUAL static)
#	vcpkg_replace_regex(${SOURCE_PATH}/SMP/libbluray.vcxproj "libfreetype" "freetype")
#	vcpkg_replace_regex(${SOURCE_PATH}/SMP/libbluray.vcxproj "libiconvd" "libiconv")
#	vcpkg_replace_regex(${SOURCE_PATH}/SMP/libbluray.vcxproj "libxml2d" "libxml2")
#	vcpkg_replace_regex(${SOURCE_PATH}/SMP/libbluray.vcxproj "fontconfigd" "fontconfig")
#	vcpkg_replace_regex(${SOURCE_PATH}/SMP/libbluray.vcxproj "libfontconfig" "fontconfig")
#endif()

vcpkg_install_msbuild(
    SOURCE_PATH ${SOURCE_PATH}
    PROJECT_SUBPATH ethminer.sln
#	OPTIONS
#		CustomBuildAfterTargets and CustomBuildBeforeTargets ## <-- CustomBuildStep
#		/p:PostBuildEventUseInBuild=false
#		/p:PreBuildEventUseInBuild=false  # error build ## Custom Clean Step ### del and rd
#		/p:CustomBuildAfterTargets=false  # error build ## Custom Clean Step ### del and rd
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
#set(PREBUILT ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel)
#file(COPY ${PREBUILT}/msvc/include DESTINATION ${CURRENT_PACKAGES_DIR})

