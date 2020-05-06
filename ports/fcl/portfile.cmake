include(vcpkg_common_functions)

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

#https://github.com/Omnirobotic/fcl/tree/Omnirobotic
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Omnirobotic/fcl
    REF 84232930ce2d0d23f47cbdc93e385a1007d969f5
    SHA512 d2d5782912fecec34235a30ea33a74c9b4e7348bcd5f819daa634342ddf14f83fe999f34a02d561bb6e0f336a9f1448c236374d0e88b4dd9c51a0c46aab0849f
    HEAD_REF fcl-0.5
)

vcpkg_apply_patches(
    SOURCE_PATH ${SOURCE_PATH}
    PATCHES
        ${CMAKE_CURRENT_LIST_DIR}/0001_fix_package_detection.patch
        ${CMAKE_CURRENT_LIST_DIR}/0002-fix_dependencies.patch)

if(VCPKG_LIBRARY_LINKAGE STREQUAL static)
    set(FCL_STATIC_LIBRARY ON)
else()
    set(FCL_STATIC_LIBRARY OFF)
endif()

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DFCL_STATIC_LIBRARY=${FCL_STATIC_LIBRARY}
        -DFCL_BUILD_TESTS=OFF
)

vcpkg_install_cmake()
vcpkg_copy_pdbs()

if(EXISTS ${CURRENT_PACKAGES_DIR}/CMake)
  vcpkg_fixup_cmake_targets(CONFIG_PATH "CMake")
else()
  vcpkg_fixup_cmake_targets(CONFIG_PATH "lib/cmake/fcl")
endif()


file(READ ${CURRENT_PACKAGES_DIR}/share/fcl/fclConfig.cmake FCL_CONFIG)
string(REPLACE "unset(_expectedTargets)"
               "unset(_expectedTargets)\n\nfind_package(octomap REQUIRED)\nfind_package(ccd REQUIRED)" FCL_CONFIG "${FCL_CONFIG}")
file(WRITE ${CURRENT_PACKAGES_DIR}/share/fcl/fclConfig.cmake "${FCL_CONFIG}")

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/fcl RENAME copyright)
