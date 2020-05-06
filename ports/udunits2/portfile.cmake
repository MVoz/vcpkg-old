include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "ftp://ftp.unidata.ucar.edu/pub/udunits/udunits-2.2.26.tar.gz"
    FILENAME "udunits-2.2.26.tar.gz"
    SHA512 9e5320454646458ac40ba0855b6b8e12f7edbdb4b9a6c687a4c38ad07400e2e0c0f7968069885f83eb73da64886e1c6dd1e462ebc23205df849c3a460cedb640
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
