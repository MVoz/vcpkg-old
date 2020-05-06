include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/scrosby/OSM-binary/archive/4e32fa236e919be5bb8dbb323437f026f24e5853.zip"
    FILENAME "4e32fa236e919be5bb8dbb323437f026f24e5853.zip"
    SHA512 b05819fb97f0556a9020c56ca3e2ce5cc24ddb935d36239ba699ca5e38c143fa4fd3a9b3a0cd96df03cd1efc44038be586b845fce7185330c18c23e6d709e9e3
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates

    OPTIONS 
      -DSEARCH_PREFIX=${CURRENT_INSTALLED_DIR}/bin
#      -DCPPCHECK:FILEPATH=E:/tools/Cppcheck/cppcheck.exe
#      -DIWYU_TOOL:FILEPATH=IWYU_TOOL-NOTFOUND
#      -DProtobuf_SRC_ROOT_FOLDER=${CURRENT_INSTALLED_DIR}/protobuf-3.5
#      -DPROTOBUF_PROTOC_EXECUTABLE=
#      -DPROTOBUF_LIBRARY=
#      -DPROTOBUF_INCLUDE_DIR=${CURRENT_INSTALLED_DIR}/protobuf-3.5
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/COPYING ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
