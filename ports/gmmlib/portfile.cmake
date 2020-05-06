include(vcpkg_common_functions)

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/intel/gmmlib/archive/b20e484a5b4c002bfba40d7464bc9e67fbed5d28.zip"
    FILENAME "gmmlib_v.zip"
    SHA512 39d354d194aec757e949f9a0e189ca6e42eb60ca341a6ca7acbb91311e8ce1d6f81afb4d86ab8905cd07b7f00c662f363be90539289026ffc9c1a2bcaebbbf15
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS -DARCH=64
)

vcpkg_install_cmake()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

# Handle copyright
configure_file(${SOURCE_PATH}/LICENSE.md ${CURRENT_PACKAGES_DIR}/share/gmmlib/copyright COPYONLY)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/include/igdgmm/GmmLib/Scripts)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/include/igdgmm/GmmLib/Resource)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/include/igdgmm/GmmLib/GlobalInfo)
