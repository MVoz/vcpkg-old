include(vcpkg_common_functions)

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/kkm000/openfst/archive/0bca6e76d24647427356dc242b0adbf3b5f1a8d9.zip"
    FILENAME "openfst.zip"
    SHA512 0eaaf01bb54b951159ccde420d6ffb7eb791a96e20b974a6e47e3a695220a34153f0c5f807863807dd6069c2758227ed77ce89c4d01ba14f7e449bbcd9951e54
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

FILE(GLOB HEADER_TEST ${SOURCE_PATH}/src/include/fst/test/*.h)
file(COPY ${HEADER_TEST} DESTINATION ${SOURCE_PATH}/src/test)

vcpkg_find_acquire_program(PYTHON3)
get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
set(ENV{PATH} "$ENV{PATH};${PYTHON3_DIR}")

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates

    OPTIONS 
      -DBUILD_TESTING=OFF
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/COPYING ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
