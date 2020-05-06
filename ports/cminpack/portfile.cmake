include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/devernay/cminpack/archive/fd2eafc929b3abc85ef262c94f00769b91ae64c2.zip"
    FILENAME "cminpack.zip"
    SHA512 2b4a5a8d666e052df1551f47858fa7c2c7210f026fb530d863fca095df4443a96ed2a936cb11d2ca5aca6d59e4ad011ca6197398400cbb135ff2bd5bd086047e
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

#set(VCPKG_FORTRAN_ENABLED ON)
#vcpkg_enable_fortran(intel)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates
    OPTIONS 
      -DBUILD_EXAMPLES:BOOL=OFF
      -DBUILD_EXAMPLES_FORTRAN:BOOL=OFF
#      -DINTEL_COMPILER_DIR:STRING=
#      -DINTEL_MKL_DIR:STRING=
#      -DINTEL_MKL_SEQUENTIAL:BOOL=OFF
      -DUSE_BLAS:BOOL=ON
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
###
