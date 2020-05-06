include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/stachenov/quazip/archive/0.7.6.zip"
    FILENAME "quazip0.7.6.zip"
    SHA512 6b47aa7658bd0cd5b1a7c433cdcae31e17e75f59a1e0901268cfc9f5694f39ab2aeef3a75c0c806ed60d9ec22435b6a8b1c77810817e6bb44ea72a83f011a01b
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

set(ENV{PATH} "$ENV{PATH};${CURRENT_INSTALLED_DIR}/tools/qt5")

#https://github.com/mesonbuild/quazip/tree/0.7.3

### https://mesonbuild.com/Configuring-a-build-directory.html
vcpkg_configure_meson(
    SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
      --backend=ninja
)

vcpkg_install_meson()

file(COPY ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/quazip/quazip.lib DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
file(COPY ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/quazip/quazip.lib DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)
if(VCPKG_LIBRARY_LINKAGE STREQUAL dynamic)
    file(COPY ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/quazip/quazip.dll DESTINATION ${CURRENT_PACKAGES_DIR}/bin)
    file(COPY ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/quazip/quazip.dll DESTINATION ${CURRENT_PACKAGES_DIR}/debug/bin)
endif()
#file(INSTALL ${SOURCE_PATH}/quazip DESTINATION ${CURRENT_PACKAGES_DIR}/include/quazip FILES_MATCHING PATTERN *.h)
file(GLOB PUBLIC_HEADERS "${SOURCE_PATH}/quazip/*.h")
file(COPY ${PUBLIC_HEADERS} DESTINATION ${CURRENT_PACKAGES_DIR}/include/quazip)

#set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/CONTRIBUTING.md ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
