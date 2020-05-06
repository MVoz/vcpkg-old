include(vcpkg_common_functions)

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

set(SQLITE_VERSION 3260000)
set(SQLITE_HASH ba089abd16857a65fc6cf26558a0d3e6f20c278b8df451b357eea5154f8ccd5645c9cfdb30d0fd4fe64f19dd2f876a6cc4a28455b7b013770c2ce9a607171107)

vcpkg_download_distfile(ARCHIVE
    URLS "https://sqlite.org/2018/sqlite-amalgamation-${SQLITE_VERSION}.zip"
    FILENAME "sqlite-amalgamation-${SQLITE_VERSION}.zip"
    SHA512 ${SQLITE_HASH}
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    REF ${SQLITE_VERSION}
)

file(COPY
  ${CURRENT_PORT_DIR}/include
  ${CURRENT_PORT_DIR}/res
  ${CURRENT_PORT_DIR}/src
  ${CURRENT_PORT_DIR}/CMakeLists.txt
  DESTINATION ${SOURCE_PATH})

vcpkg_configure_cmake(SOURCE_PATH ${SOURCE_PATH} PREFER_NINJA)

vcpkg_install_cmake()
vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/${PORT})

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include ${CURRENT_PACKAGES_DIR}/debug/share)
file(INSTALL ${CURRENT_PORT_DIR}/license.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)

vcpkg_copy_pdbs()
