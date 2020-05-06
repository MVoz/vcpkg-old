include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/osmcode/libosmium/archive/5858c491a108ced6d8d386ad6cc97e7c3d6e1d55.zip"
    FILENAME "libosmium.zip"
    SHA512 f7506b3d7753fa223b7c310e6a04b8386ec2be05ece1edf4dfb80da3ddba56a8b7a4969736a4e152bdffac56fc1b0ea1be9b7ee6528cf6f47ee9a5d89842fdd8
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
		-DBUILD_BENCHMARKS=OFF
		-DBUILD_DATA_TESTS=OFF
		-DBUILD_EXAMPLES=OFF
		-DBUILD_TESTING=OFF
		-DBUILD_WITH_CCACHE=OFF
)

vcpkg_install_cmake()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug)

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/libosmium RENAME copyright)
#
# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME libosmium)
