include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "http://ftp.acc.umu.se/pub/GNOME/sources/glib/2.60/glib-2.60.1.tar.xz"
    FILENAME "glib-2.60.1.tar.xz"
    SHA512 bcbc9fa04b56b4c54ceed5cef992f55852d8e0fe1a0d20830fa87f574b49d5bf6796a7241e3b246a1c5d1a958bef194eb96fb8e0ee054e6abcf3dced844269d2
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

set(CMAKE_FIND_LIBRARY_SUFFIXES .lib .dll .a)

set(ENV{PATH} ";$ENV{PATH};${CURRENT_INSTALLED_DIR}/bin")
find_package(PkgConfig REQUIRED)

vcpkg_configure_meson(
    SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
        --backend=ninja
        -Dnls=disabled
        -Dinternal_pcre=true
        -Dc_args=/I:${CURRENT_INSTALLED_DIR}/include
        -Dcpp_args=/I:${CURRENT_INSTALLED_DIR}/include
)

vcpkg_install_meson()

vcpkg_copy_pdbs()

# Handle copyright
file(INSTALL ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/glib RENAME copyright)

file(INSTALL ${CURRENT_PACKAGES_DIR}/debug/bin DESTINATION ${CURRENT_PACKAGES_DIR}/tools RENAME glib)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/bin)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

