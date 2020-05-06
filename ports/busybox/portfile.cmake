include(vcpkg_common_functions)
vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/rmyorston/busybox-w32/archive/03a7b173605a890e1db5177ecd5b8dd591081c41.zip"
    FILENAME "03a7b173605a890e1db5177ecd5b8dd591081c41.zip"
    SHA512 689c5eeef9c93cd2f29645252f9a51c3e1928ba56e7dd74093ab7d648906b2142fabcc6da1aa0c40e4db8ef45684c2eec8791c018686c806ca02349da1d25d03
)
vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE} 
)
# mingw-w64-i686-toolchain 
#vcpkg_acquire_msys(MSYS_ROOT PACKAGES base-devel msys2-devel mingw-w64-x86_64-toolchain windows-default-manifest mingw-w64-x86_64-windows-default-manifest)

#vcpkg_find_acquire_program(YASM)
#vcpkg_find_acquire_program(PERL)
#vcpkg_acquire_msys(MSYS_ROOT PACKAGES make)
#vcpkg_acquire_msys(MSYS_ROOT PACKAGES diffutils)
#get_filename_component(YASM_EXE_PATH ${YASM} DIRECTORY)
#get_filename_component(PERL_EXE_PATH ${PERL} DIRECTORY)

#message(STATUS "PERL_EXE_PATH ; ${PERL_EXE_PATH}")
#set(ENV{PATH} "${YASM_EXE_PATH};${MSYS_ROOT}/usr/bin;$ENV{PATH};${PERL_EXE_PATH}")
#set(BASH ${MSYS_ROOT}/usr/bin/bash.exe)

vcpkg_acquire_msys(MSYS_ROOT PACKAGES kconfig-frontends msys2-runtime-devel)

#set(SVN ${MSYS_ROOT}/usr/bin/svn.exe)
# Insert msys into the path between the compiler toolset and windows system32. This prevents masking of "link.exe" but DOES mask "find.exe".
# ${MSYS_ROOT}/usr/bin;${MSYS_ROOT}/mingw32/bin;
# vcpkg_acquire_msys(MSYS_ROOT PACKAGES base-devel msys2-devel mingw-w64-i686-toolchain mingw-w64-x86_64-toolchain autoconf libtool flex automake make perl pkg-config diffutils automake1.15)
string(REPLACE ";$ENV{SystemRoot}\\system32;" ";${MSYS_ROOT}/mingw64/bin;${MSYS_ROOT}/usr/bin;$ENV{SystemRoot}\\system32;" NEWPATH "$ENV{PATH}")
set(ENV{PATH} "${NEWPATH}")
set(BASH ${MSYS_ROOT}/usr/bin/bash.exe)
#set(AUTOMAKE_DIR ${MSYS_ROOT}/usr/share/automake-1.15)
set(ENV{INCLUDE} "${CURRENT_INSTALLED_DIR}/include;$ENV{INCLUDE}")
set(ENV{LIB} "${CURRENT_INSTALLED_DIR}/lib;$ENV{LIB}")

# Configure release
#message(STATUS "Configuring ${TARGET_TRIPLET}-rel")
#file(REMOVE_RECURSE ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel)
#file(MAKE_DIRECTORY ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel)

# Configure debug
#message(STATUS "Configuring ${TARGET_TRIPLET}-dbg")
#file(REMOVE_RECURSE ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg)
#file(MAKE_DIRECTORY ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg)

# --host=x86_64-pc-msys2
set(CONFIGURE_OPTIONS "--host=i686-pc-mingw32 --enable-strip --disable-lavf --disable-swscale --disable-asm --disable-avs --disable-ffms --disable-gpac --disable-lsmash")

set(CONFIGURE_OPTIONS_RELEASE "--prefix=${CURRENT_PACKAGES_DIR}")
set(CONFIGURE_OPTIONS_DEBUG "--enable-debug --prefix=${CURRENT_PACKAGES_DIR}/debug")

#vcpkg_execute_required_process(
#    COMMAND ${BASH} --noprofile --norc -c 
#        "CC=cl ${SOURCE_PATH}/configure ${CONFIGURE_OPTIONS} ${CONFIGURE_OPTIONS_RELEASE}"
#    WORKING_DIRECTORY "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel"
#    LOGNAME "configure-${TARGET_TRIPLET}-rel")
#message(STATUS "Configuring ${TARGET_TRIPLET}-rel done")

# Configure release
message(STATUS "Package ${TARGET_TRIPLET}-rel")
vcpkg_execute_required_process(
    COMMAND ${BASH} --noprofile --norc -c "make mingw64_defconfig"
    WORKING_DIRECTORY "${SOURCE_PATH}"
    LOGNAME "configure-${TARGET_TRIPLET}-rel"
)
message(STATUS "Package ${TARGET_TRIPLET}-rel done")

# Build release
message(STATUS "Package ${TARGET_TRIPLET}-rel")
vcpkg_execute_required_process(
    COMMAND ${BASH} --noprofile --norc -c "make"
    WORKING_DIRECTORY "${SOURCE_PATH}"
    LOGNAME "build-${TARGET_TRIPLET}-rel"
)
message(STATUS "Package ${TARGET_TRIPLET}-rel done")

# Handle copyright
# file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/busybox RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME busybox)
