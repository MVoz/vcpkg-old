include(vcpkg_common_functions)

if(VCPKG_CMAKE_SYSTEM_NAME STREQUAL "WindowsStore")
    message(FATAL_ERROR "Abseil currently only supports being built for desktop")
endif()

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO abseil/abseil-cpp
<<<<<<< HEAD
    REF aa468ad75539619b47979911297efbb629c52e44
    SHA512 4254d8599103d8f06b03f60a0386eba07f314184217d0bca404d41fc0bd0a8df287fe6d07158d10cde096af3097aff2ecc1a5e8f7c3046ecf956b5fde709ad1d
=======
    REF d902eb869bcfacc1bad14933ed9af4bed006d481
    SHA512 660a6cc6250460b6d76e0fd3a0193bf41e69bf6a95361d2f0562b00cf4cb4a36fe0b07e1172faba190743d1b3a3dc96b834a080cdaded3cbdea2fc0392094cde
>>>>>>> [many ports] Updates 2019.04.19 (#6155)
    HEAD_REF master
    PATCHES fix-usage-lnk-error.patch
)

file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH})

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(CONFIG_PATH share/unofficial-abseil TARGET_PATH share/unofficial-abseil)

vcpkg_copy_pdbs()

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/abseil RENAME copyright)
