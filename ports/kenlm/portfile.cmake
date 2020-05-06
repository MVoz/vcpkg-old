include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/kpu/kenlm/archive/2ad7cb56924cd3c6811c604973f592cb5ef604eb.zip"
    FILENAME "2ad7cb56924cd3c6811c604973f592cb5ef604eb.zip"
    SHA512 b8e7fef8fdc78144119bcbb5b77a83e0b852002a61e3cc3b030bc7c57eb14bd001a376e061baeacf22c3ab333c1585b043df1c718460cac49ff2120765068695
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE} 
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
	OPTIONS
		-DBUILD_TESTING=OFF
#		-DFORCE_STATIC=OFF
    # OPTIONS -DUSE_THIS_IN_ALL_BUILDS=1 -DUSE_THIS_TOO=2
    # OPTIONS_RELEASE -DOPTIMIZE=1
    # OPTIONS_DEBUG -DDEBUGGABLE=1
)

vcpkg_install_cmake()

# Handle copyright
# file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/kenlm RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME kenlm)
