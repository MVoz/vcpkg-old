include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://gitlab.linphone.org/BC/public/bcunit/-/archive/5b954d9b60a3a6c0f2e2c2d5fb874f78fa45d9bb/bcunit-5b954d9b60a3a6c0f2e2c2d5fb874f78fa45d9bb.tar.gz"
    FILENAME "bcunit.tar.gz"
    SHA512 512541b5027eb4bd495f84fd67d696bfa1f1a56c3d4b2db6df3e5066929ea6072b3861b0fedd788bbcca4096d94ad9a1448d35cee3b5319f1f85b221cd50ec1a
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
      -DENABLE_AUTOMATED=ON
      -DENABLE_BASIC=ON
      -DENABLE_CONSOLE=ON
      -DENABLE_CURSES=OFF
      -DENABLE_DEPRECATED=OFF
      -DENABLE_DOC=OFF
      -DENABLE_EXAMPLES=OFF
      -DENABLE_MEMTRACE=OFF
      -DENABLE_SHARED=ON
      -DENABLE_STATIC=OFF
      -DENABLE_TEST=OFF
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/COPYING ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
