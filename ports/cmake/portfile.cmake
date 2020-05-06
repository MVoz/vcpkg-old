include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/scikit-build/cmake-python-distributions/archive/aa9a0fd10838be4de6112a953924a183fec44c2a.zip"
    FILENAME "cmake-build.zip"
    SHA512 0c5fbb246a0e0866fead9e66d5c718d830b6ef9189c0354dd9fe980ba65d60bafbb50b9ab8c8119649f9c97fa6e7fe5152c4204bc14567012ebb443c403ffc4b
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_find_acquire_program(PYTHON3)
get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
set(ENV{PATH} "$ENV{PATH};${YASM_EXE_PATH}")

#python setup.py bdist_wheel -- -DBUILD_CMAKE_FROM_SOURCE:BOOL=ON
vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates

    OPTIONS 
      -DBUILD_CMAKE_FROM_SOURCE:BOOL=ON
	  -DBUILD_VERBOSE:BOOL=1
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE_BSD_3 ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
