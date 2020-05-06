include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/gromacs/tng/archive/14dd68ff46df1ef1cf2d9bcc1f4f5bddb974ce1c.zip"
    FILENAME "14dd68ff46df1ef1cf2d9bcc1f4f5bddb974ce1c.zip"
    SHA512 dd8470a0b1c8287cba518fd9f4358045b54203fea66111aeaf3fe2d48ea3bfe1c2002eee0e7629c3ce33b6e0047398e2e0d690d3a39881f04d4954650804eabf
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

set(VCPKG_FORTRAN_ENABLED ON)
vcpkg_enable_fortran(intel)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates

    OPTIONS 
      -DTNG_BUILD_COMPRESSION_TESTS:BOOL=OFF
      -DTNG_BUILD_DOCUMENTATION:BOOL=OFF
      -DTNG_BUILD_EXAMPLES:BOOL=OFF
      -DTNG_BUILD_FORTRAN:BOOL=ON
      -DTNG_BUILD_OWN_ZLIB:BOOL=ON
      -DTNG_BUILD_TEST:BOOL=OFF
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/COPYING ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
