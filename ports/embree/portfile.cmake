include(vcpkg_common_functions)

#https://github.com/embree/embree/archive/25b9fa9af96f59bb48747b7aadac745d4b3d7b81.zip
vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/embree/embree/archive/v3.5.2.tar.gz"
    FILENAME "embree-v3.5.2.tar.gz"
    SHA512 f00403c8bc76428088a38990117245b5b11ac90a2df21fa12c2d5c2e8af45fb3708abb705c612e0d9d7b0cfe4edb51c8b9630b60081b39fcb4370f31ee37acc7
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

file(REMOVE ${SOURCE_PATH}/common/cmake/FindTBB.cmake)

if(VCPKG_CRT_LINKAGE STREQUAL static)
    set(EMBREE_STATIC_RUNTIME ON)
else()
    set(EMBREE_STATIC_RUNTIME OFF)
endif()

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    OPTIONS
      -DEMBREE_ISPC_SUPPORT=OFF
      -DEMBREE_TUTORIALS=OFF
      -DEMBREE_STATIC_RUNTIME=${EMBREE_STATIC_RUNTIME}
      "-DTBB_LIBRARIES=TBB::tbb"
      "-DTBB_INCLUDE_DIRS=${CURRENT_INSTALLED_DIR}/include"
      -DBUILD_TESTING=OFF
)

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE.txt ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
