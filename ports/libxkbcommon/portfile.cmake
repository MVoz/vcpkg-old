include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/xkbcommon/libxkbcommon/archive/06a80beed8a408eebffa2fe80854fcda38d82ee2.zip"
    FILENAME "06a80beed8a408eebffa2fe80854fcda38d82ee2.zip"
    SHA512 12c7d92f7fc0229762db3d1dbbe3361e1f2aa703d7c9d787274ec658f430e849a477a19dccbc34ea1e3cb95c8a7f64809679817d43f90c972878d279d1f58b12
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
#    PATCHES
#        001_port_fixes.patch
#        002_more_port_fixes.patch
)

vcpkg_find_acquire_program(FLEX)
vcpkg_find_acquire_program(BISON)
vcpkg_find_acquire_program(PYTHON3)
vcpkg_find_acquire_program(DOXYGEN)

#питон не находит зависимости, пришлось добавить все
get_filename_component(FLEX_DIR "${FLEX}" DIRECTORY)
get_filename_component(BISON_DIR "${BISON}" DIRECTORY)
get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
get_filename_component(DOXYGEN_DIR "${DOXYGEN}" DIRECTORY)

#vcpkg_add_to_path("${PYTHON3_DIR};${FLEX_DIR};${BISON_DIR};${DOXYGEN_DIR}")
set(ENV{PATH} ";$ENV{PATH};${FLEX_DIR};${BISON_DIR};${DOXYGEN_DIR};${PYTHON3}")

### https://mesonbuild.com/Configuring-a-build-directory.html
vcpkg_configure_meson(
	SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
		--backend=ninja
		-Denable-x11=false
#		-Dxkb-config-root=${CURRENT_PACKAGES_DIR}/share/X11/xkb
#		-Dx-locale-root=${CURRENT_PACKAGES_DIR}/share/X11/locale
		-Denable-wayland=false
#		-Ddefault-options=static_name_suffix=lib
		-Dxkb-config-root=/usr/share/X11/xkb
		-Dx-locale-root=/usr/share/X11/locale
		-Denable-docs=false
		
)

vcpkg_install_meson()

#file(COPY ${SOURCE_PATH}/greatest.h DESTINATION ${CURRENT_PACKAGES_DIR}/include)

#vcpkg_fixup_cmake_targets(CONFIG_PATH "lib/cmake/${PORT}")
#vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/nlohmann_json TARGET_PATH share/nlohmann_json)
#file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/bin)
#file(RENAME ${CURRENT_PACKAGES_DIR}/lib/${LIB_NAME}.dll ${CURRENT_PACKAGES_DIR}/bin/${LIB_NAME}.dll
#file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/libxkbcommon RENAME copyright)



#file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/lib ${CURRENT_PACKAGES_DIR}/debug)
#file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin ${CURRENT_PACKAGES_DIR}/debug/bin ${CURRENT_PACKAGES_DIR}/debug/share ${CURRENT_PACKAGES_DIR}/debug/include)

#file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/tools)
#file(RENAME ${CURRENT_PACKAGES_DIR}/debug/bin ${CURRENT_PACKAGES_DIR}/tools/${PORT})

#vcpkg_copy_tool_dependencies(${CURRENT_PACKAGES_DIR}/tools/openexr)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME libxkbcommon)

configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
set(VCPKG_POLICY_EMPTY_PACKAGE enabled)
vcpkg_copy_pdbs()

###
