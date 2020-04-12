include(vcpkg_common_functions)

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

if("public-preview" IN_LIST FEATURES)
    vcpkg_from_github(
        OUT_SOURCE_PATH SOURCE_PATH
        REPO Azure/azure-c-shared-utility
        REF bc83cba1230e98988ae5cd2328f4dcf8c49d5866
        SHA512 48947709f9c07c8a910d40066a52b746f9ab15543837f44207b787674efd2b11e7a7eb849c88e20984f0e2141e5611f6d6edea39c8b82687f371c08ab274bd7b
        HEAD_REF master
        PATCHES no-double-expand-cmake.patch
    )
else()
    vcpkg_from_github(
        OUT_SOURCE_PATH SOURCE_PATH
        REPO Azure/azure-c-shared-utility
        REF bc83cba1230e98988ae5cd2328f4dcf8c49d5866
        SHA512 48947709f9c07c8a910d40066a52b746f9ab15543837f44207b787674efd2b11e7a7eb849c88e20984f0e2141e5611f6d6edea39c8b82687f371c08ab274bd7b
        HEAD_REF master
        PATCHES no-double-expand-cmake.patch
    )
endif()

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -Dskip_samples=ON
        -Duse_installed_dependencies=ON
        -Duse_default_uuid=ON
        -Dbuild_as_dynamic=OFF
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(CONFIG_PATH cmake TARGET_PATH share/azure_c_shared_utility)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include ${CURRENT_PACKAGES_DIR}/debug/share)

file(COPY ${SOURCE_PATH}/configs/azure_iot_build_rules.cmake DESTINATION ${CURRENT_PACKAGES_DIR}/share/azure-c-shared-utility)

configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/azure-c-shared-utility/copyright COPYONLY)

vcpkg_copy_pdbs()

