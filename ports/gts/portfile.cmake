include(vcpkg_common_functions)

vcpkg_check_linkage(ONLY_DYNAMIC_LIBRARY ONLY_DYNAMIC_CRT)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO  finetjul/gts
    REF c4da61ae075f355d9ecc9f2d4767acf777f54c2b
    SHA512 e53d11213c26cbda08ae62e6388aee0a14d2884de72268ad25d10a23e77baa53a2b1151c5cc7643b059ded82b8edf0da79144c3108949fdc515168cac13ffca9
    HEAD_REF master
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
)

vcpkg_install_cmake()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

# Handle copyright
file(INSTALL ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/gts RENAME copyright)

vcpkg_copy_pdbs()
