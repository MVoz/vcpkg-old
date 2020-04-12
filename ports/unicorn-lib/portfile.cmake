include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO CaptainCrowbar/unicorn-lib
<<<<<<< HEAD
    REF 3e4e014bbf6fe24721a14c63f2a4f7ebfa401e7c
    SHA512 f73f288fb50f9f727edfc84810a15f1fdde76df9030c4b0d5292351e84ec8cd6c8a7e670b2a62301a77521bf60ebcf1bf7c8c9d97ddb77385ed945b55075c927
=======
    REF c87e6b4394e543cf7fb45b0f8cdb289982bc180a
    SHA512 3df368439b8c09c69fde78999d6b1b98675bc8488a78d7fea3f68e7ad61f6afb3cfca47cdc3b96ffd4b2e6f2cda11ca03a745c2129a5f9a5d58d9c46b0292c4a
>>>>>>> [many ports] Updates 2019.04.19 (#6155)
    HEAD_REF master
)

file(COPY ${CURRENT_PORT_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH})

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS_DEBUG
        -DUNICORN_LIB_SKIP_HEADERS=ON
)

vcpkg_install_cmake()
vcpkg_copy_pdbs()

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE.TXT DESTINATION ${CURRENT_PACKAGES_DIR}/share/unicorn-lib RENAME copyright)