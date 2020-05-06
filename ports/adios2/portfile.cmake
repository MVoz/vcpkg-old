include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/ornladios/ADIOS2/archive/dc5664272fd817444cc7d155c88b840c98deba39.zip"
    FILENAME "dc5664272fd817444cc7d155c88b840c98deba39.zip"
    SHA512 e2a6fd20d1be1f1335550621bcca675b65a0115cb4f39515e56f4c53db604062e213fceb290ebe210d22b2c5e49484b6126741f004a184c5e930587a2bb766b9
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

set(VCPKG_FORTRAN_ENABLED ON)
vcpkg_enable_fortran(intel)

vcpkg_find_acquire_program(PYTHON3)
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
get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
#get_filename_component(DOXYGEN_DIR "${DOXYGEN}" DIRECTORY)
#get_filename_component(XGETTEXT_DIR "${XGETTEXT}" DIRECTORY)
#get_filename_component(TEXLIVE_DIR "${TEXLIVE}" DIRECTORY)
#set(ENV{PATH} ";$ENV{PATH};${QT5_DIR};${PYTHON3_DIR};${DOXYGEN_DIR};${XGETTEXT_DIR};${TEXLIVE_DIR};${FLEX_DIR};${BISON_DIR};${DOXYGEN_DIR};${PERL_DIR}")
#vcpkg_find_acquire_program(YASM)
#get_filename_component(YASM_EXE_PATH ${YASM} DIRECTORY)
#set(ENV{PATH} "$ENV{PATH};${PYTHON3_DIR}")

get_filename_component(GIT_EXE_PATH ${GIT} DIRECTORY)
set(SH_EXE_PATH "${GIT_EXE_PATH}/../usr/bin")
set(ENV{PATH} "$ENV{PATH};${PYTHON3_DIR};${SH_EXE_PATH}")

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates

    OPTIONS 
      -DADIOS2_BUILD_EXAMPLES=OFF
      -DADIOS2_BUILD_EXAMPLES_EXPERIMENTAL=OFF
      -DADIOS2_BUILD_TESTING=OFF
#      -DADIOS2_USE_BZip2=AUTO
#      -DADIOS2_USE_Blosc=AUTO
#      -DADIOS2_USE_DataMan=AUTO
#      -DADIOS2_USE_DataSpaces=AUTO
      -DADIOS2_USE_EXTERNAL_ATL=OFF
      -DADIOS2_USE_EXTERNAL_DILL=OFF
      -DADIOS2_USE_EXTERNAL_ENET=OFF
      -DADIOS2_USE_EXTERNAL_FFS=OFF
#      -DADIOS2_USE_Endian_Reverse=AUTO
      -DADIOS2_USE_Fortran=OFF
      -DADIOS2_USE_HDF5=OFF
#      -DADIOS2_USE_MGARD=AUTO
      -DADIOS2_USE_MPI=OFF
#      -DADIOS2_USE_PNG=AUTO
      -DADIOS2_USE_Profiling=OFF
      -DADIOS2_USE_Python=OFF
#      -DADIOS2_USE_SSC=AUTO
#      -DADIOS2_USE_SST=AUTO
#      -DADIOS2_USE_SZ=AUTO
#      -DADIOS2_USE_SysVShMem=AUTO
#      -DADIOS2_USE_ZFP=AUTO
#      -DADIOS2_USE_ZeroMQ=AUTO
#      -DBLOSC_INCLUDE_DIR:PATH=E:/tools/vcpkg/installed/x64-windows/include
#      -DBLOSC_LIBRARY:FILEPATH=E:/tools/vcpkg/installed/x64-windows/lib/blosc.lib
#      -DDATASPACES_INCLUDE_DIR:PATH=DATASPACES_INCLUDE_DIR-NOTFOUND
#      -DDIFF_EXECUTABLE:FILEPATH=E:/tools/Bin/diff.exe
#      -DDSPACES_CONF:FILEPATH=DSPACES_CONF-NOTFOUND
#      -DDSPACES_LIBRARY:FILEPATH=DSPACES_LIBRARY-NOTFOUND
#      -DHDF5_DIR:PATH=E:/tools/vcpkg/installed/x64-windows/cmake
      -DINSTALL_GTEST=OFF
#      -DMGARD_INCLUDE_DIR:PATH=MGARD_INCLUDE_DIR-NOTFOUND
#      -DMGARD_LIBRARY:FILEPATH=MGARD_LIBRARY-NOTFOUND
      -DPYBIND11_INSTALL=OFF
#      -DPYBIND11_PYTHON_VERSION=
      -DPYBIND11_TEST=OFF
#      -DPython_ADDITIONAL_VERSIONS=3;2.7
#      -DSZ_INCLUDE_DIR:PATH=SZ_INCLUDE_DIR-NOTFOUND
#      -DSZ_LIBRARY:FILEPATH=SZ_LIBRARY-NOTFOUND
      -DUSE_PYTHON_INCLUDE_DIR=OFF
#      -DZFP_INCLUDE_DIR:PATH=E:/tools/vcpkg/installed/x64-windows/include
#      -DZFP_LIBRARY:FILEPATH=E:/tools/vcpkg/installed/x64-windows/lib/zfp.lib
#      -DZLIB_LIBRARY:FILEPATH=E:/tools/vcpkg/installed/x64-windows/lib/z.lib
#      -DZSTD_LIBRARY:FILEPATH=E:/tools/vcpkg/installed/x64-windows/lib/zstd.lib
#      -DZeroMQ_INCLUDE_DIR:PATH=E:/tools/vcpkg/installed/x64-windows/include
#      -DZeroMQ_LIBRARY:FILEPATH=ZeroMQ_LIBRARY-NOTFOUND
      -Dgtest_build_samples=OFF
      -Dgtest_build_tests=OFF
      -Dgtest_disable_pthreads=OFF
      -Dgtest_hide_internal_symbols=OFF
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
