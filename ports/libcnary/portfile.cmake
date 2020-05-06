include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/Polyfun/libimobiledevice-windows/archive/28a775641ba37f4c75107f07603827c47d98e5f8.zip"
    FILENAME "libcnary.zip"
    SHA512 b6530911e4c174bc002aee85260527927c983675ee68d790a5e898d1c4c977d5e8608f19c9279ca2eef3a5449ac29e209e2bcd15841e405e5dbdba747a401c42
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

file(REMOVE_RECURSE ${SOURCE_PATH}/lib ${SOURCE_PATH}/Delivery)

vcpkg_install_msbuild(
    SOURCE_PATH ${SOURCE_PATH}
    PROJECT_SUBPATH "libcnary/libcnary.vs2013.vcxproj"
	SKIP_CLEAN
	USE_VCPKG_INTEGRATION
)

file(COPY ${SOURCE_PATH}/libcnary/include DESTINATION ${CURRENT_PACKAGES_DIR})

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
###
