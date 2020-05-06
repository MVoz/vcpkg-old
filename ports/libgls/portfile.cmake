include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/marlam/libgls-mirror/archive/1e202b8112245c956ef91ba54d680983e94d1f05.zip"
    FILENAME "libgls.zip"
    SHA512 aba9893fc0cfc80cd08460fc1d41390722fb525bbe0aafe52229b3e0e3945046c5460416245b1bd8e4f75ac1e30768ee83151401f341054720fe59e59842d9a0
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "dynamic" ENABLE_SHARED_LIBS)
string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "static"  ENABLE_STATIC_LIBS)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS 
      -DGLS_BUILD_SHARED_LIB=${ENABLE_SHARED_LIBS}
      -DGLS_BUILD_STATIC_LIB=${ENABLE_STATIC_LIBS}
      -DGLS_BUILD_TEST=OFF
	  -DGLS_BUILD_DOCUMENTATION=OFF
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/COPYING ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
