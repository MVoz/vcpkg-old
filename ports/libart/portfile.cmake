include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "http://ftp.gnome.org/pub/GNOME/sources/libart_lgpl/2.3/libart_lgpl-2.3.21.tar.gz"
    FILENAME "libart_lgpl-2.3.21.tar.gz"
    SHA512 a41c3d6563ec6db0a9d8421e6b6063518df6ad9435f145cd57144b4381afbf990fb498135107322cd0296783754700e2b403055974fd492130fb58d6f23aeb44
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

file(COPY ${CURRENT_PORT_DIR}/libart.vcxproj ${CURRENT_PORT_DIR}/libart.vcxproj.filters ${CURRENT_PORT_DIR}/gen_art_config.c DESTINATION ${SOURCE_PATH})
configure_file(${SOURCE_PATH}/config.h.in ${SOURCE_PATH}/config.h COPYONLY)

###
vcpkg_install_msbuild(
    SOURCE_PATH ${SOURCE_PATH}
    PROJECT_SUBPATH "libart.vcxproj"
	SKIP_CLEAN
	LICENSE_SUBPATH COPYING
	USE_VCPKG_INTEGRATION
)

file(GLOB_RECURSE INC_FILES ${SOURCE_PATH}/*.h)
file(COPY ${INC_FILES} DESTINATION ${CURRENT_PACKAGES_DIR}/include/libart-2.0/libart_lgpl)

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
###
