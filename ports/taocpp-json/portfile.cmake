# header-only library

include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO taocpp/json
<<<<<<< HEAD
    REF 6adce3b8e55c16e25b22ec0e33348eefa6aa4533
    SHA512 078af33eed0bae7671f31a010ba19088d07ac4f78b834bc7565562ee75199e90338dfd450a1d592c4f4ae58eddb3a26018b571381099d22dfc7d3c4143911390
=======
    REF 8520fca2a054be775e406eaec66f33f02a7076e3
    SHA512 44bfd0252ed42d2619ca65e92d0f483895fd735b98a81e7f844526f78893a8624133ba356ad41f8c691571bf9f56823f62bfc0f294394e6e0f780b44a0b085fd
>>>>>>> [taocpp-json] Add new port (#6253)
    HEAD_REF master
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    DISABLE_PARALLEL_CONFIGURE
    PREFER_NINJA
    OPTIONS
        -DTAOCPP_JSON_BUILD_TESTS=OFF
        -DTAOCPP_JSON_BUILD_EXAMPLES=OFF
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(CONFIG_PATH share/taocpp-json/cmake)

file(REMOVE_RECURSE
    ${CURRENT_PACKAGES_DIR}/debug
    ${CURRENT_PACKAGES_DIR}/share/doc
)

# Handle copyright
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
file(COPY ${SOURCE_PATH}/LICENSE.double-conversion DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT})
file(COPY ${SOURCE_PATH}/LICENSE.itoa DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT})
file(COPY ${SOURCE_PATH}/LICENSE.ryu DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT})

# CMake integration test
vcpkg_test_cmake(PACKAGE_NAME ${PORT})
