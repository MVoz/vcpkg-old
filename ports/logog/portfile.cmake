include(vcpkg_common_functions)

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/johnwbyrd/logog/archive/1269f56625a32c34786dca0c415479e1ff1ba298.zip"
    FILENAME "logog.zip"
    SHA512 5c67e1f939e2482606b76d1b1606c8b6259328b061f6dadb0db1fc4a5461358886f2486869606bdd5cfcb611a01d4303f525fdf98cf03459ea3b8796c9976056
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
      -DBUILD_TESTING:BOOL=OFF
#      -DLOGOG_LEAK_DETECTION:BOOL=FALSE
#      -DLOGOG_LEAK_DETECTION_MICROSOFT:BOOL=
#      -DLOGOG_UNICODE:BOOL=FALSE
#      -DLOGOG_UNIT_TESTING:BOOL=FALSE
#      -DLOGOG_USE_COTIRE:BOOL=FALSE
#      -DLOGOG_USE_PREFIX:BOOL=FALSE
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/readme.markdown ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
