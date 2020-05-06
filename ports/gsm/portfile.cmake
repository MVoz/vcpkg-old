include(vcpkg_common_functions)

#vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/Voskrese/libgsm-msvc/archive/b217c267ce2de39692cec18e7c42b5cddec5592b.zip"
    FILENAME "gsm-1.0.18.zip"
    SHA512 c5b597f68d4a270e1d588f480dcde66fda8302564c687d753f2bd4fc41d246109243e567568da61eddce170f5232d869984743ddf1eea7696d673014a1a453b7
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_install_msbuild(
    SOURCE_PATH ${SOURCE_PATH}
    PROJECT_SUBPATH "projects/vs14/gsm.vcxproj"
	SKIP_CLEAN
	LICENSE_SUBPATH COPYRIGHT
	USE_VCPKG_INTEGRATION
)

file(COPY ${SOURCE_PATH}/inc/gsm.h DESTINATION ${CURRENT_PACKAGES_DIR}/include/gsm)

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
###
