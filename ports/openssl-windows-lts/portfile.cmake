
include(vcpkg_common_functions)
set(OPENSSL_VERSION 1.1.1b)
set(MASTER_COPY_SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/openssl-${OPENSSL_VERSION})

vcpkg_find_acquire_program(PERL)
vcpkg_find_acquire_program(NASM)
find_program(NMAKE nmake)

get_filename_component(PERL_EXE_PATH ${PERL} DIRECTORY)
get_filename_component(NASM_EXE_PATH ${NASM} DIRECTORY)
set(ENV{PATH} "${PERL_EXE_PATH};${NASM_EXE_PATH};$ENV{PATH}")

vcpkg_download_distfile(OPENSSL_SOURCE_ARCHIVE
    URLS "https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz"
    FILENAME "openssl-${OPENSSL_VERSION}.tar.gz"
    SHA512 b54025fbb4fe264466f3b0d762aad4be45bd23cd48bdb26d901d4c41a40bfd776177e02230995ab181a695435039dbad313f4b9a563239a70807a2e19ecf045d
)

vcpkg_extract_source_archive(${OPENSSL_SOURCE_ARCHIVE})

set(CONFIGURE_COMMAND ${PERL} Configure
    enable-static-engine
    enable-capieng
)

if(TARGET_TRIPLET MATCHES "x86-windows")
    set(OPENSSL_ARCH VC-WIN32)
elseif(TARGET_TRIPLET MATCHES "x64-windows")
    set(OPENSSL_ARCH VC-WIN64A)
else()
    message(FATAL_ERROR "Unsupported target triplet: ${TARGET_TRIPLET}")
endif()

if(VCPKG_LIBRARY_LINKAGE STREQUAL dynamic)
    set(OPENSSL_LINKAGE)
else()
    set(OPENSSL_LINKAGE no-shared)
endif()

file(REMOVE_RECURSE ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg)

if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "release")
message(STATUS "Build ${TARGET_TRIPLET}-rel")
file(COPY ${MASTER_COPY_SOURCE_PATH} DESTINATION ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel)
set(SOURCE_PATH_RELEASE ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/openssl-${OPENSSL_VERSION})
set(OPENSSLDIR_RELEASE ${CURRENT_PACKAGES_DIR})

vcpkg_execute_required_process(
    COMMAND ${CONFIGURE_COMMAND} ${OPENSSL_ARCH} ${OPENSSL_LINKAGE} "--prefix=${OPENSSLDIR_RELEASE}" "--openssldir=${OPENSSLDIR_RELEASE}"
    WORKING_DIRECTORY ${SOURCE_PATH_RELEASE}
    LOGNAME configure-perl-${TARGET_TRIPLET}-${CMAKE_BUILD_TYPE}-rel
)

vcpkg_execute_required_process(COMMAND ${NMAKE} install
                               WORKING_DIRECTORY ${SOURCE_PATH_RELEASE}
                               LOGNAME build-${TARGET_TRIPLET}-rel)

message(STATUS "Build ${TARGET_TRIPLET}-rel done")
endif()

if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "debug")
message(STATUS "Build ${TARGET_TRIPLET}-dbg")
file(COPY ${MASTER_COPY_SOURCE_PATH} DESTINATION ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg)
set(SOURCE_PATH_DEBUG ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/openssl-${OPENSSL_VERSION})
set(OPENSSLDIR_DEBUG ${CURRENT_PACKAGES_DIR}/debug)

vcpkg_execute_required_process(
    COMMAND ${CONFIGURE_COMMAND} debug-${OPENSSL_ARCH} ${OPENSSL_LINKAGE} "--prefix=${OPENSSLDIR_DEBUG}" "--openssldir=${OPENSSLDIR_DEBUG}"
    WORKING_DIRECTORY ${SOURCE_PATH_DEBUG}
    LOGNAME configure-perl-${TARGET_TRIPLET}-${CMAKE_BUILD_TYPE}-dbg
)

vcpkg_execute_required_process(COMMAND ${NMAKE} install
                               WORKING_DIRECTORY ${SOURCE_PATH_DEBUG}
                               LOGNAME build-${TARGET_TRIPLET}-dbg)

message(STATUS "Build ${TARGET_TRIPLET}-dbg done")
endif()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE
    ${CURRENT_PACKAGES_DIR}/debug/bin/openssl.exe
    ${CURRENT_PACKAGES_DIR}/bin/openssl.exe
    ${CURRENT_PACKAGES_DIR}/debug/bin/openssl.pdb
    ${CURRENT_PACKAGES_DIR}/bin/openssl.pdb
    ${CURRENT_PACKAGES_DIR}/debug/bin/ossl_static.pdb
    ${CURRENT_PACKAGES_DIR}/bin/ossl_static.pdb
    ${CURRENT_PACKAGES_DIR}/debug/openssl.cnf.dist
    ${CURRENT_PACKAGES_DIR}/openssl.cnf.dist
    ${CURRENT_PACKAGES_DIR}/debug/openssl.cnf
    ${CURRENT_PACKAGES_DIR}/openssl.cnf
    ${CURRENT_PACKAGES_DIR}/ct_log_list.cnf
    ${CURRENT_PACKAGES_DIR}/ct_log_list.cnf.dist
)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/certs)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/html)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/private)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/lib/engines-1_1)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/misc)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/certs)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/html)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/private)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/lib/engines-1_1)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/misc)

file(INSTALL ${MASTER_COPY_SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)

if(VCPKG_LIBRARY_LINKAGE STREQUAL static)
    # They should be empty, only the exes deleted above were in these directories
    file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/bin/)
    file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin/)
endif()

vcpkg_copy_pdbs()