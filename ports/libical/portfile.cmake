include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/libical/libical/archive/e84714e9d6ec724dca889531e11fb963cadc2dba.zip"
    FILENAME "e84714e9d6ec724dca889531e11fb963cadc2dba.zip"
    SHA512 3ffeb2719ac484ead6c0f46d97c094331e0fadb447f8bb7baa9b523f3cdaca573fac775987ed2837d856c822777521526d78f5027bfffa4130cb760577b59c4a
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
		-DENABLE_GTK_DOC=OFF
)

vcpkg_install_cmake()

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/libical RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME libical)
