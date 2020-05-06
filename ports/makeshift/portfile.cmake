include(vcpkg_common_functions)

set(makeshift_VERSION 1.1.0)

vcpkg_download_distfile(
    OUT_DISTFILE_PATH
    URLS "https://mp-force.ziti.uni-heidelberg.de/kmbeutel/makeshift/-/archive/${makeshift_VERSION}/makeshift-${makeshift_VERSION}.tar.gz"
    FILENAME "makeshift-${makeshift_VERSION}.tar.gz"
    SHA512 5eb04656d7b7899a5dbb517082df162bdeb2e726703eae8c1573b0c6bb20a0b222bfebe969a4eb91d4b7149de61404db333682e7ddf2459e8f62d3c10ea35f8f
)

set(SOURCE_PATH "${CURRENT_BUILDTREES_DIR}/src/")
vcpkg_extract_source_archive(${OUT_DISTFILE_PATH} "${SOURCE_PATH}")
vcpkg_configure_cmake(
    SOURCE_PATH "${SOURCE_PATH}/makeshift-${makeshift_VERSION}"
    PREFER_NINJA
    OPTIONS
        -DEXPORT_BUILD_DIR=OFF
        -DBUILD_TESTS=OFF
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(CONFIG_PATH "share/cmake/makeshift-${makeshift_VERSION}" TARGET_PATH "share/makeshift")

file(REMOVE_RECURSE
    "${CURRENT_PACKAGES_DIR}/makeshift-${makeshift_VERSION}"
    "${CURRENT_PACKAGES_DIR}/debug/makeshift-${makeshift_VERSION}"
    "${CURRENT_PACKAGES_DIR}/debug/include"
    "${CURRENT_PACKAGES_DIR}/debug/share"
)

file(
    INSTALL "${SOURCE_PATH}/makeshift-${makeshift_VERSION}/LICENSE.txt"
    DESTINATION "${CURRENT_PACKAGES_DIR}/share/makeshift"
    RENAME copyright)
