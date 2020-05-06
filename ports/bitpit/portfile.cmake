include(vcpkg_common_functions)
vcpkg_enable_fortran(Intel)
vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/optimad/bitpit/archive/dee1f5f7aa27e6d1fbcc3ca227520ca18fe4d955.zip"
    FILENAME "dee1f5f7aa27e6d1fbcc3ca227520ca18fe4d955.zip"
    SHA512 1413b154f2e98b1b6e6578e52139ae59cb6140885b081691fb27359ca6e83c7e83a46dff0333500cdaf083801eb80246d0402a12147c3fe7b46e3a8ade2600df
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE} 
)
set(BLA_VENDOR OpenBLAS)
vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
	OPTIONS
		-DENABLE_MPI=0
		-DLAPACKE_STATIC=1
		-DBLA_VENDOR=OpenBLAS
		-DLAPACKE_DIR=${CURRENT_INSTALLED_DIR}
		-DLAPACK_LIBRARIES=${CURRENT_INSTALLED_DIR}/lib/lapack.lib
		-DBLAS_LIBRARIES=${CURRENT_INSTALLED_DIR}/lib/blas.lib
	OPTIONS_DEBUG
		-DLAPACK_LIBRARIES=${CURRENT_INSTALLED_DIR}/debug/lib/lapack.lib
		-DBLAS_LIBRARIES=${CURRENT_INSTALLED_DIR}/debug/lib/blas.lib
		
    # OPTIONS -DUSE_THIS_IN_ALL_BUILDS=1 -DUSE_THIS_TOO=2
    # OPTIONS_RELEASE -DOPTIMIZE=1
    # OPTIONS_DEBUG -DDEBUGGABLE=1
)

vcpkg_install_cmake()

# Handle copyright
# file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/bitpit RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME bitpit)
