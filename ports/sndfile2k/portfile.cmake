include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/evpobr/sndfile2k/archive/10b355baf30a0aa17be335c8fc71d1b4e22fcb93.zip"
    FILENAME "sndfile2k.zip"
    SHA512 074da0a4217f1ef94eff36c18930a60f3414f2c3363374e02a89b1bd6813b329f59042895801955e8ded6c3f0367676a0e3f0766e53052a0b4410c82f069fa95
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

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
      -DBUILD_DOCUMENTATION=OFF
      -DBUILD_EXAMPLES=OFF
      -DBUILD_PROGRAMS=OFF
      -DBUILD_SHARED_LIBS=ON
      -DBUILD_TESTING=OFF
      -DENABLE_CMAKE_PACKAGE_CONFIG=ON
      -DENABLE_CPU_CLIP=ON
      -DENABLE_EXPERIMENTAL=OFF
      -DENABLE_PKGCONFIG_FILE=ON
      -DENABLE_STATIC_RUNTIME=OFF
      -DHAVE_XIPH_CODECS=ON

)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE.txt ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
