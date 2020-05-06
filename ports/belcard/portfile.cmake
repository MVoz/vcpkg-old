include(vcpkg_common_functions)

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_download_distfile(ARCHIVE
    URLS "https://gitlab.linphone.org/BC/public/belcard/-/archive/a75ba6e7a30bedbf125f98266231922003b56c1d/belcard-a75ba6e7a30bedbf125f98266231922003b56c1d.tar.gz"
    FILENAME "belcard.tar.gz"
    SHA512 febdbd84f6cb30b7d473517be61a965f6e80aa50469381dda961b6cf95efa70a2cd3b159a33822156635c06a8995d34e93ef88efbb992390e315c9d442b45464
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
      -DENABLE_SHARED=NO
      -DENABLE_STATIC=ON
      -DENABLE_STRICT=NO
      -DENABLE_TOOLS=NO
      -DENABLE_UNIT_TESTS=NO
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/COPYING ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
