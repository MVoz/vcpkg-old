include(vcpkg_common_functions)

vcpkg_check_linkage(ONLY_STATIC_LIBRARY) #chacha20_poly1305_x86_64.asm.obj : error LNK2001: unresolved external symbol dummy_chacha20_poly1305_asm

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/google/boringssl/archive/chromium-stable.zip"
    FILENAME "boringssl-v.zip"
    SHA512 0fe0339bb11f49fb7c8c733a86b5b0ae03c81192aa85684940a34d575cd9ad84bca839e67141cd039a8e401498eafc98dedf8d6467e6c6a7829dcd12fae8c554
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

#* On Windows only, NASM[4] is required. If not found by CMake, it may be configured explicitly by setting CMAKE_ASM_NASM_COMPILER.
vcpkg_find_acquire_program(PERL)
vcpkg_find_acquire_program(GO)
vcpkg_find_acquire_program(NASM)
vcpkg_find_acquire_program(YASM)
get_filename_component(NASM_DIR "${NASM}" DIRECTORY)
get_filename_component(PERL_DIR "${PERL}" DIRECTORY)
get_filename_component(GO_DIR "${GO}" DIRECTORY)
get_filename_component(YASM_DIR "${YASM}" DIRECTORY)
set(ENV{PATH} "$ENV{PATH};${PERL_DIR};${GO_DIR};${NASM_DIR};${YASM_DIR}")
#
set(PERL_EXECUTABLE ${PERL})
set(GO_EXECUTABLE ${GO})
set(CMAKE_ASM_NASM_COMPILER ${NASM})

message(STATUS "CMAKE_ASM_NASM_COMPILER = ${CMAKE_ASM_NASM_COMPILER}")

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
    OPTIONS 
#      -DBUILD_SHARED_LIBS=1
	  -DOPENSSL_SMALL=1
	  
)

vcpkg_install_cmake()

#file(TO_NATIVE_PATH "${CURRENT_INSTALLED_DIR}/include" PGSQL_INCLUDE_DIR)

#file(COPY ${SOURCE_PATH}/greatest.h DESTINATION ${CURRENT_PACKAGES_DIR}/include)

#vcpkg_fixup_cmake_targets(CONFIG_PATH "lib/cmake/${PORT}")
#vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/nlohmann_json TARGET_PATH share/nlohmann_json)
#file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/bin)
#file(RENAME ${CURRENT_PACKAGES_DIR}/lib/${LIB_NAME}.dll ${CURRENT_PACKAGES_DIR}/bin/${LIB_NAME}.dll
#file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/boringssl RENAME copyright)

#file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/lib ${CURRENT_PACKAGES_DIR}/debug)
#file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin ${CURRENT_PACKAGES_DIR}/debug/bin ${CURRENT_PACKAGES_DIR}/debug/share ${CURRENT_PACKAGES_DIR}/debug/include)

#file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/tools)
#file(RENAME ${CURRENT_PACKAGES_DIR}/debug/bin ${CURRENT_PACKAGES_DIR}/tools/${PORT})

#vcpkg_copy_tool_dependencies(${CURRENT_PACKAGES_DIR}/tools/openexr)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME boringssl)

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
