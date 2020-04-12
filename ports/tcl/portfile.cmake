include(vcpkg_common_functions)

#vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_download_distfile(ARCHIVE
    URLS "https://sourceforge.net/projects/tcl/files/Tcl/8.6.9/tcl8.6.9-src.tar.gz/download"
    FILENAME "tcl8.6.9-src.tar.gz"
    SHA512 707fc0fb4f45c85e8f21692e5035d727cde27d87a2e1cd2e748ad373ebd3517aeca25ecaef3382a2f0e0a1feff96ce94a62b87abcf085e1a0afe2a23ef460112
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

if(VCPKG_TARGET_ARCHITECTURE MATCHES "x64")
    set(MACHINE_STR AMD64)
else()
    set(MACHINE_STR IX86)
endif()

#Build the static core and shell.
# OPTS=static,msvcrt

vcpkg_configure_make(
    SOURCE_PATH ${SOURCE_PATH}
    GENERATOR NMAKE
	PROJECT_SUBPATH "/win"
    PROJECT_PATH "makefile.vc"
	OPTIONS
        MACHINE=${MACHINE_STR}
	OPTIONS_DEBUG
		OPTS=symbols
	POSTRUN_SHELL_RELEASE
	    INSTALLDIR=${CURRENT_PACKAGES_DIR} install
	POSTRUN_SHELL_DEBUG
	    OPTS=symbols INSTALLDIR=${CURRENT_PACKAGES_DIR}/debug install
)

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/license.terms ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
