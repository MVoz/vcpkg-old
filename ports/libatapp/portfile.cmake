include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/atframework/libatapp/archive/9ead2cd5a85c41edc236cd885058c26f145b818d.zip"
    FILENAME "9ead2cd5a85c41edc236cd885058c26f145b818d.zip"
    SHA512 13f4f8f34100de157391c76d31c4470cc58385263077fb68e2728fffb41d0114e6cf7ad809f70465806ce8b70f39685dfaef10467bb17e6c3dc7eec45812223e
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_find_acquire_program(PYTHON3)
get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
set(ENV{PATH} "$ENV{PATH};${PYTHON3_DIR}")

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates

    OPTIONS 
      -DBOOST_ROOT=${CURRENT_INSTALLED_DIR}
      -DCMAKE_POSITION_INDEPENDENT_CODE=ON
      -DCOMPILER_OPTION_MSVC_ZC_CPP=ON
      -DCRYPTO_DISABLED=ON
      -DENABLE_NETWORK=OFF
      -DGTEST_ROOT=${CURRENT_INSTALLED_DIR}
      -DLIBUNWIND_ENABLED=OFF
      -DLIBUV_ROOT=${CURRENT_INSTALLED_DIR}
      -DLOCK_DISABLE_MT=ON
      -DLOG_WRAPPER_CHECK_LUA=OFF
      -DLOG_WRAPPER_ENABLE_LUA_SUPPORT=OFF
      -DLOG_WRAPPER_ENABLE_STACKTRACE=ON
      -DPROJECT_ENABLE_SAMPLE=OFF
      -DPROJECT_ENABLE_UNITTEST=OFF
      -DPROJECT_TEST_ENABLE_BOOST_UNIT_TEST=OFF
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
