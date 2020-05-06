include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/STEllAR-GROUP/phylanx/archive/4a28c3321b260934bcbfe7ed1bee5bf648f54d52.zip"
    FILENAME "phylanx.zip"
    SHA512 b11681620c882a16b9501c5fc4baf0169c3a981dc503b6c3de3e724a03a8247ba75443414c816b6c89310dcefa219e9f1a370653d086873c3f1556e48846568c
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

set(VCPKG_FORTRAN_ENABLED ON)
vcpkg_enable_fortran(intel)

vcpkg_find_acquire_program(PYTHON3)
get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
set(ENV{PATH} "$ENV{PATH};${PYTHON3_DIR}")

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
#    PREFER_NINJA # Windows ERROR
    NO_CHARSET_FLAG # automatic templates

    OPTIONS 
      -DHPX_DIR=${CURRENT_INSTALLED_DIR}/share/hpx
	  -DBUILD_TESTING=OFF
#	  -DHPX_Fortran_COMPILER=ifort
#	  -DHPX_Fortran_COMPILER_ID=Intel
#	  -DHPX_Fortran_COMPILER_VERSION:STRING=
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE_1_0.txt ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
