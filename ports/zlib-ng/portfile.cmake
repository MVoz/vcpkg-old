include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/zlib-ng/zlib-ng/archive/74a3e05bfa71e17f5b28d5f64d35e1cbe1b71a6a.zip"
    FILENAME "zlib-ng.zip"
    SHA512 07e19260d0f2f6bb987ad269e17475e2087cea7358cd885c6593375028f1266db67bc6cb0bd7eb630ea4328b2dc9051349de81821369a9bf0bce06df04577ed3
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS 
      -DWITH_FUZZERS=ON
      -DWITH_GZFILEOP=ON
      -DWITH_MSAN=ON
      -DWITH_NATIVE_INSTRUCTIONS=ON
      -DWITH_NEW_STRATEGIES=ON
      -DWITH_OPTIM=ON
      -DWITH_SANITIZERS=OFF
      -DZLIB_COMPAT=ON
      -DZLIB_ENABLE_TESTS=OFF
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE.md ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
