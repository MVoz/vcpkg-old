include(vcpkg_common_functions)

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/giaf/hpipm/archive/432e0248568caaae3e1e1f52edf7ee275f934c07.zip"
    FILENAME "hpipm.zip"
    SHA512 25d9b2649f3980c564a5464da226a42abdd0db00370d56bb47677686052288557bbcbf21418df345bed67c384ccefa06081c60313b5f17d85a7b9dbc7dfb11a4
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
      -DTARGET=GENERIC # MSVC compiler only supported for TARGET=GENERIC #X64_INTEL_HASWELL
	  -DBLASFEO_PATH=${CURRENT_INSTALLED_DIR}
	  -DHPIPM_TESTING=OFF
	  -DREF_BLAS=0 #REF_BLAS=OPENBLAS
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE.txt ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
