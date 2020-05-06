include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/uncrustify/uncrustify/archive/1e666758ab489b78d70f299ae15557975de82523.zip"
    FILENAME "1e666758ab489b78d70f299ae15557975de82523.zip"
    SHA512 7e5cf587bb977ce66921bbd08c6071d18143ac600becd5cd9e0b2858b9fbd2848e8f931f94e5a4cc5e84848298d2ad8ca53b05018455a07c735e73e15bd64f5c
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
#    OPTIONS 
#      -D =OFF # automatic templates
)

vcpkg_install_cmake()

remove_srcs_file(${CURRENT_PACKAGES_DIR}/*ChangeLog* ${CURRENT_PACKAGES_DIR}/*BUGS* ${CURRENT_PACKAGES_DIR}/*README*)

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/COPYING ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
