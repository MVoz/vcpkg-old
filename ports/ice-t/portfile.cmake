include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "http://visit.ilight.com/svn/visit/trunk/third_party/icet-master-77c708f9090236b576669b74c53e9f105eedbd7e.tar.gz"
    FILENAME "icet-master-77c708f9090236b576669b74c53e9f105eedbd7e.tar.gz"
    SHA512 7875afa21ddecef99b5d178f769864b5a71e216718e79626362eab7d6e02cb6e708f8c8df9afdb7ca595ebfa46c8e549ca52a774eee3d70dcc6fa78e5005ea97
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
    NO_CHARSET_FLAG # automatic templates

    OPTIONS 
      -DBUILD_TESTING=OFF
      -DICET_USE_MPI=ON
      -DICET_USE_OFFSCREEN_EGL=OFF
      -DICET_USE_OPENGL=ON
      -DICET_USE_OSMESA=OFF
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/README.md ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
