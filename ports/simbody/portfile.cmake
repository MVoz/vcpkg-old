include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/simbody/simbody/archive/12805f8b4b4b676fafea31828667de4b1cac28eb.zip"
    FILENAME "simbody.zip"
    SHA512 855a70ab21cdc6a26cd3d3fac98c4a82a3d54aad2cf17bcefd3186ab78bc18a27abe7856b08f84e33c53b477390195cd00dd9992081bce65c0c6a5da70da7486
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    PATCHES
      001_simbody_patch.patch # failed search openblas or mkl
)

file(REMOVE_RECURSE ${SOURCE_PATH}/Platform/Windows)

#default openblas
#set(VCPKG_FORTRAN_ENABLED ON)
#vcpkg_enable_fortran(intel) # -- MKL LIB

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
#    PREFER_NINJA # Windows ERROR
    NO_CHARSET_FLAG # automatic templates

    OPTIONS 
      -DBUILD_DYNAMIC_LIBRARIES=TRUE
      -DBUILD_EXAMPLES=OFF
#      -DBUILD_PLATFORM:STRING=Windows:x64
      -DBUILD_STATIC_LIBRARIES=FALSE
      -DBUILD_TESTING=OFF
#      -DBUILD_UNVERSIONED_LIBRARIES=TRUE
#      -DBUILD_USING_NAMESPACE:STRING=
#      -DBUILD_USING_OTHER_LAPACK:STRING=
#      -DBUILD_VERSIONED_LIBRARIES=FALSE
      -DBUILD_VISUALIZER=OFF
      -DINSTALL_DOCS=OFF
#	  -DLAPACK_BEING_USED=lapack
#      -DLAPACK_BEING_USED:STRING=lapack;blas
      -DSIMBODY_COVERAGE=OFF
#      -DSIMBODY_SONAME_VERSION:STRING=3.7
#      -DIMBODY_VERSION:STRING=3.7
#      -DSimTKCOMMON_LIBRARY_NAME:STRING=SimTKcommon
#      -DSimTKMATH_LIBRARY_NAME:STRING=SimTKmath
#      -DSimTKSIMBODY_LIBRARY_NAME:STRING=SimTKsimbody
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE.txt ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
