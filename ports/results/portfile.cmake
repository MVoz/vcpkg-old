#header-only library
include(vcpkg_common_functions)
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO MoAlyousef/results
    REF v0.0.1
    SHA512 360903cedddeaf2407fe635a273e431005906420213791e15ed7fe40a12dbe7ec9ee28cbacb16b609a66d2069f1905afbd18e071d6a841c51001b02fffb29225
    HEAD_REF master
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/Results TARGET_PATH share/results)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/lib)

# Handle copyright
file(COPY ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/results)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/results/LICENSE ${CURRENT_PACKAGES_DIR}/share/results/copyright)
