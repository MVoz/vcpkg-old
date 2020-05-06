include(vcpkg_common_functions)
vcpkg_find_acquire_program(DOXYGEN)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO frankheckenbach/ftgl
    REF 483639219095ad080538e07ceb5996de901d4e74
    SHA512 d5bf95db8db6a5c9f710bd274cb9bb82e3e67569e8f3ec55b36e068636a09252e6f191e36d8279e61b5d12408c065ce51829fc38d4d7afe5bda724752d2f084f
    HEAD_REF master
    PATCHES Fix-headersFilePath.patch
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
)

vcpkg_install_cmake()
vcpkg_fixup_cmake_targets(CONFIG_PATH cmake)
vcpkg_test_cmake(PACKAGE_NAME FTGL)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

file(COPY ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/ftgl)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/ftgl/COPYING ${CURRENT_PACKAGES_DIR}/share/ftgl/copyright)
