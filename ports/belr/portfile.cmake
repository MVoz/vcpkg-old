include(vcpkg_common_functions)

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/BelledonneCommunications/belr/archive/bf58e02ce52eeb174777102dff0ada8286141f6b.zip"
    FILENAME "bf58e02ce52eeb174777102dff0ada8286141f6b.zip"
    SHA512 64008b6b18be40e25cf9d939290e98a5c75778c1b5c69f800ee7152c2deb70e41d976add73707cb844e70fbef40acd17f50b75615a73aa8c0e2e04b7e65e880e
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
    OPTIONS
      -DENABLE_SHARED=NO
      -DENABLE_STATIC=ON
      -DENABLE_STRICT=NO
      -DENABLE_TESTS=NO
      -DENABLE_TOOLS=NO
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/COPYING ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
