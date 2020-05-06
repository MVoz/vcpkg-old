include(vcpkg_common_functions)

find_program(GIT NAMES git git.cmd)
#set(GIT_URL "https://github.com/aseprite/skia")
set(GIT_URL "https://github.com/skui-org/skia")
set(GIT_REV m75)
set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/${PORT})
if(NOT EXISTS "${SOURCE_PATH}/.git")
	message(STATUS "Cloning and fetching submodules")
	vcpkg_execute_required_process(
	  COMMAND ${GIT} clone --recurse-submodules ${GIT_URL} ${SOURCE_PATH}
	  WORKING_DIRECTORY ${SOURCE_PATH}
	  LOGNAME clone
	)
	message(STATUS "Checkout revision ${GIT_REV}")
	vcpkg_execute_required_process(
	  COMMAND ${GIT} checkout ${GIT_REV}
	  WORKING_DIRECTORY ${SOURCE_PATH}
	  LOGNAME checkout
	)
endif()

set(ENV{NO-DEV} True)
set(ENV{NINJA_STATUS} "[%r processes, %f/%t @ %o/s : %es ]")
set(ENV{GYP_MSVS_VERSION} 2017)
set(ENV{DEPOT_TOOLS_WIN_TOOLCHAIN} 0)
set(ENV{DEPOT_TOOLS_UPDATE} 0)


vcpkg_find_acquire_program(NINJA)
vcpkg_find_acquire_program(PYTHON2)
get_filename_component(PYTHON2_DIR "${PYTHON2}" DIRECTORY)
set(ENV{GIT_EXECUTABLE} ${GIT})
set(ENV{PATH} "$ENV{PATH};${PYTHON2_DIR};${CURRENT_INSTALLED_DIR}/tools/gn")

#vcpkg_execute_required_process(
#    COMMAND ${PYTHON2} git-sync-deps
#    WORKING_DIRECTORY ${SOURCE_PATH}/tools
#    LOGNAME sync-deps-${TARGET_TRIPLET}
#)

vcpkg_execute_required_process(
    COMMAND gn gen out/Shared "--args=is_official_build=true is_component_build=true" --ide=json --root=${SOURCE_PATH}
    WORKING_DIRECTORY ${SOURCE_PATH}
    LOGNAME gen-${TARGET_TRIPLET}
)

#is_official_build=true skia_use_system_expat=false skia_use_system_libjpeg_turbo=false skia_use_system_libpng=false skia_use_system_libwebp=false skia_use_system_zlib=false target_cpu=""x86"" msvc=2017

execute_process(
#    COMMAND ${CMAKE_COMMAND} -E env
    COMMAND ${NINJA} -j1
    WORKING_DIRECTORY ${SOURCE_PATH}/out/Shared
    RESULT_VARIABLE build-${TARGET_TRIPLET}
)

#file(TO_NATIVE_PATH "${CURRENT_INSTALLED_DIR}/include" PGSQL_INCLUDE_DIR)

#file(COPY ${SOURCE_PATH}/greatest.h DESTINATION ${CURRENT_PACKAGES_DIR}/include)

#vcpkg_fixup_cmake_targets(CONFIG_PATH "lib/cmake/${PORT}")
#vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/nlohmann_json TARGET_PATH share/nlohmann_json)
#file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/bin)
#file(RENAME ${CURRENT_PACKAGES_DIR}/lib/${LIB_NAME}.dll ${CURRENT_PACKAGES_DIR}/bin/${LIB_NAME}.dll
#file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/skia RENAME copyright)

#file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/lib ${CURRENT_PACKAGES_DIR}/debug)
#file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin ${CURRENT_PACKAGES_DIR}/debug/bin ${CURRENT_PACKAGES_DIR}/debug/share ${CURRENT_PACKAGES_DIR}/debug/include)

#file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/tools)
#file(RENAME ${CURRENT_PACKAGES_DIR}/debug/bin ${CURRENT_PACKAGES_DIR}/tools/${PORT})

#vcpkg_copy_tool_dependencies(${CURRENT_PACKAGES_DIR}/tools/openexr)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME skia)
#file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH})

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
