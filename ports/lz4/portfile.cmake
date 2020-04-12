include(vcpkg_common_functions)
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO lz4/lz4
<<<<<<< HEAD
    REF v1.9.1
    SHA512 536cdeb6dd73b4769cf9501ad312b004ab01699758534b47ca2eddbc815fd374a3caba40cde36f73a7a70e134065836b733e2b0c023c31740b877ef9317ccf3e
=======
    REF v1.9.0
    SHA512 f9e78df262818192800157d6ed64d42c06e918062afc93e3098d00f5f49fd3279b5709486a7d8841708a4ce1c539381225f0813e6a342f49d13b576eb61eb444
>>>>>>> [many ports] Updates 2019.04.19 (#6155)
    HEAD_REF dev)

file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH})

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS_DEBUG
        -DLZ4_SKIP_INCLUDES=ON
)

vcpkg_install_cmake()
vcpkg_copy_pdbs()

foreach(FILE lz4.h lz4frame.h)
    file(READ ${CURRENT_PACKAGES_DIR}/include/${FILE} LZ4_HEADER)
    if(VCPKG_LIBRARY_LINKAGE STREQUAL "dynamic")
        string(REPLACE "defined(LZ4_DLL_IMPORT) && (LZ4_DLL_IMPORT==1)" "1" LZ4_HEADER "${LZ4_HEADER}")
    else()
        string(REPLACE "defined(LZ4_DLL_IMPORT) && (LZ4_DLL_IMPORT==1)" "0" LZ4_HEADER "${LZ4_HEADER}")
    endif()
    file(WRITE ${CURRENT_PACKAGES_DIR}/include/${FILE} "${LZ4_HEADER}")
endforeach()

file(COPY ${SOURCE_PATH}/lib/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/lz4)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/lz4/LICENSE ${CURRENT_PACKAGES_DIR}/share/lz4/copyright)
