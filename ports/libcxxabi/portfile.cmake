include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/webrtc-uwp/libcxxabi/archive/7846258648354c7c536a202473f4dc89a685fef3.zip"
    FILENAME "libcxxabi.zip"
    SHA512 e1b2e0427ed061dae898c1c2873d6d5d735f14e1afa986be8d847c8bf6ee4ded22deaa5ed778cd8e918a74f7c6a523fd27a845fbbbad0caa1ffcce3d218de55f
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_find_acquire_program(PYTHON3)
vcpkg_find_acquire_program(CLANG)

get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
get_filename_component(LLVM_DIR "${CLANG}" DIRECTORY)

set(ENV{LLVM_PATH} ${LLVM_DIR}/..)
set(ENV{PYTHONHOME ${PYTHON3_DIR})
set(ENV{PYTHONPATH ${PYTHON3_DIR}/Lib)

set(ENV{PATH} "$ENV{PATH};${PYTHON3_DIR};${LLVM_DIR}")

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
	NO_CHARSET_FLAG # automatic templates
#	GENERATOR "NMake Makefiles" # automatic templates
#    DISABLE_PARALLEL_CONFIGURE
    OPTIONS_DEBUG # automatic templates
        -DDISABLE_INSTALL_HEADERS=ON # automatic templates
		-DINSTALL_HEADERS_TOOLS=OFF
		-DINSTALL_HEADERS=OFF
    OPTIONS_RELEASE 
        -DINSTALL_HEADERS=ON # automatic templates
#        -D =OFF
#    OPTIONS 
#        -DBUILD_SHARED_LIBS=ON # automatic templates
)

vcpkg_install_cmake()

#file(TO_NATIVE_PATH "${CURRENT_INSTALLED_DIR}/include" PGSQL_INCLUDE_DIR)

#file(COPY ${SOURCE_PATH}/greatest.h DESTINATION ${CURRENT_PACKAGES_DIR}/include)

#vcpkg_fixup_cmake_targets(CONFIG_PATH "lib/cmake/${PORT}")
#vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/nlohmann_json TARGET_PATH share/nlohmann_json)
#file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/bin)
#file(RENAME ${CURRENT_PACKAGES_DIR}/lib/${LIB_NAME}.dll ${CURRENT_PACKAGES_DIR}/bin/${LIB_NAME}.dll
#file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/libcxxabi RENAME copyright)

#file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/lib ${CURRENT_PACKAGES_DIR}/debug)
#file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin ${CURRENT_PACKAGES_DIR}/debug/bin ${CURRENT_PACKAGES_DIR}/debug/share ${CURRENT_PACKAGES_DIR}/debug/include)

#file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/tools)
#file(RENAME ${CURRENT_PACKAGES_DIR}/debug/bin ${CURRENT_PACKAGES_DIR}/tools/${PORT})

#vcpkg_copy_tool_dependencies(${CURRENT_PACKAGES_DIR}/tools/openexr)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME libcxxabi)

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
