include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/scikit-build/ninja-python-distributions/archive/4ff7559a2720da415db6df5e1523d67b111147f0.zip"
    FILENAME "ninja-build.zip"
    SHA512 fa98c551c889a255a46e7735bc468be900c1f8bd2e55de31fb60a588b71e075f2e9ed6afd3a8b00f455be32cf8dd926573044710f384216ab5bb62a0c3bf6d81
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_find_acquire_program(PYTHON3)
get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
set(ENV{PATH} "$ENV{PATH};${PYTHON3_DIR}")

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates

#    OPTIONS 
#      -D =OFF # automatic templates
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE_Apache_20 ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
