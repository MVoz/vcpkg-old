include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/Unidata/UDUNITS-2/archive/0bb56200221ad960bc2da11fc0b4a70ec3c5d7c9.zip"
    FILENAME "UDUNITS-2.zip"
    SHA512 8d6c51700a42795b36a29cfd83094d948af2177960981c39b6a7df7d09f70dcf335171564883e0d7d882a49e618f1643de3220fd0c3256f8de4811283bfcd7bf
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_find_acquire_program(FLEX)
vcpkg_find_acquire_program(BISON)
get_filename_component(FLEX_DIR "${FLEX}" DIRECTORY)
get_filename_component(BISON_DIR "${BISON}" DIRECTORY)
set(ENV{PATH} "$ENV{PATH};${BISON_DIR};${FLEX_DIR}")

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
configure_file(${SOURCE_PATH}/COPYRIGHT ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###