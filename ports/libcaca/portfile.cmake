include(vcpkg_common_functions)

# https://github.com/mwgoldsmith/caca/tree/master/projects/vs14

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/cacalabs/libcaca/archive/813baea7a7bc28986e474541dd1080898fac14d7.zip"
    FILENAME "libcaca.zip"
    SHA512 1e032f4dd6a2c670e4c5452930c06c91af03e34740af23428b37c37b32639d16d27db8715b52d4f7806308e6c4b6532d0c6f744d9436aa2dfab671182a315415
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_install_msbuild(
    SOURCE_PATH ${SOURCE_PATH}
    PROJECT_SUBPATH "caca/libcaca.vcxproj"
	SKIP_CLEAN
	LICENSE_SUBPATH COPYING
	USE_VCPKG_INTEGRATION
)

file(GLOB INC_FILES "${SOURCE_PATH}/caca/caca.h" "${SOURCE_PATH}/caca/caca_types.h" "${SOURCE_PATH}/caca/caca_conio.h" "${SOURCE_PATH}/caca/caca0.h")
file(COPY ${INC_FILES} DESTINATION ${CURRENT_PACKAGES_DIR}/include)

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
###
