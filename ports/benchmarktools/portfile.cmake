include(vcpkg_common_functions)

set(benchmarktools_VERSION 1.1.0)

vcpkg_download_distfile(
    OUT_DISTFILE_PATH
    URLS "https://mp-force.ziti.uni-heidelberg.de/kmbeutel/benchmarktools/-/archive/${benchmarktools_VERSION}/benchmarktools-${benchmarktools_VERSION}.tar.gz"
    FILENAME "benchmarktools-${benchmarktools_VERSION}.tar.gz"
    SHA512 92b0c9cbdf5e1f5db06f68d5bba16bd96c1897d15fa0b9c33a74af97e06256a4eabb42c61126b6461ab3a62cd90d58f06d4279495435e550c5528c543e96beef
)

set(SOURCE_PATH "${CURRENT_BUILDTREES_DIR}/src/")
vcpkg_extract_source_archive(${OUT_DISTFILE_PATH} "${SOURCE_PATH}")
vcpkg_configure_cmake(
    SOURCE_PATH "${SOURCE_PATH}/benchmarktools-${benchmarktools_VERSION}"
    PREFER_NINJA
    OPTIONS
        -DEXPORT_BUILD_DIR=OFF
        -DBUILD_TESTS=OFF
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(CONFIG_PATH "share/cmake/benchmarktools-${benchmarktools_VERSION}" TARGET_PATH "share/benchmarktools")

file(REMOVE_RECURSE
    "${CURRENT_PACKAGES_DIR}/benchmarktools-${benchmarktools_VERSION}"
    "${CURRENT_PACKAGES_DIR}/debug"
)

file(
    INSTALL "${SOURCE_PATH}/benchmarktools-${benchmarktools_VERSION}/LICENSE.txt"
    DESTINATION "${CURRENT_PACKAGES_DIR}/share/benchmarktools"
    RENAME copyright)
