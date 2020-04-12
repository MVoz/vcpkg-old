include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "http://download.videolan.org/pub/videolan/libdca/0.0.6/libdca-0.0.6.tar.bz2"
    FILENAME "libdca-0.0.6.tar.bz2"
    SHA512 d264128019e7fd295a35691636311f81960c17802dbbc67764c4e00b2fdf12ebc69b057a4947b57551a130e5cfd1fef3fe3558c7067216ea04a0b6bbb881b4f1
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

file(REMOVE ${SOURCE_PATH}/vc++/inttypes.h)
file(GLOB_RECURSE vcxproj ${CMAKE_CURRENT_LIST_DIR}/*.filters ${CMAKE_CURRENT_LIST_DIR}/*.vcxproj)
file(COPY ${vcxproj} DESTINATION ${SOURCE_PATH}/vc++)

vcpkg_install_msbuild(
    SOURCE_PATH ${SOURCE_PATH}
    PROJECT_SUBPATH "vc++/libdca.vcxproj"
	SKIP_CLEAN
	LICENSE_SUBPATH COPYING
	USE_VCPKG_INTEGRATION
)

file(COPY ${SOURCE_PATH}/include/dts.h ${SOURCE_PATH}/include/dca.h DESTINATION ${CURRENT_PACKAGES_DIR}/include)

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
###
