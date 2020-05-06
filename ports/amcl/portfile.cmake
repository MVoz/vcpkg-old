include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/BadgerTechnologies/amcl/archive/8a8873533e84b3894a5f385b1d56234ebbe31d7e.zip"
    FILENAME "8a8873533e84b3894a5f385b1d56234ebbe31d7e.zip"
    SHA512 abe95c756eb69403c082aba6c23785a2619ecbdaa357a28ac44554717a67462cbd4dd9a80f8ad88a3be638f8585c883f39e824531f9467ab5d4571a252ac7886
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_find_acquire_program(PYTHON3)
get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
set(PYTHON3_SCRIPTS "${PYTHON3_DIR}/Scripts")
set(ENV{PATH} "$ENV{PATH};${PYTHON3_DIR};${PYTHON3_SCRIPTS}")

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates
	DISABLE_PARALLEL_CONFIGURE # ERROR - The process cannot access the file because it is being used by another process.
    OPTIONS 
	  -DCATKIN_ENABLE_TESTING=OFF
	  -DNOSETESTS:FILEPATH=${PYTHON3_DIR}/Scripts/nosetests.exe
	  -DPYTHON_VERSION=3.7
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
