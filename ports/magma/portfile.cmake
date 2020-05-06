include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "http://icl.utk.edu/projectsfiles/magma/downloads/magma-2.5.1-alpha1.tar.gz"
    FILENAME "magma-2.5.1-alpha1.tar.gz"
    SHA512 e0a2df3f0a859b5a2a52da07f88fecb0637c1271cfd72e37741f1b6c6018ab6edb927912034b2556763772c23bc41bc13dd1c68d307be8b86d6a236b47f611aa
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

set(VCPKG_FORTRAN_ENABLED ON)
vcpkg_enable_fortran(intel)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
#    DISABLE_PARALLEL_CONFIGURE
    OPTIONS_DEBUG # automatic templates
        -DDISABLE_INSTALL_HEADERS=ON # automatic templates
#        -D =OFF
#    OPTIONS_RELEASE
#        -D =OFF
    OPTIONS 
        -DBUILD_SHARED_LIBS=ON # automatic templates
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/COPYRIGHT ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
