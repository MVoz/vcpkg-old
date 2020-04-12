include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/Esri/cpptest/archive/dcf40b8f1e09f1a924a7d1b3a61b45759336ad09.zip"
    FILENAME "cpptest.zip"
    SHA512 0854c359efa7d3d40de9545e1b914d288b77c0281d9dd3cc44ef516ce3718d14168c3d45b24613b09505ac4d55245534d9a608f931628116d53adef9dfe3cc3e
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_install_msbuild(
    SOURCE_PATH ${SOURCE_PATH}
    PROJECT_SUBPATH "win/vs2017/cpptest/cpptest.vcxproj"
    SKIP_CLEAN
    LICENSE_SUBPATH COPYING
    USE_VCPKG_INTEGRATION
)

file(GLOB_RECURSE INC_FILES "${SOURCE_PATH}/src/cpptes*.h")
file(COPY ${INC_FILES} DESTINATION ${CURRENT_PACKAGES_DIR}/include)

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
###
