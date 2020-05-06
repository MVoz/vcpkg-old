include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO MediaArea/MediaInfoLib
    REF v19.04
    SHA512 cf3b47e9d1d7c7519db7fc130bb73d74731d213eaace533b3476af2abbc9f441244aba732c1777c3a29098ff12a0542cc75c1d18fc5b864f153bf3039059f284
    HEAD_REF master

    PATCHES vcpkg_support_in_cmakelists.patch
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}/Project/CMake
    PREFER_NINJA
    OPTIONS -DBUILD_ZENLIB=0 -DBUILD_ZLIB=0
)

vcpkg_install_cmake()
vcpkg_fixup_cmake_targets()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/lib/pkgconfig)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/lib/pkgconfig)

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/mediainfolib RENAME copyright)
file(INSTALL ${CURRENT_PORT_DIR}/usage DESTINATION ${CURRENT_PACKAGES_DIR}/share/mediainfolib)

vcpkg_test_cmake(PACKAGE_NAME MediaInfoLib MODULE)
