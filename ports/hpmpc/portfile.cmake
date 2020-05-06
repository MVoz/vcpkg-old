include(vcpkg_common_functions)

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/giaf/hpmpc/archive/3cd096f4fa2ad19995ccc1d3930307f0d372e416.zip"
    FILENAME "3cd096f4fa2ad19995ccc1d3930307f0d372e416.zip"
    SHA512 652595d4c278bb366138ccc0dc820dbc1773389a307c2ce082080c599135f014647a5382fede15417543d95878a8c8b73a1b0fd80478bf01f12a50b7cf305109
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
      -DBLASFEO_PATH=${CURRENT_INSTALLED_DIR}
	  -DREF_BLAS=0 #REF_BLAS=OPENBLAS
      -DTARGET=GENERIC # MSVC compiler only supported for TARGET=GENERIC X64_INTEL_HASWELL
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE.txt ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
