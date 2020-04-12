include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/tpaviot/oce/archive/f94a1fc3a397e09edbdffa6a5dab86291afe6183.zip"
    FILENAME "OCE-0.zip"
    SHA512 060d8a38d439803b625903a07f48f1e323cbdd12a41a6014d1160b3404fff32fcb40e3b6bc403d94dccfb7e04982e223f582c51206e70477c1b3f197e26d1a95
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

set(ENV{PATH} "$ENV{PATH};${CURRENT_INSTALLED_DIR}/bin;${CURRENT_INSTALLED_DIR}/debug/bin")

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates

    OPTIONS 
      -DBUILD_TESTING=OFF
      -DOCE_USE_PCH=OFF
      -DOCE_COPY_HEADERS_BUILD=OFF
#      -DCMAKE_NEEDS_RESPOSE=1
#      -DOCE_BUILD_SHARED_LIB=ON
      -DOCE_DATAEXCHANGE=OFF
      -DOCE_DRAW=OFF
      -DOCE_INSTALL_PDB_FILES=OFF
      -DOCE_INSTALL_PREFIX=${CURRENT_PACKAGES_DIR}
#      -DOCE_MODEL=ON
      -DOCE_MULTITHREADED_BUILD=OFF #=OPENMP or =TBB
#      -DOCE_MULTITHREAD_LIBRARY:STRING=NONE
#      -DOCE_OCAF=ON
      -DOCE_TESTING=OFF
      -DOCE_USE_TCL_TEST_FRAMEWORK=OFF
      -DOCE_VISUALISATION=OFF
      -DOCE_WITH_FONTCONFIG=OFF
      -DOCE_WITH_FREEIMAGE=OFF
      -DOCE_WITH_GL2PS=OFF
      -DOCE_WITH_VTK=OFF
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
