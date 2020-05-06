include(vcpkg_common_functions)

#vcpkg_check_linkage(ONLY_STATIC_LIBRARY)
#http://visit.ilight.com/svn/visit/trunk/third_party/moab-4.9.2-RC0.tar.gz
#    URLS "https://bitbucket.org/fathomteam/moab/get/5.1.0.tar.gz"
vcpkg_download_distfile(ARCHIVE
    URLS "https://bitbucket.org/fathomteam/moab/get/ef8e6de260ea.zip"
    FILENAME "moab.zip"
    SHA512 f73efeec4080903b9c45eb4d788697c05c419448d73b1335f5d47f59a98073aaaa4c1c7abd731db9022e7f28e829c054798e63c6c2ea1619665affecd0e5972a
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

#set(VCPKG_FORTRAN_ENABLED ON)
#vcpkg_enable_fortran(intel)

#vcpkg_find_acquire_program(PYTHON3)
#vcpkg_find_acquire_program(QT5)
#vcpkg_find_acquire_program(TEXLIVE)
#vcpkg_find_acquire_program(XGETTEXT)
#vcpkg_find_acquire_program(DOXYGEN)
#vcpkg_find_acquire_program(DOXYGEN)
#vcpkg_find_acquire_program(PERL)
#vcpkg_find_acquire_program(FLEX)
#vcpkg_find_acquire_program(BISON)
#get_filename_component(FLEX_DIR "${FLEX}" DIRECTORY)
#get_filename_component(BISON_DIR "${BISON}" DIRECTORY)
#get_filename_component(DOXYGEN_DIR "${DOXYGEN}" DIRECTORY)
#get_filename_component(PERL_DIR "${PERL}" DIRECTORY)
#get_filename_component(QT5_DIR "${QT5}" DIRECTORY)
#get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
#get_filename_component(DOXYGEN_DIR "${DOXYGEN}" DIRECTORY)
#get_filename_component(XGETTEXT_DIR "${XGETTEXT}" DIRECTORY)
#get_filename_component(TEXLIVE_DIR "${TEXLIVE}" DIRECTORY)
#set(ENV{PATH} ";$ENV{PATH};${QT5_DIR};${PYTHON3_DIR};${DOXYGEN_DIR};${XGETTEXT_DIR};${TEXLIVE_DIR};${FLEX_DIR};${BISON_DIR};${DOXYGEN_DIR};${PERL_DIR}")
#vcpkg_find_acquire_program(YASM)
#get_filename_component(YASM_EXE_PATH ${YASM} DIRECTORY)
#set(ENV{PATH} "$ENV{PATH};${YASM_EXE_PATH}")

find_program(GIT NAMES git git.cmd)
get_filename_component(GIT_EXE_PATH ${GIT} DIRECTORY)
set(SH_EXE_PATH "${GIT_EXE_PATH}/../usr/bin")
set(ENV{PATH} "$ENV{PATH};${SH_EXE_PATH}")

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates

    OPTIONS 
      -DENABLE_BLASLAPACK=ON
      -DENABLE_CGM=ON
      -DENABLE_CGNS=ON
      -DENABLE_FBIGEOM=ON
      -DENABLE_FORTRAN=OFF
      -DENABLE_HDF5=ON
      -DENABLE_IMESH=ON
      -DENABLE_IREL=ON
      -DENABLE_MESQUITE=ON
      -DENABLE_METIS=ON
      -DENABLE_MPI=ON
      -DENABLE_NETCDF=OFF
      -DENABLE_PARMETIS=ON
      -DENABLE_PNETCDF=OFF
      -DENABLE_PYMOAB=OFF
      -DENABLE_SZIP=ON
      -DENABLE_TESTING=OFF
      -DENABLE_VTK=OFF
      -DENABLE_ZLIB=ON
      -DENABLE_ZOLTAN=OFF
#      -DGZIP:FILEPATH=E:/tools/Bin/BusyBox/gzip.exe
      -DMOAB_BUILD_HEXMODOPS=ON
      -DMOAB_BUILD_MBCONVERT=ON
      -DMOAB_BUILD_MBCOUPLER=ON
      -DMOAB_BUILD_MBDEPTH=ON
      -DMOAB_BUILD_MBGSETS=ON
      -DMOAB_BUILD_MBHONODES=ON
      -DMOAB_BUILD_MBMEM=ON
      -DMOAB_BUILD_MBPART=OFF
      -DMOAB_BUILD_MBQUALITY=ON
      -DMOAB_BUILD_MBSIZE=ON
      -DMOAB_BUILD_MBSKIN=ON
      -DMOAB_BUILD_MBSLAVEPART=ON
      -DMOAB_BUILD_MBSURFPLOT=ON
      -DMOAB_BUILD_MBTAGPROP=ON
      -DMOAB_BUILD_MBTEMPEST=OFF
      -DMOAB_BUILD_MBUMR=ON
      -DMOAB_BUILD_SPHEREDECOMP=ON
#      -DSED:FILEPATH=E:/tools/Bin/sed.exe
#      -DTAR:FILEPATH=E:/tools/Bin/BusyBox/tar.exe
#      -DZCAT_EXE:FILEPATH=E:/tools/Bin/BusyBox/zcat.exe
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
