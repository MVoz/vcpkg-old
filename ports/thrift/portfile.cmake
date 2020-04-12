include(vcpkg_common_functions)

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_find_acquire_program(FLEX)
vcpkg_find_acquire_program(BISON)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO apache/thrift
<<<<<<< HEAD
    REF acdd4226c210336e9e15eb812e5932a645fcd5ce
    SHA512 53986b1cde7b2bd19974f32b8c31736566061a228dda368d3d850355c566d910499c16519bbff078a6cdab19931cd9833a7d684ac63fb1ec40b2a123ff263aaa
=======
    REF 2ff952b0af4035bcb71d8d73d9eb75df31983544
    SHA512 58d08a6258b3c64f6fe1f2e4200b6cac61b19ac66113782e4eacf058d15c451de741bff137b32261fc816074ef111627f27cc50ad366eb73395dcc631c2ca66f
>>>>>>> [many ports] Updates 2019.04.19 (#6155)
    HEAD_REF master
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DBUILD_SHARED_LIBS=OFF
        -DWITH_STDTHREADS=ON
        -DBUILD_TESTING=off
        -DBUILD_JAVA=off
        -DBUILD_C_GLIB=off
        -DBUILD_PYTHON=off
        -DBUILD_CPP=on
        -DBUILD_HASKELL=off
        -DBUILD_TUTORIALS=off
        -DFLEX_EXECUTABLE=${FLEX}
        -DBISON_EXECUTABLE=${BISON}
)

vcpkg_install_cmake()

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/thrift RENAME copyright)

# Move CMake config files to the right place
vcpkg_fixup_cmake_targets(CONFIG_PATH "lib/cmake/thrift")

file(GLOB COMPILER "${CURRENT_PACKAGES_DIR}/bin/thrift*")
if(COMPILER)
    file(COPY ${COMPILER} DESTINATION ${CURRENT_PACKAGES_DIR}/tools/thrift)
    file(REMOVE ${COMPILER})
    vcpkg_copy_tool_dependencies(${CURRENT_PACKAGES_DIR}/tools/thrift)
endif()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/bin)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin)
vcpkg_copy_pdbs()
