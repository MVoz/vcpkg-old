include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/foo86/dcadec/archive/b93deed1a231dd6dd7e39b9fe7d2abe05aa00158.zip"
    FILENAME "b93deed1a231dd6dd7e39b9fe7d2abe05aa00158.zip"
    SHA512 56594eaa4ec04b138adcd209141c2a11411dd089fe988cd02d3674d13e1273aff20d5d79cf138c637452adc45f9b658e65bdd752cba0ddf53629f1f167c93af9
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_install_msbuild(
    SOURCE_PATH ${SOURCE_PATH}
#    PROJECT_SUBPATH "msvc/dcadec.sln"
	PROJECT_SUBPATH "msvc/libdcadec/libdcadec.vcxproj"

	SKIP_CLEAN
	LICENSE_SUBPATH COPYING.LGPLv2.1
	USE_VCPKG_INTEGRATION
)

file(COPY ${SOURCE_PATH}/libdcadec/dca_context.h ${SOURCE_PATH}/libdcadec/dca_frame.h ${SOURCE_PATH}/libdcadec/dca_stream.h ${SOURCE_PATH}/libdcadec/dca_waveout.h DESTINATION ${CURRENT_PACKAGES_DIR}/include/libdcadec)

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
###
