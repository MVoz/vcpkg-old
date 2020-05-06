include(vcpkg_common_functions)

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_gitlab(
    GITLAB_URL https://gitlab.com
    OUT_SOURCE_PATH SOURCE_PATH
    REPO conradsnicta/armadillo-code
    REF 21fb611656796b52c7e2821d59ce54e5279a9356
    SHA512 fb7c13d27df19aa117d745bd7dd475a47e168beb90c9ae1038e7a3a89c9efddbe40e7aad21091ba266c57f1fdab44efb235c26e8392ab3240f1225a9fc463c28
    HEAD_REF 9.600.x
)

set(VCPKG_FORTRAN_ENABLED ON)
vcpkg_enable_fortran(intel)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DDETECT_HDF5=TRUE
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(CONFIG_PATH share/Armadillo/CMake TARGET_PATH share/armadillo)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE.txt ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###