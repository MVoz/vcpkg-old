include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/zougloub/libchardet/archive/2f54c084fed3bab354fe4bce07c8eba35a775289.zip"
    FILENAME "2f54c084fed3bab354fe4bce07c8eba35a775289.zip"
    SHA512 a890eba9968e43e63044406e8f5a3db8fb9255e6fb450360faa0e34c55fe0c7dd64baad146148e637c441be05a8d89c4318c6f5eb493809c57888bacfe1aed00
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

#vcpkg_find_acquire_program(WAF)
vcpkg_acquire_waf()

if(NOT EXISTS "${SOURCE_PATH}/waf")
  file(COPY "${WAF_DIR}/waf" DESTINATION "${SOURCE_PATH}")
endif()

vcpkg_configure_waf(
    SOURCE_PATH ${SOURCE_PATH}
#    OPTIONS
#		-vvv
#      --disable-sndfile
#      --disable-avcodec
#      --disable-docs
#      --disable-samplerate
#      --disable-jack
    # OPTIONS_DEBUG
    # OPTIONS_RELEASE
#    OPTIONS_BUILD
#      --notests
    # OPTIONS_BUILD_RELEASE
    # OPTIONS_BUILD_DEBUG
    # TARGETS
)

# Handle copyright
# file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/libchardet RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME libchardet)
