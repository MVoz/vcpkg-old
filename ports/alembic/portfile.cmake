include(vcpkg_common_functions)

string(LENGTH "${CURRENT_BUILDTREES_DIR}" BUILDTREES_PATH_LENGTH)
if(BUILDTREES_PATH_LENGTH GREATER 37 AND CMAKE_HOST_WIN32)
    message(WARNING "Alembic's buildsystem uses very long paths and may fail on your system.\n"
        "We recommend moving vcpkg to a short path such as 'C:\\src\\vcpkg' or using the subst command."
    )
endif()

vcpkg_check_linkage(ONLY_DYNAMIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO alembic/alembic
    REF 1.7.10
    SHA512 e98ffaedb98dbc5c53fe9703d3063bb118d32c83c47e3af04c8fc96237034b02fe0fc2c628ca82bdd0e0ef17d9375f4f48e0022ce33380b9ad91970539611ced
    HEAD_REF master
    PATCHES
        fix-hdf5link.patch
        bypass-findhdf5.patch
        fix-C1083.patch
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
    -DUSE_HDF5=ON
    -DHDF5_ROOT=${CURRENT_INSTALLED_DIR}
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(CONFIG_PATH "lib/cmake/Alembic")

vcpkg_copy_pdbs()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)
file(GLOB EXE ${CURRENT_PACKAGES_DIR}/bin/*.exe)
file(GLOB DEBUG_EXE ${CURRENT_PACKAGES_DIR}/debug/bin/*.exe)
file(REMOVE ${EXE})
file(REMOVE ${DEBUG_EXE})
file(RENAME ${CURRENT_PACKAGES_DIR}/lib/Alembic.dll ${CURRENT_PACKAGES_DIR}/bin/Alembic.dll)
file(RENAME ${CURRENT_PACKAGES_DIR}/debug/lib/Alembic.dll ${CURRENT_PACKAGES_DIR}/debug/bin/Alembic.dll)

file(READ ${CURRENT_PACKAGES_DIR}/share/Alembic/AlembicTargets-debug.cmake DEBUG_CONFIG)
string(REPLACE "\${_IMPORT_PREFIX}/debug/lib/Alembic.dll"
               "\${_IMPORT_PREFIX}/debug/bin/Alembic.dll" DEBUG_CONFIG "${DEBUG_CONFIG}")
file(WRITE ${CURRENT_PACKAGES_DIR}/share/Alembic/AlembicTargets-debug.cmake "${DEBUG_CONFIG}")

file(READ ${CURRENT_PACKAGES_DIR}/share/Alembic/AlembicTargets-release.cmake RELEASE_CONFIG)
string(REPLACE "\${_IMPORT_PREFIX}/lib/Alembic.dll"
               "\${_IMPORT_PREFIX}/bin/Alembic.dll" RELEASE_CONFIG "${RELEASE_CONFIG}")
file(WRITE ${CURRENT_PACKAGES_DIR}/share/Alembic/AlembicTargets-release.cmake "${RELEASE_CONFIG}")

# Put the license file where vcpkg expects it
file(COPY ${SOURCE_PATH}/LICENSE.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/Alembic/)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/Alembic/LICENSE.txt ${CURRENT_PACKAGES_DIR}/share/Alembic/copyright)
