include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/steveire/grantlee/archive/daf1352a6ff25d71c194b002953ea3116d3b7dc3.zip"
    FILENAME "daf1352a6ff25d71c194b002953ea3116d3b7dc3.zip"
    SHA512 ae07e6bbcdfc5cd05f8d1d8581a1a3029c50c2f1942cf41696659b7a1c414831791e573059c1b71659cd8da0f82452511dc1fd49e7fe217ba9b423835a7ab0a3
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_find_acquire_program(XGETTEXT)
vcpkg_find_acquire_program(DOXYGEN)
get_filename_component(DOXYGEN_DIR "${DOXYGEN}" DIRECTORY)
get_filename_component(GETTEXT_DIR "${XGETTEXT}" DIRECTORY)
set(ENV{PATH} "$ENV{PATH};${GETTEXT_DIR};${DOXYGEN_DIR}")

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
#        -D =OFF
    OPTIONS
        -DBUILD_TESTS=OFF
        -DBUILD_TEXTDOCUMENT=ON
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/COPYING.LIB ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
