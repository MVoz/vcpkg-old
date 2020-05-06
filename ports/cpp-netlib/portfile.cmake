include(vcpkg_common_functions)

if(VCPKG_CMAKE_SYSTEM_NAME STREQUAL "WindowsStore")
    message(FATAL_ERROR "${PORT} does not currently support UWP")
endif()

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO cpp-netlib/cpp-netlib
    REF cpp-netlib-0.13.0-final
    SHA512 1839bf1acb7917acd2957f1008a44ed26a38849afb5843bfa0d5c557dde530afab4183d8d273a87d6416aad2b3a59fdecdef5fbb62bc91ed484486c80a1de5eb
    HEAD_REF master
)

 vcpkg_configure_cmake(
      SOURCE_PATH ${SOURCE_PATH}
      PREFER_NINJA
	  OPTIONS
      -DCPP-NETLIB_BUILD_TESTS=off
      -DCPP-NETLIB_BUILD_EXAMPLES=off

)

vcpkg_install_cmake()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

if (NOT VCPKG_CMAKE_SYSTEM_NAME OR VCPKG_CMAKE_SYSTEM_NAME STREQUAL "WindowsStore")
  vcpkg_fixup_cmake_targets(CONFIG_PATH cmake)
else()
  vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/cppnetlib)
endif()

file(INSTALL ${SOURCE_PATH}/LICENSE_1_0.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
