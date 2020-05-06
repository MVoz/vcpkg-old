include(vcpkg_common_functions)

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO OctoMap/octomap
    REF c921775fbe57980048309c086afa20a0b5a895fe
    SHA512 cccbf133158af02ac621552e2c7242ce8af9db00c69856b0f18e88c3e6da3839074404ec178338db6db378e12d184234c0339ce5c0934e97edfbbe68391029a2
    HEAD_REF master
    PATCHES
      "001-fix-exported-targets.patch"
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    DISABLE_PARALLEL_CONFIGURE
    OPTIONS
        -DBUILD_OCTOVIS_SUBPROJECT=OFF
        -DBUILD_DYNAMICETD3D_SUBPROJECT=OFF
)

vcpkg_install_cmake()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/tools/octomap)
if(NOT VCPKG_CMAKE_SYSTEM_NAME OR VCPKG_CMAKE_SYSTEM_NAME STREQUAL "WindowsStore")
  file(RENAME ${CURRENT_PACKAGES_DIR}/bin/binvox2bt.exe ${CURRENT_PACKAGES_DIR}/tools/octomap/binvox2bt.exe)
  file(RENAME ${CURRENT_PACKAGES_DIR}/bin/bt2vrml.exe ${CURRENT_PACKAGES_DIR}/tools/octomap/bt2vrml.exe)
  file(RENAME ${CURRENT_PACKAGES_DIR}/bin/compare_octrees.exe ${CURRENT_PACKAGES_DIR}/tools/octomap/compare_octrees.exe)
  file(RENAME ${CURRENT_PACKAGES_DIR}/bin/convert_octree.exe ${CURRENT_PACKAGES_DIR}/tools/octomap/convert_octree.exe)
  file(RENAME ${CURRENT_PACKAGES_DIR}/bin/edit_octree.exe ${CURRENT_PACKAGES_DIR}/tools/octomap/edit_octree.exe)
  file(RENAME ${CURRENT_PACKAGES_DIR}/bin/eval_octree_accuracy.exe ${CURRENT_PACKAGES_DIR}/tools/octomap/eval_octree_accuracy.exe)
  file(RENAME ${CURRENT_PACKAGES_DIR}/bin/graph2tree.exe ${CURRENT_PACKAGES_DIR}/tools/octomap/graph2tree.exe)
  file(RENAME ${CURRENT_PACKAGES_DIR}/bin/log2graph.exe ${CURRENT_PACKAGES_DIR}/tools/octomap/log2graph.exe)

  file(REMOVE ${CURRENT_PACKAGES_DIR}/debug/bin/binvox2bt.exe)
  file(REMOVE ${CURRENT_PACKAGES_DIR}/debug/bin/bt2vrml.exe)
  file(REMOVE ${CURRENT_PACKAGES_DIR}/debug/bin/compare_octrees.exe)
  file(REMOVE ${CURRENT_PACKAGES_DIR}/debug/bin/convert_octree.exe)
  file(REMOVE ${CURRENT_PACKAGES_DIR}/debug/bin/edit_octree.exe)
  file(REMOVE ${CURRENT_PACKAGES_DIR}/debug/bin/eval_octree_accuracy.exe)
  file(REMOVE ${CURRENT_PACKAGES_DIR}/debug/bin/graph2tree.exe)
  file(REMOVE ${CURRENT_PACKAGES_DIR}/debug/bin/log2graph.exe)
else()
  file(RENAME ${CURRENT_PACKAGES_DIR}/bin ${CURRENT_PACKAGES_DIR}/tools/octomap)
  file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/bin)
endif()

vcpkg_fixup_cmake_targets()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)

if(VCPKG_LIBRARY_LINKAGE STREQUAL static)
  file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin ${CURRENT_PACKAGES_DIR}/debug/bin)
endif()

file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/vcpkg-cmake-wrapper.cmake" DESTINATION "${CURRENT_PACKAGES_DIR}/share/octomap")

# Handle copyright
file(COPY ${SOURCE_PATH}/octomap/LICENSE.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/octomap)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/octomap/LICENSE.txt ${CURRENT_PACKAGES_DIR}/share/octomap/copyright)

vcpkg_copy_pdbs()
vcpkg_copy_tool_dependencies(${CURRENT_PACKAGES_DIR}/tools/octomap)
