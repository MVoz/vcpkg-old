include(vcpkg_common_functions)

#vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_download_distfile(ARCHIVE
    URLS "https://gitlab.linphone.org/BC/public/external/decaf/-/archive/3641d9c157af1ac526ebf2be0b9884b552e8bafc/decaf-3641d9c157af1ac526ebf2be0b9884b552e8bafc.tar.gz"
    FILENAME "decaf-bc.tar.gz"
    SHA512 0e1f812762ebf10719598e42ba4d147a8954d515d88885c0b31a6077f9ecf004aa50a0b4373c4a79b1cb636a145b5faf63dd69ea28ae7a82ff63cb201ba4d18b
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
      -DENABLE_SHARED:BOOL=ON
      -DENABLE_STATIC:BOOL=OFF
      -DENABLE_STRICT:BOOL=OFF
      -DENABLE_TESTS:BOOL=OFF
      -DGENERATED_SOURCE_PATH:BOOL=OFF
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE.txt ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###