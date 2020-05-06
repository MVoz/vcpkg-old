include(vcpkg_common_functions)

if(VCPKG_CMAKE_SYSTEM_NAME STREQUAL "WindowsStore")
    message(FATAL_ERROR "WindowsStore not supported")
endif()

set(VERSION 1.0.3)

set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/re2c-${VERSION})
vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/skvadrik/re2c/releases/download/${VERSION}/re2c-${VERSION}.tar.gz"
    FILENAME "re2c-${VERSION}.tar.gz"
    SHA512 7b2a43828da872a957af88fb0a226e1936a45c8a1020ba1f6544b588aaa61dff8df40e84f9053c30ac8e17c41164e70627d57f5d3721a34b2aba7b1dbf25b6ae
)
vcpkg_extract_source_archive(${ARCHIVE})

file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH})
# file(COPY ${CMAKE_CURRENT_LIST_DIR}/config.h DESTINATION ${SOURCE_PATH})
file(WRITE ${SOURCE_PATH}/config.h "#define PACKAGE_VERSION \"${VERSION}\"\n#define HAVE_STDINT_H 1\n")

# Run cmake configure step
vcpkg_configure_cmake(SOURCE_PATH ${SOURCE_PATH})

# Run cmake install step
vcpkg_install_cmake()

# Allow empty include directory
set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

# Handle copyright
file(COPY ${SOURCE_PATH}/NO_WARRANTY DESTINATION ${CURRENT_PACKAGES_DIR}/share/re2c)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/re2c/NO_WARRANTY ${CURRENT_PACKAGES_DIR}/share/re2c/copyright)
