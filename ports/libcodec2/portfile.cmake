include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
#    URLS "http://files.freeswitch.org/downloads/libs/libcodec2-2.59.tar.gz"
    URLS "https://gitlab.linphone.org/BC/public/external/codec2/-/archive/4e154e6bbbe92cc76e333a0b4acb365b5c042ec6/codec2-4e154e6bbbe92cc76e333a0b4acb365b5c042ec6.tar.gz"
    FILENAME "libcodec2.tar.gz"
    SHA512 e59d2eca89de9d8e64327dce53b91ea9e35c72e228ed4627550d210903d226641b0bf74f05a1589dd5a1cce66c29787c03a76ab3cf43df343c7e23c19bd8e236
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
      -DBUILD_SHARED_LIBS=ON
      -DINSTALL_EXAMPLES=OFF
      -DUNITTEST=OFF
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/COPYING ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
