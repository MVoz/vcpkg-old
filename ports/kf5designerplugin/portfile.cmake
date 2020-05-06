include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO KDE/kdesignerplugin
    REF v5.58.0
    SHA512 fc22ebb87c9bc97b00a51218d0b405fadc735f89b840ef8ad0a1d46379660b5bf77fd096a792ac12aeb04a6d4dec164c61acbc01d4fcab23c96c281be1a899d5
    HEAD_REF master
)

vcpkg_find_acquire_program(PYTHON3)
vcpkg_find_acquire_program(XGETTEXT)
get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
get_filename_component(GETTEXT_DIR "${XGETTEXT}" DIRECTORY)
set(ENV{PATH} ";$ENV{PATH};${GETTEXT_DIR};${PYTHON3_DIR}")
vcpkg_add_to_path(${VCPKG_ROOT_DIR}/installed/${TARGET_TRIPLET}/debug/bin)
vcpkg_add_to_path(${VCPKG_ROOT_DIR}/installed/${TARGET_TRIPLET}/bin)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS -DBUILD_HTML_DOCS=OFF
            -DBUILD_MAN_DOCS=OFF
            -DBUILD_QTHELP_DOCS=OFF
            -DBUILD_TESTING=OFF
            -DKDE_INSTALL_PLUGINDIR=plugins
)

vcpkg_install_cmake()
vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/KF5DesignerPlugin)
vcpkg_copy_pdbs()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin/data)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/bin/data)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/etc)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/etc)
file(INSTALL ${SOURCE_PATH}/COPYING.LIB DESTINATION ${CURRENT_PACKAGES_DIR}/share/kf5designerplugin RENAME copyright)

set(VCPKG_POLICY_EMPTY_PACKAGE enabled)
