include(vcpkg_common_functions)

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

#https://github.com/modelon-community/fmi-library
vcpkg_download_distfile(ARCHIVE
    URLS "https://jmodelica.org/FMILibrary/FMILibrary-2.0.3-src.zip"
    FILENAME "FMILibrary-2.0.3-src.zip"
    SHA512 86e4b5019d8f2a76b01141411845d977fb3949617604de0b34351f23647e3e8b378477de184e1c4f2f59297bc4c7de3155e0edba9099b8924594a36b37b04cc8
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates
    OPTIONS_DEBUG # automatic templates
#      -DEXECUTABLE_OUTPUT_PATH=${CURRENT_PACKAGES_DIR}/debug/bin
      -DFMILIB_INSTALL_PREFIX=${CURRENT_PACKAGES_DIR}/debug
#      -DLIBRARY_OUTPUT_PATH=${CURRENT_PACKAGES_DIR}/debug/lib
    OPTIONS_RELEASE 
#      -DEXECUTABLE_OUTPUT_PATH=${CURRENT_PACKAGES_DIR}/bin
      -DFMILIB_INSTALL_PREFIX=${CURRENT_PACKAGES_DIR}
#      -DLIBRARY_OUTPUT_PATH=${CURRENT_PACKAGES_DIR}/lib
    OPTIONS
#      -DFMILIB_BUILD_SHARED_LIB=ON
#      -DFMILIB_BUILD_STATIC_LIB=OFF
      -DBUILD_TESTING=OFF
      -DFMILIB_BUILD_BEFORE_TESTS=OFF
      -DFMILIB_BUILD_LEX_AND_PARSER_FILES=FALSE
      -DFMILIB_BUILD_TESTS=OFF
#      -DFMILIB_BUILD_WITH_STATIC_RTLIB=OFF
      -DFMILIB_ENABLE_LOG_LEVEL_DEBUG=OFF
#      -DFMILIB_FMI_STANDARD_HEADERS=${SOURCE_PATH}/ThirdParty/FMI/default
      -DFMILIB_GENERATE_BUILD_STAMP=OFF
      -DFMILIB_GENERATE_DOXYGEN_DOC=OFF
      -DFMILIB_INSTALL_SUBLIBS=OFF
      -DFMILIB_LINK_TEST_TO_SHAREDLIB=OFF
#      -DFMILIB_THIRDPARTYLIBS=${SOURCE_PATH}/ThirdParty
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE.md ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
