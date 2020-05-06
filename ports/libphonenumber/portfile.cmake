include(vcpkg_common_functions)

#vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/google/libphonenumber/archive/9090c6cd72e29e213ddb37e976a83744865f5f3c.zip"
    FILENAME "9090c6cd72e29e213ddb37e976a83744865f5f3c.zip"
    SHA512 f67d30674a66fbf14f6ed796c8aa2173c61861552b307029641a30f837cd1ccb89325f3887ea335a316a734f0fb2245e23efe60a806a3f709aac9fec79638bf7
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}/cpp
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates
#    GENERATOR "NMake Makefiles" # automatic templates
    OPTIONS_DEBUG # automatic templates
      -DDISABLE_INSTALL_HEADERS=ON # automatic templates
      -DINSTALL_HEADERS_TOOLS=OFF
      -DINSTALL_HEADERS=OFF
      -DPROTOBUF_LIB=${CURRENT_INSTALLED_DIR}/debug/lib/libprotobufd.lib
    OPTIONS_RELEASE 
      -DINSTALL_HEADERS=ON # automatic templates
      -DPROTOBUF_LIB=${CURRENT_INSTALLED_DIR}/lib/libprotobuf.lib
#      -D =OFF
    OPTIONS 
      -DBUILD_STATIC_LIB=OFF
	  -DBUILD_SHARED_LIB=ON
      -DBUILD_GEOCODER=ON
      -DUSE_ALTERNATE_FORMATS=ON
      -DUSE_BOOST=ON
      -DUSE_ICU_REGEXP=ON
      -DUSE_LITE_METADATA=ON
      -DUSE_RE2=OFF
      -DUSE_STD_MAP=ON
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
