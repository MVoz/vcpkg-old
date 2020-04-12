include(vcpkg_common_functions)

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/giaf/blasfeo/archive/78c3120e5c522d3fcba33c3fb62142f3b77d4bda.zip"
    FILENAME "blasfeo.zip"
    SHA512 a2528e4efa13c2e9db3479660136f5d71f254ebd67979bcf71bb1e993499eddd94229fffc698e6316f9d47aeb7cdbdbb108913c7cfac772ef80e22e0bf4446e2
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates

    OPTIONS 
      -DBLASFEO_BENCHMARKS=OFF
      -DBLASFEO_EXAMPLES=OFF
      -DBLASFEO_TESTING=OFF
      -DEXTERNAL_BLAS=1
      -DEXT_DEP=ON
      -DK_MAX_STACK=300
      -DLA=HIGH_PERFORMANCE
      -DTARGET=GENERIC # MSVC compiler only supported for TARGET=GENERIC X64_INTEL_HASWELL
      -DUSE_C99_MATH=ON
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE.txt ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
