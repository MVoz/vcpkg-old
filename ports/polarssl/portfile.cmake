include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
#    URLS "https://tls.mbed.org/code/releases/polarssl-1.3.9-gpl.tgz"
    URLS "https://gitlab.linphone.org/BC/public/external/polarssl/-/archive/polarssl-1.4/polarssl-polarssl-1.4.tar.gz"
    FILENAME "polarssl-1.4.tar.gz"
    SHA512 cc7a6eef0c7775799628cb67dca736ad6cf981a7e7e02ba6508156b1d1b3a47daacfa4b94766edc743cbcdb6e7b1f399de4456fdf9de0a0b2d9b6c3f728e1852
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
#    DISABLE_PARALLEL_CONFIGURE
    OPTIONS_DEBUG # automatic templates
        -DDISABLE_INSTALL_HEADERS=ON # automatic templates
#        -D =OFF
#    OPTIONS_RELEASE
#        -D =OFF
    OPTIONS 
        -DBUILD_SHARED_LIBS=ON # automatic templates
        -DENABLE_PROGRAMS=ON
        -DENABLE_TESTING=OFF
        -DENABLE_ZLIB_SUPPORT=ON
        -DINSTALL_POLARSSL_HEADERS=ON
        -DUSE_PKCS11_HELPER_LIBRARY=OFF
        -DUSE_SHARED_POLARSSL_LIBRARY=OFF
        -DUSE_STATIC_POLARSSL_LIBRARY=ON
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
