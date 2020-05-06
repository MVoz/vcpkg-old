include(vcpkg_common_functions)

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/mapbox/protozero/archive/fadd024d49f72240bc43548907d51c2b0f2eaeca.zip"
    FILENAME "protozero.zip"
    SHA512 88402a8e7bf9568053e03f70b795ac6f1bcb36241d41ad133cbb1484583792e3a2ffad822799de399f50ab5a429af340a0d63e4a4eedd78ca5029fd8bc1350cc
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE} 
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
	OPTIONS
		-DWERROR=OFF
#		-DCLANG_TIDY:FILEPATH=C:/Users/Nikolay/AppData/Roaming/npm/clang-tidy
#		-DCPPCHECK:FILEPATH=E:/tools/Cppcheck/cppcheck.exe
#		-DIWYU_TOOL:FILEPATH=IWYU_TOOL-NOTFOUND
		-DProtobuf_SRC_ROOT_FOLDER=${CURRENT_INSTALLED_DIR}/protobuf-3.5

)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
