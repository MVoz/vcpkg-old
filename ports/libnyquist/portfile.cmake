include(vcpkg_common_functions)

if(DEFINED VCPKG_CMAKE_SYSTEM_NAME)
    message(FATAL_ERROR "Error: libnyquist tested only on Windows Desktop")
endif()

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/ddiakopoulos/libnyquist/archive/d372227a91f36f25321e1dc56dda87577e018897.zip"
    FILENAME "d372227a91f36f25321e1dc56dda87577e018897.zip"
    SHA512 6855fdf864f469eab1d452bfd8adac2e037902cae93730f0906a027ddb1e07420ca29b842c504c4ffbb891aadf7666cc712291f395fae31f655c301d0f2ee3b1
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE} 

)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja

)

vcpkg_install_cmake()

FILE(GLOB_RECURSE DELETE_FILES_WAV ${CURRENT_PACKAGES_DIR}/libwavpack*)
FILE(GLOB_RECURSE DELETE_FILES_OPUS ${CURRENT_PACKAGES_DIR}/libopus*)

#SET(DEL ${DELETE_FILES_OPUS}
#        ${DELETE_FILES_WAV}
#)

file(REMOVE_RECURSE ${DELETE_FILES_OPUS} ${DELETE_FILES_WAV})

#file(REMOVE ${CURRENT_PACKAGES_DIR}/lib/libwavpack.?)
#file(REMOVE ${CURRENT_PACKAGES_DIR}/lib/libopus.?)

file(COPY ${SOURCE_PATH}/include/libnyquist DESTINATION ${CURRENT_PACKAGES_DIR}/include)

file(INSTALL ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/libnyquist RENAME copyright)
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/libnyquist RENAME license)

# Handle copyright
# file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/libnyquist RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME libnyquist)
