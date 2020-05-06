include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "http://files.salome-platform.org/Salome/other/med-4.0.0.tar.gz"
    FILENAME "med-4.0.0.tar.gz"
    SHA512 2840437010481fc5f12a56e3282f8ca5e94df541899e2b511756702f86d0f87dbf2f6e086d8e591e2bd370d8f4bab8089e7f7f939fea16354a23e2b5a4d96cd7
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

#set(VCPKG_FORTRAN_ENABLED ON)
#vcpkg_enable_fortran(intel)

#vcpkg_find_acquire_program(PYTHON3)
#get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
#set(ENV{PATH} "$ENV{PATH};${PYTHON3_DIR}")

#export HDF5_ROOT_DIR=$PLAT_THIRD_PARTY_DIR/hdf5
#export MPI_ROOT_DIR=$PLAT_THIRD_PARTY_DIR/openmpi
#export OPTIONS="-DCMAKE_INSTALL_PREFIX=$INSTALL_PLAT_PKG_DIR/
#      -DCMAKE_CXX_COMPILER=$PLAT_THIRD_PARTY_DIR/openmpi/bin/mpicxx  
#      -DCMAKE_C_COMPILER=$PLAT_THIRD_PARTY_DIR/openmpi/bin/mpicc   
#      -DCMAKE_Fortran_COMPILER=$PLAT_THIRD_PARTY_DIR/openmpi/bin/mpif90 "

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates

    OPTIONS 
#      -DHDF5_ROOT_DIR:PATH=
      -DMEDFILE_BUILD_DOC=OFF
      -DMEDFILE_BUILD_PYTHON=OFF
      -DMEDFILE_BUILD_TESTS=OFF
      -DMEDFILE_INSTALL_DOC=OFF
      -DMEDFILE_USE_MPI=OFF
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/COPYING ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
