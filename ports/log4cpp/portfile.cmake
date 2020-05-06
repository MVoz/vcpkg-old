include(vcpkg_common_functions)

if(VCPKG_CMAKE_SYSTEM_NAME MATCHES "WindowsStore")
    message(FATAL_ERROR "${PORT} does not currently support UWP.")
endif()

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO orocos-toolchain/log4cpp
    REF v2.9.1
    SHA512 5bd222c820a15c5d96587ac9fe864c3e2dc0fbce8389692be8dd41553ac0308002ad8d6f4ef3ef10af1d796f8ded410788d1a5d22f15505fac639da3f73e3518
    HEAD_REF master
    PATCHES
        fix-install-targets.patch
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
)

vcpkg_install_cmake()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
vcpkg_fixup_cmake_targets(CONFIG_PATH lib/pkgconfig TARGET_PATH share/${PORT})
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)

if(VCPKG_LIBRARY_LINKAGE STREQUAL static)
    file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin ${CURRENT_PACKAGES_DIR}/debug/bin)
endif()

vcpkg_copy_pdbs()

# Handle copyright
file(COPY ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT})
file(RENAME ${CURRENT_PACKAGES_DIR}/share/${PORT}/COPYING ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright)
