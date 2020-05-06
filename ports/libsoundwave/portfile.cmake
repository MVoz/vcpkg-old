include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/warrengalyen/libsoundwave/archive/4b8dd3d7da458138da56a9e2c61fb4ffccf1e899.zip"
    FILENAME "4b8dd3d7da458138da56a9e2c61fb4ffccf1e899.zip"
    SHA512 de7b2c979201c5a63ff9455f1680b35fd9c2f3467ffa0aa532b61421343f3e13d62513ce49df7072f2026eae5e2ee1e2c15cce9d4b403ff4ba9b33b711fcc0cd
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

###
vcpkg_install_msbuild(
    SOURCE_PATH ${SOURCE_PATH}
    PROJECT_SUBPATH "visual studio/vs2017/libsoundwave.vcxproj"
#    TARGET restore
    SKIP_CLEAN
#    RELEASE_CONFIGURATION Release_x86${MPG123_CONFIGURATION_SUFFIX}
#    DEBUG_CONFIGURATION Debug_x86${MPG123_CONFIGURATION_SUFFIX}
    LICENSE_SUBPATH COPYING.txt
#    ALLOW_ROOT_INCLUDES ON
    USE_VCPKG_INTEGRATION
)

file(COPY ${SOURCE_PATH}/include/libsoundwave DESTINATION ${CURRENT_PACKAGES_DIR}/include)

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
###
