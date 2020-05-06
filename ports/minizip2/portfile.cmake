include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/nmoinvaz/minizip/archive/64c4c7f868467ca21434cced2a418f21d3c6c664.zip"
    FILENAME "minizip2.zip"
    SHA512 bd6a3750b2504b78e881fc588b4381697d5ac948dbe81aa38d3ab2ebc907f4c1c43eadb9d22371682c6155c94b65d6e70fc3e2d570f046c430e029a8f2f97478
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE} 
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    OPTIONS 
		
		-DMZ_COMPAT=OFF				#Enables compatibility layer 	ON
#		-DMZ_ZLIB				#Enables ZLIB compression 	ON
#		-DMZ_BZIP2				#Enables BZIP2 compression 	ON
#		-DMZ_LZMA				#Enables LZMA compression 	ON
#		-DMZ_PKCRYPT			#Enables PKWARE traditional encryption 	ON
#		-DMZ_WZAES				#Enables WinZIP AES encryption 	ON
		-DMZ_LIBCOMP=OFF			#Enables Apple compression 	OFF
		-DMZ_OPENSSL=ON			#Enables OpenSSL encryption 	OFF
		-DMZ_BRG=OFF				#Enables Brian Gladman's library 	OFF
#		-DMZ_COMPRESS_ONLY		#Only support compression 	OFF
#		-DMZ_DECOMPRESS_ONLY	#Only support decompression 	OFF
#		-DMZ_BUILD_TEST			#Builds minizip test executable 	OFF
#		-DMZ_BUILD_UNIT_TEST	#Builds minizip unit test project 	OFF
#		-DMZ_BUILD_FUZZ_TEST	#Builds minizip fuzz executables 	OFF
		
    # OPTIONS_RELEASE -DOPTIMIZE=1
    # OPTIONS_DEBUG -DDEBUGGABLE=1
)

vcpkg_install_cmake()

# Handle copyright
# file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/minizip2 RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME minizip2)
