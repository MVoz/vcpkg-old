#CURRENT_BUILDTREES_DIR    = ${VCPKG_ROOT_DIR}\buildtrees\${PORT}
#${CURRENT_BUILDTREES_DIR}/XMP-Toolkit-SDK
include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Exiv2/exiv2
    REF 98e63e4bb4d78ee9dec2ba9dca2aa1785278e51c
    SHA512 937749134053e098aab1458f6780f8d07673e90823a33723d1892a99ed9d775d6d5665e0d9ec8abceabbdc971c95b842f8193826b10b6e38348e0b6529b2bb9b
    HEAD_REF master
#    PATCHES
#        iconv.patch
)

if(WIN32 AND ("unicode" IN_LIST FEATURES))
    set(enable_win_unicode TRUE)
elseif()
    set(enable_win_unicode FALSE)
endif()

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
      -DEXIV2_ENABLE_WIN_UNICODE=FALSE #${enable_win_unicode}
      -DBUILD_WITH_CCACHE=OFF
      -DBUILD_WITH_COVERAGE=OFF
      -DEXIV2_BUILD_EXIV2_COMMAND=FALSE
      -DEXIV2_BUILD_UNIT_TESTS=FALSE
      -DEXIV2_BUILD_SAMPLES=FALSE
      -DBUILD_TESTING=OFF
      -DEXIV2_ENABLE_XMP=OFF #expat 	ON 	-DEXIV2_ENABLE_XMP=Off
      -DEXIV2_ENABLE_EXTERNAL_XMP=OFF
      -DEXIV2_ENABLE_PNG=ON #zlib 	ON 	-DEXIV2_ENABLE_PNG=Off
      -DEXIV2_ENABLE_CURL=ON
      -DEXIV2_ENABLE_NLS=OFF #gettext 	OFF 	-DEXIV2_ENABLE_NLS
#      -DXmpSdk_DIR:PATH=${CURRENT_BUILDTREES_DIR}/XMP-Toolkit-SDK/build
      -DEXIV2_BUILD_DOC=OFF
      -DEXIV2_BUILD_FUZZ_TESTS=OFF
      -DEXIV2_BUILD_UNIT_TESTS=FALSE
#      -DEXIV2_ENABLE_DYNAMIC_RUNTIME=ON
#      -DEXIV2_ENABLE_LENSDATA=ON
#      -DEXIV2_ENABLE_PRINTUCS2=ON
      -DEXIV2_ENABLE_WEBREADY=OFF
      -DEXIV2_TEAM_PACKAGING=OFF
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(CONFIG_PATH "share/exiv2/cmake")

configure_file(
    ${CMAKE_CURRENT_LIST_DIR}/vcpkg-cmake-wrapper.cmake
    ${CURRENT_PACKAGES_DIR}/share/exiv2
    @ONLY
)

vcpkg_copy_pdbs()

# Clean
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include ${CURRENT_PACKAGES_DIR}/debug/share)

if(VCPKG_LIBRARY_LINKAGE STREQUAL "static")
    file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin ${CURRENT_PACKAGES_DIR}/debug/bin)
endif()

# Handle copyright 
file(COPY ${SOURCE_PATH}/ABOUT-NLS DESTINATION ${CURRENT_PACKAGES_DIR}/share/exiv2)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/exiv2/ABOUT-NLS ${CURRENT_PACKAGES_DIR}/share/exiv2/copyright)
