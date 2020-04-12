include(vcpkg_common_functions)

#Cmake port https://github.com/btbx-io/libcpuid windows error
vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/anrieff/libcpuid/archive/f6e4e23796376fc1fa76f1e3e4166f2ae279de97.zip"
    FILENAME "libcpuid.zip"
    SHA512 348410e79d19194a6d3ceb2aaaf30f114ca9653b23ffe61c1cfca9e31d21804557abdbc11911dfc2e2d2f688c4f413af73f6d6f8710ee3650478ead90f8c072a
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_install_msbuild(
    SOURCE_PATH ${SOURCE_PATH}
    PROJECT_SUBPATH "libcpuid_vc10.sln"
    SKIP_CLEAN
    LICENSE_SUBPATH COPYING
    USE_VCPKG_INTEGRATION
)

file(COPY
  ${SOURCE_PATH}/libcpuid/libcpuid_constants.h
  ${SOURCE_PATH}/libcpuid/libcpuid_types.h
  ${SOURCE_PATH}/libcpuid/libcpuid.h
  DESTINATION
  ${CURRENT_PACKAGES_DIR}/include
)

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
###
