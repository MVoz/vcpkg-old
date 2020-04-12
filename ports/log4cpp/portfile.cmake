include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://sourceforge.net/projects/log4cpp/files/log4cpp-1.1.x%20%28new%29/log4cpp-1.1/log4cpp-1.1.3.tar.gz/download"
    FILENAME "log4cpp-1.1.3.tar.gz"
    SHA512 88e5e10bce8d7d6421c3dcf14aa25385159c4ae52becdc1f3666ab86e1ad3f633786d82afe398c517d4faaa57b3e7b7c0b524361d81c6b9040dbded5cecc19de
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
#    DISABLE_PARALLEL_CONFIGURE
    OPTIONS_DEBUG # automatic templates
        -DDISABLE_INSTALL_HEADERS=ON # automatic templates
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/COPYING ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
