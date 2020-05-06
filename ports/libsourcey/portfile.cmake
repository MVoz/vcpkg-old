include(vcpkg_common_functions)

#vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/sourcey/libsourcey/archive/067d1469eb28bf2356cd7a28bb452e9afa6688a5.zip"
    FILENAME "libsourcey.zip"
    SHA512 afbf7884d672f7b9e7faa0100c4d03e8b8f431f8a37fffb3f6a2d29d2142d5e66fe79033e3904920cecf792b82a114701f28e6a26ec5209c029e47bfb6d5d0e1
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
#      -DAMD64=OFF
#      -DASM686=OFF
      -DBUILD_ALPHA=OFF
      -DBUILD_DEPENDENCIES=OFF
      -DBUILD_MODULES=OFF
      -DBUILD_WITH_DEBUG_INFO=ON
      -DENABLE_NOISY_WARNINGS=OFF
      -DENABLE_SOLUTION_FOLDERS=OFF
      -DENABLE_WARNINGS_ARE_ERRORS=OFF
      -DMSG_VERBOSE=OFF
#      -DOPENCV_LINK_SHARED_LIBS=ON
      -DWITH_FFMPEG=OFF
      -DWITH_OPENCV=OFF
      -DWITH_OPENSSL=ON
      -DWITH_POCO=OFF
      -DWITH_WEBRTC=OFF
      -DWITH_WXWIDGETS=OFF
      -DWITH_ZLIB=ON
#      -DBUILD_WITH_STATIC_CRT=ON
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE.md ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
