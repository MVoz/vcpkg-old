include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/gpac-buildbot/AMR_NB_FT/archive/a9105e4dd14134dd3eca7a5e5035938d0bc9880e.zip"
    FILENAME "a9105e4dd14134dd3eca7a5e5035938d0bc9880e.zip"
    SHA512 9c932fcd8efac873f25448fa2b9d17c707ba7779550cc7775d18a3a6c9a725af0b62f4ebdba7980092d0233eadd48028e5c2ebdb53b476e2a1e74b33309ca84d
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_install_msbuild(
    SOURCE_PATH ${SOURCE_PATH}
    PROJECT_SUBPATH "libamrfloat.vcxproj"
	SKIP_CLEAN
#	LICENSE_SUBPATH LICENSE
	USE_VCPKG_INTEGRATION
)

#file(COPY ${SOURCE_PATH}/include DESTINATION ${CURRENT_PACKAGES_DIR}/include RENAME a52dec)

#file(COPY ${SOURCE_PATH}/include DESTINATION ${CURRENT_PACKAGES_DIR}/include)
#file(RENAME ${CURRENT_PACKAGES_DIR}/include/include ${CURRENT_PACKAGES_DIR}/include/a52dec) 

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
###
