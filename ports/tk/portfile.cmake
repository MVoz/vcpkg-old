include(vcpkg_common_functions)

#vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_download_distfile(ARCHIVE
    URLS "https://sourceforge.net/projects/tcl/files/Tcl/8.6.9/tk8.6.9.1-src.tar.gz/download"
    FILENAME "tk8.6.9.1-src.tar.gz"
    SHA512 b9c811ffc8326331ae03c6fb25ea71f7a5eaeebd9d5a16a51a1671d0f0422268bd351b077e17ae925f0a7eddac9642aa640658615c52d4269c299373af031a92
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    PATCHES
      001_patch.patch #https://github.com/tcltk/tk/commit/f195faf8b7869bf49781843be9b699d1fe7d01b5
	  002_flags_tk.patch #error C2220: warning treated as error
)

vcpkg_download_distfile(ARCHIVE
    URLS "https://sourceforge.net/projects/tcl/files/Tcl/8.6.9/tcl8.6.9-src.tar.gz/download"
    FILENAME "tcl8.6.9-src.tar.gz"
    SHA512 707fc0fb4f45c85e8f21692e5035d727cde27d87a2e1cd2e748ad373ebd3517aeca25ecaef3382a2f0e0a1feff96ce94a62b87abcf085e1a0afe2a23ef460112
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH_TCL
    ARCHIVE ${ARCHIVE}
    PATCHES
	  003_flags_tcl.patch #error C2220: warning treated as error
)

if(VCPKG_TARGET_ARCHITECTURE MATCHES "x64")
    set(MACHINE_STR AMD64)
else()
    set(MACHINE_STR IX86)
endif()

#Build the static core and shell.
# OPTS=static,msvcrt
vcpkg_configure_make(
    SOURCE_PATH ${SOURCE_PATH_TCL}
    GENERATOR NMAKE
	PROJECT_SUBPATH "/win"
    PROJECT_PATH "makefile.vc"
	OPTIONS
        MACHINE=${MACHINE_STR}
	OPTIONS_DEBUG
		OPTS=symbols
)

file(COPY ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/win DESTINATION ${SOURCE_PATH_TCL})
file(COPY ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/win DESTINATION ${SOURCE_PATH_TCL})

vcpkg_configure_make(
    SOURCE_PATH ${SOURCE_PATH}
    GENERATOR NMAKE
	PROJECT_SUBPATH "/win"
    PROJECT_PATH "makefile.vc"
	OPTIONS
        TCLDIR=${SOURCE_PATH_TCL}# SRC and pre-BUILT files !
	OPTIONS_RELEASE
	    INSTALLDIR=${CURRENT_PACKAGES_DIR}
	OPTIONS_DEBUG
		OPTS=symbols INSTALLDIR=${CURRENT_PACKAGES_DIR}/debug
	POSTRUN_SHELL_RELEASE
	    TCLDIR=${SOURCE_PATH_TCL} INSTALLDIR=${CURRENT_PACKAGES_DIR} install
	POSTRUN_SHELL_DEBUG
	    OPTS=symbols TCLDIR=${SOURCE_PATH_TCL} INSTALLDIR=${CURRENT_PACKAGES_DIR}/debug install
)

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/license.terms ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
