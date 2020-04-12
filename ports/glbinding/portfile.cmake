include(vcpkg_common_functions)
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO cginternals/glbinding
    REF d7a1873ad741fb13a9c6dcbae93d0cda45a11933
    SHA512 70848d8ddad3e2ddfc54549ed3cdde569991858135140b30b50fa6e92c5aec6e3dd235418e091456f9b68da2fad09fbef117dedac7b48c26bcab62b6f0fa791f
    HEAD_REF master
    PATCHES force-system-install.patch
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
        -DOPTION_BUILD_TESTS=OFF
        -DOPTION_BUILD_GPU_TESTS=OFF
        -DOPTION_BUILD_TOOLS=OFF
        -DGIT_REV=0
        -DCMAKE_DISABLE_FIND_PACKAGE_cpplocate=ON
)

vcpkg_install_cmake()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

vcpkg_fixup_cmake_targets(CONFIG_PATH share/glbinding/cmake)

# _IMPORT_PREFIX needs to go up one extra level in the directory tree.
# These files should be modified.
#     /share/glbinding/glbinding-export.cmake 
#     /share/glbinding-aux/glbinding-aux-export.cmake
file(GLOB_RECURSE TARGET_CMAKES "${CURRENT_PACKAGES_DIR}/*-export.cmake")
foreach(TARGET_CMAKE IN LISTS TARGET_CMAKES)
    file(READ ${TARGET_CMAKE} _contents)
    string(REPLACE 
[[
get_filename_component(_IMPORT_PREFIX "${CMAKE_CURRENT_LIST_FILE}" PATH)
get_filename_component(_IMPORT_PREFIX "${_IMPORT_PREFIX}" PATH)
get_filename_component(_IMPORT_PREFIX "${_IMPORT_PREFIX}" PATH)
]]
[[
get_filename_component(_IMPORT_PREFIX "${CMAKE_CURRENT_LIST_FILE}" PATH)
get_filename_component(_IMPORT_PREFIX "${_IMPORT_PREFIX}" PATH)
get_filename_component(_IMPORT_PREFIX "${_IMPORT_PREFIX}" PATH)
get_filename_component(_IMPORT_PREFIX "${_IMPORT_PREFIX}" PATH)
]]
        _contents "${_contents}")
    file(WRITE ${TARGET_CMAKE} "${_contents}")
endforeach()

file(WRITE ${CURRENT_PACKAGES_DIR}/share/glbinding/glbinding-config.cmake "include(\${CMAKE_CURRENT_LIST_DIR}/glbinding/glbinding-export.cmake)\ninclude(\${CMAKE_CURRENT_LIST_DIR}/glbinding-aux/glbinding-aux-export.cmake)\nset(glbinding_FOUND TRUE)\n")
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)

# Handle copyright
file(RENAME ${CURRENT_PACKAGES_DIR}/share/glbinding/LICENSE ${CURRENT_PACKAGES_DIR}/share/glbinding/copyright)

vcpkg_copy_pdbs()
