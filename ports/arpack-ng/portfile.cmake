include(vcpkg_common_functions)

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/opencollab/arpack-ng/archive/92787d9bcca34c5f1dac305a2bcd0d9861b81cd3.zip"
    FILENAME "92787d9bcca34c5f1dac305a2bcd0d9861b81cd3.zip"
    SHA512 72f7ecffada2f25f09f4de8aa3a1a82eddb0f0c2026ba46131cead97e330b8102b57c4fa56cb827271442a9d8bd66139ccc90603bfacb4ae04cf9fa2ba19346c
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    PATCHES
      001_arpack-ng_patch.patch
)

set(VCPKG_FORTRAN_ENABLED ON)
vcpkg_enable_fortran(intel)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    OPTIONS 
      -DBUILD_SHARED_LIBS=ON # automatic templates
      -DMPI:BOOL=OFF 
	  -DINTERFACE64:BOOL=ON 
	  -DICB:BOOL=OFF 
	  -DICBEXMM:BOOL=OFF
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/COPYING ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
