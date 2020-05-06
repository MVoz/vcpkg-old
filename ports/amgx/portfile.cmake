include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/NVIDIA/AMGX/archive/cf285c118726f5d1e8eb740d4936dd0bdaaf9b48.zip"
    FILENAME "AMGX.zip"
    SHA512 5334538c0ffc16da9c4036b6bee35592a9d3dfc4958a1984a75cb2926f6dbce5dfecb0844a43aa154723eef249d2fd2924fe0ee2e277e09c61b88bcfb793078e
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

set(CUDA_SEPARABLE_COMPILATION ON)
set(CUDA_PROPAGATE_HOST_FLAGS OFF)
if (CMAKE_SIZEOF_VOID_P MATCHES 8)
  set(CUDA_64_BIT_DEVICE_CODE_DEFAULT ON)
endif()

#MPI implementation, such as OpenMPI for Linux or MPICH for Windows
vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates

    OPTIONS 
#      -DCUDA_ARCH="35 52 60" ....
      -DCMAKE_NO_MPI=ON #If True then non-MPI (single GPU) build will be forced
	  -Dverbose=ON
	  -DAMGX_WITH_MPI=OFF
#	  -DOMPI_IMPORTS
#      -DAMGX_NO_RPATH= #By default CMake adds -rpath flags to binaries
#      -DMKL_ROOT_DIR= #MKL functionality is used to accelerate. AMGX was not build with MKL support.
#      -DMAGMA_ROOT_DIR= #MAGMA functionality is used to accelerate. AMGX was not build with MAGMA support.
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
