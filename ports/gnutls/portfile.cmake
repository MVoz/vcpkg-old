include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/ShiftMediaProject/gnutls/archive/b713dc94d9e05fdcfbcc4163cba6944b25777537.zip"
    FILENAME "b713dc94d9e05fdcfbcc4163cba6944b25777537.zip"
    SHA512 d4885c4edbec33b5e4caff28e6404bf4e4320e6a65466f686735437f2bc342e5dd748dfc8a149a3ef7c3e06e35b681747647cac8a009004a3b4a7c16935cfcd7
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE} 
)

vcpkg_find_acquire_program(YASM)
get_filename_component(YASM_EXE_PATH ${YASM} DIRECTORY)
set(ENV{PATH} "$ENV{PATH};${YASM_EXE_PATH}")

## https://github.com/Voskrese/vcpkg/blob/master/scripts/cmake/vcpkg_replace_string.cmake
#vcpkg_replace_regex(${SOURCE_PATH}/SMP/libgnutls.vcxproj ".\.\.\\msvc" "msvc")

#if(VCPKG_LIBRARY_LINKAGE STREQUAL static)
#	vcpkg_replace_regex(${SOURCE_PATH}/SMP/libbluray.vcxproj "libfreetype" "freetype")
#	vcpkg_replace_regex(${SOURCE_PATH}/SMP/libbluray.vcxproj "libiconvd" "libiconv")
#	vcpkg_replace_regex(${SOURCE_PATH}/SMP/libbluray.vcxproj "libxml2d" "libxml2")
#	vcpkg_replace_regex(${SOURCE_PATH}/SMP/libbluray.vcxproj "fontconfigd" "fontconfig")
#	vcpkg_replace_regex(${SOURCE_PATH}/SMP/libbluray.vcxproj "libfontconfig" "fontconfig")
#endif()

vcpkg_install_msbuild(
    SOURCE_PATH ${SOURCE_PATH}
    PROJECT_SUBPATH SMP/libgnutls.sln
	OPTIONS
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
set(PREBUILT ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel)
file(COPY ${PREBUILT}/msvc/include DESTINATION ${CURRENT_PACKAGES_DIR})