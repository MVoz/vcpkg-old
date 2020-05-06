include(vcpkg_common_functions)

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/HSAFoundation/HSAIL-Tools/archive/6514deb6bcb13930aaba2c5d380621cf685f37d2.zip"
    FILENAME "6514deb6bcb13930aaba2c5d380621cf685f37d2.zip"
    SHA512 4da4eaae9500f61cfc96d46a1d5e09cda2968be235d8c283d9dec41c03656ee0d90de9e6bd740c57caa37d91ea523a2e45b3af0fc8d137bd9aa747e40dc6e5cb
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_find_acquire_program(PERL)
get_filename_component(PERL_DIR "${PERL}" DIRECTORY)
set(ENV{PATH} "$ENV{PATH};${PERL_DIR}")

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
#      -DBUILD_WITH_LIBBRIGDWARF=1
#      -DBUILD_WITH_LIBBRIGDWARF=1
      -DAMD_EXTENSIONS=ON
      -DBUILD_HSAILASM=ON
      -DVENDOR_EXTENSIONS=ON
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/README.md ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
