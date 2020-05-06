include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://users.nccs.gov/~pnorbert/adios-1.13.1.tar.gz"
    URLS "http://visit.ilight.com/svn/visit/trunk/third_party/adios-1.13.1.tar.gz"
    FILENAME "adios-1.13.tar.gz"
    SHA512 ddba83e2eaa9dffd386237c1aa1d615f2d1ac8d723b50f10307d3bbe2f6aaf7fcdbead96b5385576e9bd262344bd8f6a8a5cad178d36c533bc1253b3e5bc0a39
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
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates

    OPTIONS 
#      -DBGQ=OFF
      -DBUILD_FORTRAN=OFF
      -DBUILD_WRITE=ON
      -DBUILD_ZFP=OFF
      -DCRAY_PMI=OFF
      -DCRAY_UGNI=OFF
#      -DDATASPACES=OFF
#      -DDATATAP=OFF
#      -DDIMES=OFF
#      -DDMALLOC=OFF
#      -DFGR=OFF
#      -DFLEXPATH=OFF
      -DHDF5=OFF
#      -DLUSTRE=OFF
#      -DMXML_DIR:FILEPATH=
#      -DM_LIBS:FILEPATH=M_LIBS-NOTFOUND
#      -DNC4PAR=OFF
      -DNETCDF=OFF
#      -DNSSI=OFF
#      -DPHDF5=OFF
#      -DPORTALS=OFF
      -DZFP=ON
      -DZLIB=ON
      -DLZ4=ON
#      -DBLOSC=ON
      -DBZIP2=ON
	  -DGLIB=ON
#      -DSZIP=ON
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
