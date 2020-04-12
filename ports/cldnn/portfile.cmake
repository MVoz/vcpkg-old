include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/intel/clDNN/archive/c4ef3bd7b707fc386655cccf90e6c0420d1efec7.zip"
    FILENAME "clDNN.zip"
    SHA512 d65f9f0426cf86adbabc3c287944f75a28d7bad4091d4432a38aa6695be8f85cf65ad2c1d70cdc92188f5bce0ea27d5e0c952026a7f24800dfcd06f6df1fcbe7
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_find_acquire_program(PYTHON3)
vcpkg_find_acquire_program(DOXYGEN)
get_filename_component(DOXYGEN_DIR "${DOXYGEN}" DIRECTORY)
get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
set(ENV{PATH} "$ENV{PATH};${DOXYGEN_DIR};${PYTHON3_DIR}")

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates
    OPTIONS 
      -DCLDNN__ARCHITECTURE_TARGET=Windows64 #supported: `Windows32`, `Windows64`, `Linux64`
      -DCLDNN__INCLUDE_TESTS=OFF
      -DCLDNN__RUN_TESTS=OFF
      -DPYTHON_EXECUTABLE=${PYTHON3}
#      -DCLDNN__IOCL_ICD_USE_EXTERNAL= #(based on INTELOCLSDKROOT environment variable). Default: OFF
#      -DCLDNN__IOCL_ICD_VERSION=
#      -DCLDNN__COMPILE_LINK_ALLOW_UNSAFE_SIZE_OPT= #Allow unsafe optimizations during linking (like aggressive dead code elimination, etc.). Default: ON
#      -DCLDNN__COMPILE_LINK_USE_STATIC_RUNTIME= #Link with static C++ runtime. Default: OFF (shared C++ runtime is used)
      -DCLDNN__CMAKE_DEBUG=ON #Enable extended debug messages in CMake. Default: OFF
    OPTIONS_DEBUG 
	  -DCLDNN__OUTPUT_DIR=${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/codegen
    OPTIONS_RELEASE
	  -DCLDNN__OUTPUT_DIR=${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/codegen
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/README.md ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
