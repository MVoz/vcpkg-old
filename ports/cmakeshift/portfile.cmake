include(vcpkg_common_functions)

set(CMakeshift_VERSION 3.4.0)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO mbeutel/CMakeshift
    REF ${CMakeshift_VERSION}
    SHA512 f22073cece2b414d81ad07e16de84bd98acef025cb813fdcad44e6f659d8311859e64ec6caa309ce1faa2644faaa1420904f3d67ab1a925f3ae5ddea22971955
    HEAD_REF master
)

vcpkg_configure_cmake(
    SOURCE_PATH "${SOURCE_PATH}"
    PREFER_NINJA
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(CONFIG_PATH "share/cmake/CMakeshift-${CMakeshift_VERSION}" TARGET_PATH "share/cmakeshift")

file(REMOVE_RECURSE
    "${CURRENT_PACKAGES_DIR}/CMakeshift-${CMakeshift_VERSION}"
    "${CURRENT_PACKAGES_DIR}/debug"
)

file(WRITE ${CURRENT_PACKAGES_DIR}/include/.CMakeshift "")
file(
    INSTALL "${SOURCE_PATH}/LICENSE.txt"
    DESTINATION "${CURRENT_PACKAGES_DIR}/share/cmakeshift"
    RENAME copyright)
