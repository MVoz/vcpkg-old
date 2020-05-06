include(vcpkg_common_functions)

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_download_distfile(ARCHIVE
    URLS "https://gitlab.linphone.org/BC/public/ortp/-/archive/b7e53a7479b54e66703ddb7fe171b13156cc8afb/ortp-b7e53a7479b54e66703ddb7fe171b13156cc8afb.tar.gz"
    FILENAME "ortp.tar.gz"
    SHA512 4b3204dcf49d920592d5f53b437f4e7eebd3564300ca1931943076e4932b5e4c61058093e8ad0f4ab828550f6aed4b0b966b31c1257154663186fe783e4e665a
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
      -DENABLE_DEBUG_LOGS:BOOL=OFF
      -DENABLE_DOC:BOOL=OFF
      -DENABLE_NTP_TIMESTAMP:BOOL=OFF
      -DENABLE_PERF:BOOL=OFF
      -DENABLE_SHARED:BOOL=OFF
      -DENABLE_STATIC:BOOL=ON
      -DENABLE_STRICT:BOOL=OFF
      -DENABLE_TESTS:BOOL=OFF
      -DLIBM:FILEPATH=LIBM-NOTFOUND
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/COPYING ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###