include(vcpkg_common_functions)

#vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/CGNS/CGNS/archive/cbcc97400c4687e425b10353a969acb294c7afda.zip"
    FILENAME "CGNS.zip"
    SHA512 211bebe7a6017c71f0d94daa0481f695867ad3f0228c1c90dde52bf8fff3cbd7a02875c0dbde6b10b8f8befd4dd90cefccac0a8ea00fb435759b2c6e351b41df
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
      -DCGNS_BUILD_CGNSTOOLS=OFF
#      -DCGNS_BUILD_SHARED=ON
      -DCGNS_BUILD_TESTING=OFF
      -DCGNS_ENABLE_BASE_SCOPE=OFF
      -DCGNS_ENABLE_FORTRAN=OFF
      -DCGNS_ENABLE_HDF5=ON
      -DCGNS_ENABLE_LFS=OFF
      -DCGNS_ENABLE_MEM_DEBUG=OFF
      -DCGNS_ENABLE_SCOPING=OFF
      -DCGNS_ENABLE_TESTS=OFF
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/license.txt ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
