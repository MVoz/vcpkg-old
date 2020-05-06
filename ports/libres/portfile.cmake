include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/equinor/libres/archive/eb8a93b0d6b2b770720d5c273b2647b781f6c655.zip"
    FILENAME "eb8a93b0d6b2b770720d5c273b2647b781f6c655.zip"
    SHA512 80395e2c84d61f1abfb0091fdfc4d9d9137b68ad1a9be804aac75ddc5fc50b4b109d317d142322233cce7f266e1c8f35fb22f847b39466556919542f7508a43a
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_find_acquire_program(PYTHON2)
get_filename_component(PYTHON2_DIR "${PYTHON2}" DIRECTORY)
set(ENV{PATH} "$ENV{PATH};${PYTHON2_DIR}")

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates
    OPTIONS 
      -DBUILD_APPLICATIONS=OFF
	  -DERT_BUILD_CXX=ON
      -DBUILD_PYTHON=OFF
      -DBUILD_TESTING=OFF
      -DBUILD_TESTS=OFF
      -DENABLE_PYTHON=ON	  
#      -DEQUINOR_TESTDATA_ROOT:PATH=
#      -DERT_LSF_INCLUDE_PATH:FILEPATH=
#      -DERT_LSF_LIB_PATH:FILEPATH=
#      -DERT_LSF_SUBMIT_TEST:BOOL=OFF
#      -DINSTALL_ERT_LEGACY:BOOL=OFF
#      -DINSTALL_GROUP:STRING=
#      -DLSF_HEADER_PATH:PATH=LSF_HEADER_PATH-NOTFOUND
#      -DLSF_LIBRARY:FILEPATH=LSF_LIBRARY-NOTFOUND
#      -DPYTHON_INSTALL_PREFIX:STRING=lib/python3.7/site-packages
#      -DSITE_CONFIG_FILE:FILEPATH=
      -DUSE_RPATH=OFF
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/COPYING ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
