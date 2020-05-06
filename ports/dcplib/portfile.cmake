include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/modelica/DCPLib/archive/bb91c3a1fcca1dcad6f669f83a063b6bd2a7d29c.zip"
    FILENAME "DCPLib.zip"
    SHA512 aa4a94d5e4d44f7e0be569be77c0d5fbe3ed69cc69f8324c529ca2c2a1a8dba6b33d603bbd54d70f67c7fd789896c765d4ea3a77f757f60f3536af1185801eec
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
#      -DASIO_ROOT=
      -DBUILD_ALL=ON
#      -DBUILD_BLUETOOTH=OFF
#      -DBUILD_ETHERNET=OFF
#      -DBUILD_MASTER=OFF
#      -DBUILD_SLAVE=OFF
#      -DBUILD_XML=OFF
#      -DBUILD_ZIP=OFF
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
