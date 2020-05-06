include(vcpkg_common_functions)
include(vcpkg_common_definitions) # for CURRENT_PACKAGES_DIR

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO robotology/ycm
    REF 07513bec577add16464a9e903d605530ba527238
    SHA512 dcc58f0feec76c92fd5d5ec1922575f06665b0fb39d3277230c25a0a069de60e8e5e1633715a3820036a512ab00072ed968a490606775ecc415a799caf52a1ee
    HEAD_REF devel
)

vcpkg_configure_cmake(
    SOURCE_PATH "${SOURCE_PATH}"
    PREFER_NINJA
)

vcpkg_install_cmake()

if(VCPKG_TARGET_IS_WINDOWS)
    vcpkg_fixup_cmake_targets(CONFIG_PATH "CMake" TARGET_PATH "share/ycm")
else()
    include(GNUInstallDirs) # for CMAKE_INSTALL_LIBDIR
    vcpkg_fixup_cmake_targets(CONFIG_PATH "${CMAKE_INSTALL_LIBDIR}/cmake/ycm" TARGET_PATH "share/ycm")
endif()

file(REMOVE_RECURSE
    "${CURRENT_PACKAGES_DIR}/debug"
)

file(WRITE ${CURRENT_PACKAGES_DIR}/include/.YCM "") # Vcpkg will not accept the package as-is without at least one file in the include/ subdirectory
file(
    INSTALL "${SOURCE_PATH}/Copyright.txt"
    DESTINATION "${CURRENT_PACKAGES_DIR}/share/ycm"
    RENAME copyright
)
