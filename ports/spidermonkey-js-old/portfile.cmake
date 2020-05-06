include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/gpac-buildbot/js/archive/451aa36b409eb55f1f829ac5db84d30d9a1a4070.zip"
    FILENAME "451aa36b409eb55f1f829ac5db84d30d9a1a4070.zip"
    SHA512 2025bf2cfd0c30d8657bc71bb9b100f17de615c6d20172d4327477478c510220c3dc2861024eda6b398de151118daf3cb953e6b556ca57e48db17ae30b2ad859
)
vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_install_msbuild(
    SOURCE_PATH ${SOURCE_PATH}
    PROJECT_SUBPATH "js.vcxproj"
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