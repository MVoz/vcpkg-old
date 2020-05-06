include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://download.savannah.gnu.org/releases/freetype/freetype-2.10.1.tar.gz"
    FILENAME "freetype-2.10.1.tar.gz"
    SHA512 346c682744bcf06ca9d71265c108a242ad7d78443eff20142454b72eef47ba6d76671a6e931ed4c4c9091dd8f8515ebdd71202d94b073d77931345ff93cfeaa7
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

### https://mesonbuild.com/Configuring-a-build-directory.html
vcpkg_configure_meson(
    SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
      --backend=ninja
      -Dpng=enabled
      -Dbzip2=enabled
      -Dzlib=enabled
      -Dharfbuzz=enabled
)

vcpkg_install_meson()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/README ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
