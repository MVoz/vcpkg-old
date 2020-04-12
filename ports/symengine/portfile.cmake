include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/symengine/symengine/archive/535ff3c7716c8a3ca4254e51b1b9cd5baf5d8b19.zip"
    FILENAME "symengine.zip"
    SHA512 f576dac90982b54bbfaa9eed80547cb44c689c294dfcbe0c6fe593b9b8e369bab1641c09652f2989c87471340e42d495fa7bec198b8bd0481c5792f6fbec3268
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
      -DBUILD_BENCHMARKS=no
      -DBUILD_BENCHMARKS_NONIUS=no
      -DBUILD_DOXYGEN=no
      -DBUILD_FOR_DISTRIBUTION=no
      -DBUILD_TESTS=no
      -DCOTIRE_VERBOSE=ON
#      -DMSVC_USE_MT=yes
      -DMSVC_WARNING_LEVEL:STRING=1
      -DWITH_ARB=no
      -DWITH_BFD=no
      -DWITH_BOOST=yes
      -DWITH_COTIRE=yes
      -DWITH_ECM=yes
      -DWITH_FLINT=no
      -DWITH_GENERATE_PARSER=no
      -DWITH_LLVM=no
      -DWITH_MPC=no
      -DWITH_MPFR=yes
      -DWITH_OPENMP=no
      -DWITH_PIRANHA=no
      -DWITH_PRIMESIEVE=no
      -DWITH_PTHREAD=no
      -DWITH_SYMENGINE_ASSERT=no
      -DWITH_SYMENGINE_RCP=no
      -DWITH_SYMENGINE_TEUCHOS=no
      -DWITH_SYMENGINE_THREAD_SAFE=no
      -DWITH_TCMALLOC=no
      -DWITH_VIRTUAL_TYPEID=no
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
