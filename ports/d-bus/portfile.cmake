include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://gitlab.freedesktop.org/dbus/dbus/-/archive/fd41caa3664d480605628f08c217581bc42fa3e7/dbus-fd41caa3664d480605628f08c217581bc42fa3e7.tar.gz"
    FILENAME "dbus.tar.gz"
    SHA512 bee6be7cc5105aae05b527fa30f505cdfc24d807effa7e8da43571a508818659bc431bc531a134b25d7b321b14ba2fd5020d8b15baf3598409661a3a8eb2c476
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_find_acquire_program(DOXYGEN)
vcpkg_find_acquire_program(DocBookXML4_DTD)
vcpkg_find_acquire_program(DocBookXSL)
vcpkg_find_acquire_program(XGETTEXT)
vcpkg_find_acquire_program(PERL)
#vcpkg_find_acquire_program(MEINPROC5)
get_filename_component(DOXYGEN_DIR "${DOXYGEN}" DIRECTORY)
get_filename_component(DocBookXML4_DTD_DIR "${DocBookXML4_DTD}" DIRECTORY)
get_filename_component(DocBookXSL_DIR "${DocBookXSL}" DIRECTORY)
get_filename_component(GETTEXT_DIR "${XGETTEXT}" DIRECTORY)
get_filename_component(PERL_DIR "${PERL}" DIRECTORY)
#get_filename_component(MEINPROC5_DIR "${MEINPROC4}" DIRECTORY)
set(ENV{PATH} ";$ENV{PATH};${DOXYGEN_DIR};${GETTEXT_DIR};${PERL_DIR}};${DocBookXML4_DTD_DIR};${DocBookXSL_DIR}")
#;${MEINPROC5_DIR}

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
#	GENERATOR "NMake Makefiles" # automatic templates
#    DISABLE_PARALLEL_CONFIGURE
    OPTIONS_DEBUG # automatic templates
        -DDISABLE_INSTALL_HEADERS=ON # automatic templates
#        -D =OFF
#    OPTIONS_RELEASE
#        -D =OFF
    OPTIONS 
        -DDBUS_BUILD_TESTS=ON
        -DDBUS_ENABLE_DOXYGEN_DOCS=ON # required argument
        -DDBUS_ENABLE_XML_DOCS=OFF
        -DDBUS_MSVC_ANALYZE=OFF
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/COPYING ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
