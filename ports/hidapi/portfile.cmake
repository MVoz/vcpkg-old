include(vcpkg_common_functions)

set(VCPKG_POLICY_EMPTY_PACKAGE enabled)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/OpenHMD/hidapi/archive/b245d332914021c420001292ddea1769eff17f6d.zip"
    FILENAME "b245d332914021c420001292ddea1769eff17f6d.zip"
    SHA512 0e0feed440dfb585cb36556de87138a8d628f2729ec183c43e27fa7bacc35000382748375d292b43eecf3e86cfde01a1c5e1968a8a02925e4ee02ce3ba1ab79b
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
#    PATCHES
#        001_port_fixes.patch
#        002_more_port_fixes.patch
)

# https://mesonbuild.com/Configuring-a-build-directory.html
vcpkg_configure_meson(
	SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
		--backend=ninja
)

vcpkg_install_meson()

# Handle copyright
file(INSTALL ${SOURCE_PATH}/hidapi/hidapi.h DESTINATION ${CURRENT_PACKAGES_DIR}/include)
file(INSTALL ${SOURCE_PATH}/LICENSE.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/hidapi RENAME copyright)
if(VCPKG_LIBRARY_LINKAGE STREQUAL static)
    file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin ${CURRENT_PACKAGES_DIR}/debug/bin)
endif()

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME hidapi)
