include(vcpkg_common_functions)

#http://visit.ilight.com/svn/visit/trunk/windowsbuild/thirdparty-projects/mfem-3.3/CMakeLists.txt
vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/mfem/mfem/archive/369fc7c903398a86588788cef687596dff85d56f.zip"
    FILENAME "369fc7c903398a86588788cef687596dff85d56f.zip"
    SHA512 fd85feb2e0e6a51701b89d0a754e75760b6f7c56a417ffca0afdbe90b5019e98cfbaa7f61260a12d36e57629eed166624a145400149a60b1c787e8a61d6ec6e9
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

set(VCPKG_FORTRAN_ENABLED ON)
vcpkg_enable_fortran(intel)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates
#    GENERATOR "NMake Makefiles" # automatic templates
#    DISABLE_PARALLEL_CONFIGURE
    OPTIONS_DEBUG # automatic templates
      -DDISABLE_INSTALL_HEADERS=ON # automatic templates
      -DINSTALL_HEADERS_TOOLS=OFF
      -DINSTALL_HEADERS=OFF
    OPTIONS_RELEASE 
      -DINSTALL_HEADERS=ON # automatic templates
#      -D =OFF
    OPTIONS 
#      -DAXOM_DIR:PATH=E:/tools/vcpkg/buildtrees/mfem/src/6dff85d56f-cce71b5d48/../axom
#      -DAxom_REQUIRED_PACKAGES:STRING=Conduit/relay
      -DMFEM_ENABLE_EXAMPLES=OFF
      -DMFEM_ENABLE_MINIAPPS=OFF
      -DMFEM_ENABLE_TESTING=OFF
      -DMFEM_THREAD_SAFE=OFF
      -DMFEM_USE_CONDUIT=OFF
      -DMFEM_USE_CUDA=OFF
      -DMFEM_USE_EXCEPTIONS=OFF
      -DMFEM_USE_GECKO=OFF
      -DMFEM_USE_GNUTLS=OFF
      -DMFEM_USE_GZSTREAM=OFF
      -DMFEM_USE_LAPACK=ON
      -DMFEM_USE_LEGACY_OPENMP=OFF
      -DMFEM_USE_LIBUNWIND=OFF
      -DMFEM_USE_MEMALLOC=ON
      -DMFEM_USE_MESQUITE=OFF
      -DMFEM_USE_METIS=ON
      -DMFEM_USE_MPFR=ON
      -DMFEM_USE_MPI=ON
      -DMFEM_USE_NETCDF=OFF #fatal error LNK1120: 176 unresolved externals 
      -DMFEM_USE_OCCA=OFF
      -DMFEM_USE_OPENMP=OFF
      -DMFEM_USE_PETSC=OFF
      -DMFEM_USE_PUMI=OFF
      -DMFEM_USE_RAJA=OFF
      -DMFEM_USE_SIDRE=OFF
      -DMFEM_USE_STRUMPACK=OFF #STRUMPACK_REQUIRED_PACKAGES:STRING=MPI;MPI_Fortran;ParMETIS;METIS;ScaLAPACK;Scotch
      -DMFEM_USE_SUITESPARSE=OFF #SuiteSparse_REQUIRED_PACKAGES:STRING=BLAS;METIS
      -DMFEM_USE_SUNDIALS=OFF #Sundials_REQUIRED_PACKAGES:STRING=BLAS;SuiteSparse=BLAS
      -DMFEM_USE_SUPERLU=ON
#      -DMPFR_DIR:PATH=
#      -DNETCDF_DIR:PATH=
#      -DNetCDF_REQUIRED_PACKAGES:STRING=
#      -DPETSC_ARCH:STRING=arch-linux2-c-debug
#      -DUSE_XSDK_DEFAULTS=OFF
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
