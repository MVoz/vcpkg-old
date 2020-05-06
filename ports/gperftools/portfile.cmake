include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/gperftools/gperftools/archive/fe62a0baab87ba3abca12f4a621532bf67c9a7d2.zip"
    FILENAME "gperftools.zip"
    SHA512 8c3f3c8d6dea8268ea353a35497fc431cd327ae506c87b8f56cf8e2829f03f57fcb24d8a51d162e8f64aa3925d59a059d808d21cdf7eb82599a1a273d876eeda
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE} 
)

## set(ENV{_CL_} "$ENV{_CL_} /GL-")
## set(ENV{_LINK_} "$ENV{_LINK_} /LTCG:OFF")

vcpkg_install_msbuild(
    SOURCE_PATH ${SOURCE_PATH}
#    PROJECT_SUBPATH gperftools.sln
    PROJECT_SUBPATH vsprojects/libtcmalloc_minimal/libtcmalloc_minimal.vcxproj
	# dynamic
	RELEASE_CONFIGURATION Release-Patch
	# static
#	RELEASE_CONFIGURATION Release-Override
	SKIP_CLEAN
	LICENSE_SUBPATH COPYING
	ALLOW_ROOT_INCLUDES ON
#	USE_VCPKG_INTEGRATION
)

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
file(COPY ${CURRENT_PACKAGES_DIR}/debug/bin DESTINATION ${CURRENT_PACKAGES_DIR})
file(REMOVE ${CURRENT_PACKAGES_DIR}/lib/low_level_alloc_unittest.lib)
file(REMOVE ${CURRENT_PACKAGES_DIR}/lib/addressmap_unittest.lib)
file(REMOVE ${CURRENT_PACKAGES_DIR}/debug/lib/low_level_alloc_unittest.lib)
file(REMOVE ${CURRENT_PACKAGES_DIR}/debug/lib/addressmap_unittest.lib)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/tools)

# Post-build test for cmake libraries
# ### vcpkg_test_cmake(PACKAGE_NAME gperftools)
