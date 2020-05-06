include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/boxerab/harfbuzz/archive/46b35070a167680a3ed5b2c9de2d6657581a817b.zip"
    FILENAME "harfbuzz.zip"
    SHA512 6ead8e5fafc6da1d348418e9d35ffa9e6ca5f3a9e7a05674927c767a64fa5ef8bbdfd259c60d6efecaa23f536865f48087a884ec239e6db9d6a68fa2e0b033df
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_find_acquire_program(PYTHON3)
get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
set(ENV{PATH} "$ENV{PATH};${PYTHON3_DIR}")

### https://mesonbuild.com/Configuring-a-build-directory.html
vcpkg_configure_meson(
    SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
      --backend=ninja
      -Dglib=enabled
      -Dgobject=disabled
      -Dcairo=enabled
      -Dfontconfig=enabled
      -Dicu=enabled
      -Dgraphite=enabled
      -Dfreetype=enabled
      -Duniscribe=enabled
      -Ddirectwrite=enabled
      -Dcoretext=enabled
#disabled
      -Dtests=disabled
      -Dintrospection=disabled
)

vcpkg_install_meson()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/COPYING ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
