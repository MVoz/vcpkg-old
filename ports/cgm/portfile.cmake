include(vcpkg_common_functions)

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_download_distfile(ARCHIVE
    URLS "https://bitbucket.org/fathomteam/cgm/get/97e42923cfc3.zip"
    FILENAME "cgm.zip"
    SHA512 2a9d35551d718167b1fb84048208bf776ac17cc1d3e2e32a6bd0b95a14e3976a3ac33ff0cabbf7a277593ecdf27dc59b544981c7df138efcc15c650731d45ff9
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
      -DBUILD_WITH_CONCURRENT_SUPPORT:BOOL=OFF # deps Qt4
      -DENABLE_MPI:BOOL=ON
      -DENABLE_OCC:BOOL=OFF
      -DENABLE_TESTING:BOOL=OFF
#      -DM:FILEPATH=.../VC/Tools/MSVC/14.16.27023/lib/x64/m.lib
#      -DOCC_DIR:PATH=...
#      -DOpenCasCade_DIR:PATH=...
#      -DQT_QMAKE_EXECUTABLE:FILEPATH=../qmake.exe
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
