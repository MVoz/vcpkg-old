include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/inphos42/osmpbf/archive/06e4f2e79dfd7020c4951d91747a37b900d3df96.zip"
    FILENAME "06e4f2e79dfd7020c4951d91747a37b900d3df96.zip"
    SHA512 9d6d935198938086cd979625e6c676c6fe868faadb81a56f62e922116fbe834cc2d7a29d4a1f98599c11757bb53553b8f88b44907d71b67079bba4f59abba892
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    # OPTIONS -DUSE_THIS_IN_ALL_BUILDS=1 -DUSE_THIS_TOO=2
    # OPTIONS_RELEASE -DOPTIMIZE=1
    # OPTIONS_DEBUG -DDEBUGGABLE=1
	OPTIONS
		-DProtobuf_SRC_ROOT_FOLDER=${SOURCE_PATH}/windows/protobuf
#		-DProtobuf_INCLUDE_DIR=${SOURCE_PATH}/windows/protobuf/src
		-DProtobuf_INCLUDE_DIRS=${CURRENT_INSTALLED_DIR}/include
#		-DProtobuf_INCLUDE_DIRS=${SOURCE_PATH}/windows/protobuf/src

)

vcpkg_install_cmake()

# Handle copyright
file(INSTALL ${SOURCE_PATH}/COPYING.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/osmpbf RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME osmpbf)
