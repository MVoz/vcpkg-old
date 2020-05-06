include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://osrf-distributions.s3.amazonaws.com/sdformat/releases/sdformat-6.2.0.tar.bz2"
    FILENAME "sdformat-6.2.0.tar.bz2"
    SHA512 e81f0f73e628155ef929c6d7930611f02009a8a217a043e127506c1310ae892b846a8080906feb0932108e9cfa280f473573a5af5096b55b66619b2ac794b0d5
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE} 
)

# Ruby is required by the sdformat build process 
vcpkg_find_acquire_program(RUBY)
get_filename_component(RUBY_PATH ${RUBY} DIRECTORY)
set(_path $ENV{PATH})
vcpkg_add_to_path(${RUBY_PATH})


vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    OPTIONS -DBUILD_TESTING=OFF
            -DUSE_EXTERNAL_URDF=ON
)

vcpkg_install_cmake()

# Restore original path 
set(ENV{PATH} ${_path})

# Move location of sdformat.dll from lib to bin 
file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/bin)
file(RENAME ${CURRENT_PACKAGES_DIR}/lib/sdformat.dll
          ${CURRENT_PACKAGES_DIR}/bin/sdformat.dll)

file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/debug/bin)
file(RENAME ${CURRENT_PACKAGES_DIR}/debug/lib/sdformat.dll
            ${CURRENT_PACKAGES_DIR}/debug/bin/sdformat.dll)

# Fix cmake targets location
vcpkg_fixup_cmake_targets(CONFIG_PATH "lib/cmake/sdformat")

# Remove debug files
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include 
                    ${CURRENT_PACKAGES_DIR}/debug/lib/cmake
                    ${CURRENT_PACKAGES_DIR}/debug/share)

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/sdformat6 RENAME copyright)

# Post-build test for cmake libraries
vcpkg_test_cmake(PACKAGE_NAME SDFormat)