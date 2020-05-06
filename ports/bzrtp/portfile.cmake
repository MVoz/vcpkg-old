include(vcpkg_common_functions)

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/BelledonneCommunications/bzrtp/archive/b88e76e9a991a8cc9408d437c41aaea7626ed429.zip"
    FILENAME "bzrtp.zip"
    SHA512 33f85524ec690bbad7ee1f8073d9949aeec9c991a71f90998f93fc0bf6168300f473f4039c3b458a6ce0ceca8633c3e2f7ee9304b90788c22983e9aed2ecebd4
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
      -DENABLE_SHARED:BOOL=OFF
      -DENABLE_STATIC:BOOL=ON
      -DENABLE_STRICT:BOOL=ON
      -DENABLE_TESTS:BOOL=OFF
      -DENABLE_ZIDCACHE:BOOL=ON
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/COPYING ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
