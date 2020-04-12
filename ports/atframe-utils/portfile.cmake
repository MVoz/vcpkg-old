include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/atframework/atframe_utils/archive/d6a3828ccecb0c299f9adbad1e95ea8e163fc43e.zip"
    FILENAME "d6a3828ccecb0c299f9adbad1e95ea8e163fc43e.zip"
    SHA512 4858c383c4f98530c649718edcadfd48127512f553ed51156c1b1f139ba51c128a576aa38af40f5a4a857fbe2a433ebb20d9a849a03fd2fbe7394d8f83487dc2
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
      -DLIBUNWIND_ENABLED=OFF # [default=NO] Enable and using libunwind for callstack unwind
      -DLOG_WRAPPER_ENABLE_LUA_SUPPORT=OFF # [default=YES] Enable lua support for log system
      -DLOG_WRAPPER_CHECK_LUA=OFF # [default=YES] Enable checking for lua support
      -DLOG_WRAPPER_ENABLE_STACKTRACE=ON # [default=YES] Enable stack trace for log system
      -DENABLE_MIXEDINT_MAGIC_MASK=0 #0-8 [default=0] Set mixed int mask
      -DCRYPTO_DISABLED=ON # [default=NO] Disable crypto and DH/ECDH support
      -DCRYPTO_USE_OPENSSL=OFF # [default=NO] Using openssl for crypto and DH/ECDH support, and close auto detection
      -DCRYPTO_USE_MBEDTLS=OFF # [default=NO] Using mbedtls for crypto and DH/ECDH support, and close auto detection
      -DBOOST_ROOT=${CURRENT_INSTALLED_DIR}
      -DCMAKE_POSITION_INDEPENDENT_CODE=ON
      -DCOMPILER_OPTION_MSVC_ZC_CPP=ON
      -DENABLE_NETWORK=OFF
      -DGTEST_ROOT=${CURRENT_INSTALLED_DIR}
      -DLOCK_DISABLE_MT=ON
      -DPROJECT_ENABLE_SAMPLE=OFF
      -DPROJECT_ENABLE_UNITTEST=OFF
      -DPROJECT_TEST_ENABLE_BOOST_UNIT_TEST=OFF
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
