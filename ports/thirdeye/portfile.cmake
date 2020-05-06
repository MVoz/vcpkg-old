include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/psi29a/thirdeye/archive/a33a05509566c8e4d54292bf840529c0893449de.zip"
    FILENAME "a33a05509566c8e4d54292bf840529c0893449de.zip"
    SHA512 27dca449d8472d91d805baa258ca6452000af98affa93fdb925eb05070ae63bfd8f8e0aea65afc585426234442609adfd66248c3281be0c12d6e680168b01e41
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
      -DBUILD_ARC=OFF
      -DBUILD_DAESOP=OFF
      -DBUILD_LAUNCHER=OFF
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/GPL3.txt ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
