#vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/cellml/libcellml/archive/d033841378ac1de06b88ccd1bb7c02e1ccced2ef.zip"
    FILENAME "d033841378ac1de06b88ccd1bb7c02e1ccced2ef.zip"
    SHA512 c249fa5b75e07e6a45603870e2434440e052001d9d16135b5405443195ec1594062ec284c0c3993cf2d6387793dd6e94d63d87b1d19b71116c7b82b6ab60f061
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
#    PATCHES
#      001_libcellml_fixes.patch
#      001_libcellml_patch.patch
)

vcpkg_find_acquire_program(PYTHON3)
vcpkg_find_acquire_program(SWIG)
get_filename_component(SWIG_DIR "${SWIG}" DIRECTORY)
get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)

set(ENV{PATH} "$ENV{PATH};${SWIG_DIR};${PYTHON3_DIR}")

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates
    OPTIONS 
      -DLIBCELLML_BINDINGS_PYTHON=OFF
      -DLIBCELLML_BUILD_SHARED=ON
      -DLIBCELLML_TREAT_WARNINGS_AS_ERRORS=OFF
      -DLIBCELLML_UNIT_TESTS=OFF
	  -DLIBXML2_DIR=${CURRENT_PACKAGES_DIR}/share#/libxml2
      -DLIBCELLML_MEMCHECK=OFF #Enable memcheck testing (if available)
      -DLIBCELLML_COVERAGE=OFF #Enable coverage testing (if available)
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
