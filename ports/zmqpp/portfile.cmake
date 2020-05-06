include(vcpkg_common_functions)

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/zeromq/zmqpp/archive/d764578c53c6d77a0e67be0bd64b9bf82c138ec6.zip"
    FILENAME "zmqpp.zip"
    SHA512 f869a72e6fe9140b9378072e90b3c00f1e69c471bdca232e17f57216322f5c47d50719480f88716009c6d522b531b3bcee27fc47f1052b26f82781fa762e834f
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
#      -DZEROMQ_INCLUDE_DIR:PATH=
#      -DZEROMQ_LIBRARY_SHARED:FILEPATH=ZEROMQ_LIBRARY_SHARED-NOTFOUND
#      -DZEROMQ_LIBRARY_STATIC:FILEPATH=ZEROMQ_LIBRARY_STATIC-NOTFOUND
#      -DZEROMQ_LIB_DIR:PATH=
      -DZMQPP_BUILD_CLIENT=false
      -DZMQPP_BUILD_EXAMPLES=false
      -DZMQPP_BUILD_SHARED=true
      -DZMQPP_BUILD_STATIC=false
      -DZMQPP_BUILD_TESTS=false
      -DZMQPP_LIBZMQ_CMAKE=true
#      -DZMQPP_LIBZMQ_NAME_SHARED=zmq
#      -DZMQPP_LIBZMQ_NAME_STATIC=zmq-static
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
