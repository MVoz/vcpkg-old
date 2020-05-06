include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/kimgr/getopt_port/archive/4173eb55a74e19e6010c7def2437aad8679112c5.zip"
    FILENAME "4173eb55a74e19e6010c7def2437aad8679112c5.zip"
    SHA512 6b7cdd8731cbf47a22eca0e9db1e1589bf6a9ba932a03c6f7947553a41e947d5e47da8fc5b5536ab79814cbfb848151b8e960077b3e9417c2b0ceb9d76797fdf
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates
)

vcpkg_install_cmake()

file(COPY ${SOURCE_PATH}/getopt.h DESTINATION ${CURRENT_PACKAGES_DIR}/include)

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE.txt ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
