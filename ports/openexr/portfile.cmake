include(vcpkg_common_functions)

if (VCPKG_CMAKE_SYSTEM_NAME STREQUAL "WindowsStore")
  message(FATAL_ERROR "UWP build not supported")
endif()

set(OPENEXR_VERSION 2.3.0)
set(OPENEXR_HASH 268ae64b40d21d662f405fba97c307dad1456b7d996a447aadafd41b640ca736d4851d9544b4741a94e7b7c335fe6e9d3b16180e710671abfc0c8b2740b147b2)

vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO openexr/openexr
  REF v${OPENEXR_VERSION}
  SHA512 ${OPENEXR_HASH}
  HEAD_REF master
  PATCHES
    fix_clang_not_setting_modern_cplusplus.patch
    fix_install_ilmimf.patch
)

vcpkg_configure_cmake(SOURCE_PATH ${SOURCE_PATH}
  PREFER_NINJA
  OPTIONS
    -DOPENEXR_BUILD_PYTHON_LIBS:BOOL=FALSE
  OPTIONS_DEBUG
    -DILMBASE_PACKAGE_PREFIX=${CURRENT_INSTALLED_DIR}/debug
  OPTIONS_RELEASE
    -DILMBASE_PACKAGE_PREFIX=${CURRENT_INSTALLED_DIR})

vcpkg_install_cmake()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)

# NOTE: Only use ".exe" extension on Windows executables.
# Is there a cleaner way to do this?
if(NOT VCPKG_CMAKE_SYSTEM_NAME OR VCPKG_CMAKE_SYSTEM_NAME STREQUAL "WindowsStore")
    set(EXECUTABLE_SUFFIX ".exe")
else()
    set(EXECUTABLE_SUFFIX "")
endif()
file(REMOVE ${CURRENT_PACKAGES_DIR}/debug/bin/exrenvmap${EXECUTABLE_SUFFIX})
file(REMOVE ${CURRENT_PACKAGES_DIR}/debug/bin/exrheader${EXECUTABLE_SUFFIX})
file(REMOVE ${CURRENT_PACKAGES_DIR}/debug/bin/exrmakepreview${EXECUTABLE_SUFFIX})
file(REMOVE ${CURRENT_PACKAGES_DIR}/debug/bin/exrmaketiled${EXECUTABLE_SUFFIX})
file(REMOVE ${CURRENT_PACKAGES_DIR}/debug/bin/exrmultipart${EXECUTABLE_SUFFIX})
file(REMOVE ${CURRENT_PACKAGES_DIR}/debug/bin/exrmultiview${EXECUTABLE_SUFFIX})
file(REMOVE ${CURRENT_PACKAGES_DIR}/debug/bin/exrstdattr${EXECUTABLE_SUFFIX})
file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/tools/openexr/)
file(RENAME ${CURRENT_PACKAGES_DIR}/bin/exrenvmap${EXECUTABLE_SUFFIX} ${CURRENT_PACKAGES_DIR}/tools/openexr/exrenvmap${EXECUTABLE_SUFFIX})
file(RENAME ${CURRENT_PACKAGES_DIR}/bin/exrheader${EXECUTABLE_SUFFIX} ${CURRENT_PACKAGES_DIR}/tools/openexr/exrheader${EXECUTABLE_SUFFIX})
file(RENAME ${CURRENT_PACKAGES_DIR}/bin/exrmakepreview${EXECUTABLE_SUFFIX} ${CURRENT_PACKAGES_DIR}/tools/openexr/exrmakepreview${EXECUTABLE_SUFFIX})
file(RENAME ${CURRENT_PACKAGES_DIR}/bin/exrmaketiled${EXECUTABLE_SUFFIX} ${CURRENT_PACKAGES_DIR}/tools/openexr/exrmaketiled${EXECUTABLE_SUFFIX})
file(RENAME ${CURRENT_PACKAGES_DIR}/bin/exrmultipart${EXECUTABLE_SUFFIX} ${CURRENT_PACKAGES_DIR}/tools/openexr/exrmultipart${EXECUTABLE_SUFFIX})
file(RENAME ${CURRENT_PACKAGES_DIR}/bin/exrmultiview${EXECUTABLE_SUFFIX} ${CURRENT_PACKAGES_DIR}/tools/openexr/exrmultiview${EXECUTABLE_SUFFIX})
file(RENAME ${CURRENT_PACKAGES_DIR}/bin/exrstdattr${EXECUTABLE_SUFFIX} ${CURRENT_PACKAGES_DIR}/tools/openexr/exrstdattr${EXECUTABLE_SUFFIX})
vcpkg_copy_tool_dependencies(${CURRENT_PACKAGES_DIR}/tools/openexr)

vcpkg_copy_pdbs()

if (VCPKG_LIBRARY_LINKAGE STREQUAL static)
  file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin ${CURRENT_PACKAGES_DIR}/debug/bin)
endif()

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
file(COPY ${CMAKE_CURRENT_LIST_DIR}/FindOpenEXR.cmake DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT})
file(COPY ${CMAKE_CURRENT_LIST_DIR}/vcpkg-cmake-wrapper.cmake DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT})
