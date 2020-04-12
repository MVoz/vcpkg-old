include(vcpkg_common_functions)

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/Unidata/netcdf-fortran/archive/25fd8cc2bd3269fa31354c0003412a39ae871cbc.zip"
    FILENAME "25fd8cc2bd3269fa31354c0003412a39ae871cbc.zip"
    SHA512 a6e25788f48c1da09a79b8f18f535f2c226a654aeee32328b17f597763b3b13d9f29597e93fccd675022dfb32c9d601c123ffa0fd81bb40f57d76967f042ff3f
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
      -DBUILD_BENCHMARKS=OFF
      -DBUILD_EXAMPLES=OFF
      -DBUILD_TESTING=OFF
      -DENABLE_DOXYGEN=OFF
      -DENABLE_FILTER_TEST=OFF
      -DENABLE_FORTRAN_TYPE_CHECKS=ON
      -DENABLE_NETCDF4=ON
      -DENABLE_PARALLEL_TESTS=OFF
      -DENABLE_TESTS=OFF
      -DLARGE_FILE_TESTS=OFF
      -DTEST_WITH_VALGRIND=OFF
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/COPYRIGHT ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
