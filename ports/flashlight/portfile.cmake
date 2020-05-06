include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/facebookresearch/flashlight/archive/99476fd1f6a7c7cb4f0e76e092ae087091a97b3e.zip"
    FILENAME "99476fd1f6a7c7cb4f0e76e092ae087091a97b3e.zip"
    SHA512 faf7b76f29ac765f9c971d5c857e72a5db53205eab9c4938213d349fbb18c329115340ed41d68a866e17d89e32ddc7a12f84faa1887416f27715b7c89d6cf0dd
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE} 
)
set(CUDNN_ROOT_DIR "C:/Program Files/PGI/win64/2018/cuda/10.1")
vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
	OPTIONS
		-DBUILD_TESTING=OFF
		-DBUILD_SHARED_LIBS=ON
		-DFLASHLIGHT_BACKEND=CPU
#		-DCUDNN_INCLUDE_DIR=${CUDNN_ROOT_DIR}/include
#		-DCUDNN_LIBRARY=${CUDNN_ROOT_DIR}/lib/x64/cudnn.lib
		-DFL_BUILD_DISTRIBUTED=OFF
		-DFL_BUILD_TESTS=OFF
		-DFL_BUILD_EXAMPLES=OFF
    # OPTIONS -DUSE_THIS_IN_ALL_BUILDS=1 -DUSE_THIS_TOO=2
    # OPTIONS_RELEASE -DOPTIMIZE=1
    # OPTIONS_DEBUG -DDEBUGGABLE=1
)

vcpkg_install_cmake()

# Handle copyright
# file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/flashlight RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME flashlight)
