include(vcpkg_common_functions)

vcpkg_from_github(OUT_SOURCE_PATH SOURCE_PATH
    REPO "dtschump/CImg"
<<<<<<< HEAD
    REF v.2.6.1
    HEAD_REF master
    SHA512 06efe9e2f79a6564f5161da73c3b42ed456a503fd18aa1b9803a9093807656a0095e4020d032d9390718cf97e260beafb5ff82d1dba8a1c3b7bb1e2992273c88)
=======
    REF v.2.5.7
    HEAD_REF master
    SHA512 d74dd4d8996ab11a6c872450b2c3f37d3d6699d06c77894c8943829c305678e459a740688d9fae251b23e34fc264fea3948b77d5c7a6ff1d0e908003bc963b90)
>>>>>>> [many ports] Updates 2019.04.19 (#6155)

file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH})

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
)

vcpkg_install_cmake()

# Move cmake files, ensuring they will be 3 directories up the import prefix
file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/share/cimg)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug)

file(INSTALL ${SOURCE_PATH}/Licence_CeCILL-C_V1-en.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/cimg RENAME copyright)
file(INSTALL ${SOURCE_PATH}/Licence_CeCILL_V2-en.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/cimg RENAME copyright2)
