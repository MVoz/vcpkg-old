#vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/sys-bio/sbnw/archive/4dae747bbe7b45598038c52c8d7d0ff7420d045c.zip"
    FILENAME "sbnw.zip"
    SHA512 2159aa69a01c592c8c0f0f6d818a65098cbcf8e18bff33d68689e7dbbe6c98f8089ca594485f5685913c88d2beeffe0741920fe456a36d652476da16f8b1a245
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
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
      -DBUILD_STATIC_LIB:BOOL=OFF
#      -DENABLE_PYTHON:BOOL=FALSE
#      -DENABLE_PYTHON2_BINDINGS:BOOL=OFF
#      -DENABLE_PYTHON3_BINDINGS:BOOL=OFF
#      -DLIBXML2_DIR:FILEPATH=None
      -DLINK_WITH_LIBSBML:BOOL=1
#      -DLINK_WITH_MAGICK:BOOL=OFF #ImageMagick
      -DSBNW_LINK_TO_STATIC_LIBSBML:BOOL=ON
#	  -DLIBXML2_LIBDIR=${CURRENT_PACKAGES_DIR}/lib
      -DSBNW_SPYDER_DIST:BOOL=ON
      -DSBNW_WIN_COPY_DEPS_TO_INSTALL:BOOL=OFF
      -DWITH_GTEST:BOOL=OFF
	  -DLIBXML2_DIR=${CURRENT_PACKAGES_DIR}/share#/libxml2
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/COPYING.txt ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
