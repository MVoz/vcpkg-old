include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO wren-lang/wren
    REF a8fd838255d98d753d452fd4b563be15bf0a677e
    SHA512 781f4f306c38bbd356087d56fe8bdb55e8dc03cf29376d3d0bbc5ce5739eec711777eafe97f9820c3a7569c16da05774f0041a79930aa6de3e2b3fa2c2de63ce
    HEAD_REF master
)

file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH})

set(FEATURE_CLI Off)
set(FEATURE_META Off)
set(FEATURE_RANDOM Off)
if("cli" IN_LIST FEATURES)
	set(FEATURE_CLI On)
endif()
if("meta" IN_LIST FEATURES)
	set(FEATURE_META On)
endif()
if("random" IN_LIST FEATURES)
	set(FEATURE_RANDOM On)
endif()

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS_DEBUG
		-DWREN_ENABLE_CLI=Off
    OPTIONS_RELEASE
		-DWREN_ENABLE_CLI=${FEATURE_CLI}
    OPTIONS
		-DWREN_ENABLE_META=${FEATURE_META}
		-DWREN_ENABLE_RANDOM=${FEATURE_RANDOM}
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets()

vcpkg_copy_pdbs()

# exec
if(FEATURE_CLI)
    if(TARGET_TRIPLET MATCHES "^.*(uwp|windows).*$")
	   file(COPY ${CURRENT_PACKAGES_DIR}/bin/wren-cli.exe DESTINATION ${CURRENT_PACKAGES_DIR}/tools/)
       file(REMOVE ${CURRENT_PACKAGES_DIR}/bin/wren-cli.exe)
    else()
       file(COPY ${CURRENT_PACKAGES_DIR}/bin/wren-cli DESTINATION ${CURRENT_PACKAGES_DIR}/tools/)
       file(REMOVE ${CURRENT_PACKAGES_DIR}/bin/wren-cli)
    endif()
    if(VCPKG_LIBRARY_LINKAGE STREQUAL static)
        file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin ${CURRENT_PACKAGES_DIR}/debug/bin)
    endif()
endif()

# debug includes
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/wren RENAME copyright)
