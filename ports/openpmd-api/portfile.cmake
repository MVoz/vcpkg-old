include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/openPMD/openPMD-api/archive/c404c296d066c4342e00a0bef9c56f9ee2d21254.zip"
    FILENAME "c404c296d066c4342e00a0bef9c56f9ee2d21254.zip"
    SHA512 f7d9755c3627be1d12d3df7798b029db83c7b20956917d0a5f7a35e3aeaf00ab835095a31227afd67bb55d1c3207fa4273a9252522792fd1efa03766366c1723
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

#set(VCPKG_FORTRAN_ENABLED ON)
#vcpkg_enable_fortran(intel)

vcpkg_find_acquire_program(PYTHON3)
get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
set(CYTHON_DIR "${PYTHON3_DIR}/Scripts")
set(ENV{PATH} "$ENV{PATH};${PYTHON3_DIR};${CYTHON_DIR}")

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
      -DBUILD_EXAMPLES=OFF
      -DBUILD_TESTING=OFF
      -DJSON_MultipleHeaders=OFF
      -DPYBIND11_INSTALL=OFF
#      -DPYBIND11_PYTHON_VERSION:STRING=
      -DPYBIND11_TEST=OFF
#      -DUSE_PYTHON_INCLUDE_DIR=OFF
      -DopenPMD_HAVE_PKGCONFIG=ON
#      -DopenPMD_USE_ADIOS1:STRING=AUTO
#      -DopenPMD_USE_ADIOS2:STRING=OFF
#      -DopenPMD_USE_HDF5:STRING=AUTO
      -DopenPMD_USE_INTERNAL_CATCH=ON
      -DopenPMD_USE_INTERNAL_JSON=ON
      -DopenPMD_USE_INTERNAL_PYBIND11=ON
#      -DopenPMD_USE_INTERNAL_VARIANT=ON
#      -DopenPMD_USE_INVASIVE_TESTS=OFF
#      -DopenPMD_USE_JSON:STRING=AUTO
#      -DopenPMD_USE_MPI:STRING=AUTO
#      -DopenPMD_USE_PYTHON:STRING=AUTO
#      -DopenPMD_USE_VERIFY=ON
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/COPYING ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
