include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://gitlab.linphone.org/BC/public/external/minizip/-/archive/master/minizip-master.tar.gz"
    FILENAME "minizip-master.tar.gz"
    SHA512 ab73a8307a17e8840567dfd0a3db64a82036c2c5c4b3784b8d3284312eee2c4f8182a8d92c90b53d1848bf2fb333404a9a17735eb28b60b27913f84f59db1e63
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE} 
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    OPTIONS 
		-DUSE_AES=OFF #WinZIP AES Encryption ##Requires Brian Gladman's AES and SHA libraries
#		-DUSE_CRYPT=OFF #Disabling All Encryption ##USE_CRYPT=OFF USE_AES=OFF
		-DUSE_BZIP2=ON or #define HAVE_BZIP2
		-DUSE_LZMA=ON or #define HAVE_LZMA
		#Windows RT ##Requires #define MZ_USE_WINRT_API
		
    # OPTIONS_RELEASE -DOPTIMIZE=1
    # OPTIONS_DEBUG -DDEBUGGABLE=1
)

vcpkg_install_cmake()

# Handle copyright
# file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/minizip2-bc RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME minizip2-bc)
