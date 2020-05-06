include(vcpkg_common_functions)
set(OPENSSL_VERSION 1.1.0g)
set(MASTER_COPY_SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src)

message("MASTER_COPY_SOURCE_PATH ${MASTER_COPY_SOURCE_PATH}")
vcpkg_download_distfile(
    OPENSSL_SOURCE_ARCHIVE
    URLS https://hifi-public.s3.amazonaws.com/dependencies/android/openssl-1.1.0g_armv8.tgz?versionId=AiiPjmgUZTgNj7YV1EEx2lL47aDvvvAW
    SHA512 5d7bb6e5d3db2340449e2789bcd72da821f0e57483bac46cf06f735dffb5d73c1ca7cc53dd48f3b3979d0fe22b3ae61997c516fc0c4611af4b4b7f480e42b992
    FILENAME openssl-1.1.0g_armv8.tgz
)

vcpkg_extract_source_archive(${OPENSSL_SOURCE_ARCHIVE})

file(COPY ${MASTER_COPY_SOURCE_PATH}/include DESTINATION ${CURRENT_PACKAGES_DIR})
file(GLOB LIBS ${MASTER_COPY_SOURCE_PATH}/lib/*.a)
file(COPY ${LIBS} DESTINATION ${CURRENT_PACKAGES_DIR}/libs)
file(COPY ${LIBS} DESTINATION ${CURRENT_PACKAGES_DIR}/debug/libs)
file(INSTALL ${CMAKE_CURRENT_LIST_DIR}/LICENSE.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/openssl-android RENAME copyright)





