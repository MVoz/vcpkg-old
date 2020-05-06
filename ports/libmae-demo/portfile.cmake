include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO furylynx/MAE
    REF v0.10.7
    SHA512 c0bfc5e2df05efb4a01f68827d646a247ed3a92414c9ebb3c886464b5e365579a333530ac7170a8df7b7155e63253fce7ee41da0fd52e36ac235487d53c6daeb
    HEAD_REF master
)

vcpkg_configure_cmake(
    PREFER_NINJA
    SOURCE_PATH ${SOURCE_PATH}/libmae_demo/
)

vcpkg_install_cmake()

# Handle copyright
file(COPY ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/libmae-demo)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/libmae-demo/LICENSE ${CURRENT_PACKAGES_DIR}/share/libmae-demo/copyright)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)
