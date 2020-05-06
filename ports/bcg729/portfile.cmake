include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://www.linphone.org/releases/sources/bcg729/bcg729-1.0.4.tar.gz"
    FILENAME "bcg729-1.0.4.tar.gz"
    SHA512 21901d2c13369b71ab68d178c962b94507731c01958e99d35c943a8e8c1291de2e0bb79bfa7d50dd7be55df3ce80e78fa4afcf1a34b299adf1533f0fc5097ec2
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates
#    GENERATOR "NMake Makefiles" # automatic templates
#    DISABLE_PARALLEL_CONFIGURE
    OPTIONS_DEBUG # automatic templates
      -DDISABLE_INSTALL_HEADERS=ON # automatic templates
      -DINSTALL_HEADERS_TOOLS=OFF
      -DINSTALL_HEADERS=OFF
    OPTIONS_RELEASE 
      -DINSTALL_HEADERS=ON # automatic templates
#      -D =OFF
    OPTIONS 
      -DENABLE_SHARED:BOOL=ON
      -DENABLE_STATIC:BOOL=OFF
      -DENABLE_TESTS:BOOL=OFF
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/COPYING ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
