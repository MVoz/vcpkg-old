include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Buzztrax/buzzmachines
    REF f3fd7c751978932d08c2c37156b02aba1c068988
    SHA512 77f7c3ff609dd885ce8c661cb88791e34a26e9f2d823e007b3a3f1742f310e9e907d72855c2684bb84c8742f5b09b2a43f08e6a66504a190bfbc6de11bd0d5fc
    HEAD_REF master
)

file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH}/common)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}/common
    PREFER_NINJA
)

vcpkg_install_cmake()
vcpkg_copy_pdbs()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

file(INSTALL ${SOURCE_PATH}/common/dsplib.h DESTINATION ${CURRENT_PACKAGES_DIR}/include)

# Handle copyright
file(WRITE ${CURRENT_PACKAGES_DIR}/share/buzz-dsplib/copyright "Public Domain")
