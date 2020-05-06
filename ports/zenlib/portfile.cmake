include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO MediaArea/ZenLib
    REF v0.4.37
    SHA512 857091422d6425aeae59bf5a9dfedd72f5c9b4a18f29acf88842d812f2b470fc8b1b03a245af6b7d08d616dd5596a8905cc138daecee23dadea39ae4215f77d4
    HEAD_REF master

    PATCHES vcpkg_support_in_cmakelists.patch
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}/Project/CMake
    PREFER_NINJA
)

vcpkg_install_cmake()
vcpkg_fixup_cmake_targets()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/lib/pkgconfig)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/lib/pkgconfig)

file(INSTALL ${CURRENT_PORT_DIR}/usage DESTINATION ${CURRENT_PACKAGES_DIR}/share/zenlib)
file(INSTALL ${SOURCE_PATH}/License.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/zenlib RENAME copyright)

vcpkg_test_cmake(PACKAGE_NAME ZenLib MODULE)
