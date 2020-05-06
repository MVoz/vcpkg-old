include(vcpkg_common_functions)

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_download_distfile(ARCHIVE
    URLS "https://gitlab.linphone.org/BC/public/bctoolbox/-/archive/790e6aefa1b73fd1773f992955207ba67f83e31e/bctoolbox-790e6aefa1b73fd1773f992955207ba67f83e31e.tar.gz"
    FILENAME "bctoolbox.tar.gz"
    SHA512 35bbb68d7737eabc88cd0b59160fe8fb1c51509eefd915b0e85a1ee02f011873064e5fdc05cffd06ea0897da67a1c1de1a9363bbb45875bab14024a60b432d51
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
#      -DENABLE_MBEDTLS=NO #: do not look for mbedtls. Then, polarssl will be selected.
      -DENABLE_POLARSSL=NO #: do not look for polarssl. That ensure to use mbedtls.
      -DENABLE_DECAF=NO
#      -DENABLE_SHARED=ON #: do not build the shared libraries.
      -DENABLE_SHARED=NO
      -DENABLE_STATIC=ON #: do not build the static libraries.
      -DENABLE_STRICT=NO #: do not build with strict compilator flags e.g. -Wall -Werror.
      -DENABLE_TESTS=NO #: do not build testing binaries.
      -DENABLE_TESTS_COMPONENT=NO #: do not build libbctoolbox-tester.
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/COPYING ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
