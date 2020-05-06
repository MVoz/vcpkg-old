#   CURRENT_BUILDTREES_DIR    = ${VCPKG_ROOT_DIR}\buildtrees\${PORT}
#   CURRENT_PACKAGES_DIR      = ${VCPKG_ROOT_DIR}\packages\${PORT}_${TARGET_TRIPLET}
#   CURRENT_PORT_DIR          = ${VCPKG_ROOT_DIR}\ports\${PORT}
#   CMAKE_CURRENT_LIST_DIR    = ${VCPKG_ROOT_DIR}\ports\${PORT}
#   PORT                      = current port name (zlib, etc)
#   TARGET_TRIPLET            = current triplet (x86-windows, x64-windows-static, etc)
#   VCPKG_CRT_LINKAGE         = C runtime linkage type (static, dynamic)
#   VCPKG_LIBRARY_LINKAGE     = target library linkage type (static, dynamic)
#   VCPKG_ROOT_DIR            = <C:\path\to\current\vcpkg>
#   VCPKG_TARGET_ARCHITECTURE = target architecture (x64, x86, arm)
###

include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://hg.mozilla.org/projects/nspr/archive/tip.tar.bz2"
    FILENAME "nspr.tar.bz2"
    SHA512 09a0e85ec3cf6cb92b4afc02a8e075da933edafb60a4e5e67abd035870ae475f739339ff14ebc0a58bbf3d777deb9bd9557102cc90ef09c49147d718a98eea5d
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)


set(ENV{NO-DEV} True)
vcpkg_find_acquire_program(MOZMAKE)
set(MOZILLABUILD "${DOWNLOADS}/tools/mozmake")

vcpkg_find_acquire_program(MOZ_PYTHON2)
vcpkg_find_acquire_program(MOZ_PYTHON3)
get_filename_component(MOZMAKE_DIR "${MOZMAKE}" DIRECTORY)
#get_filename_component(PYTHON3 "${MOZ_PYTHON3}" DIRECTORY)
set(ENV{PATH} ";$ENV{PATH};${MOZMAKE_DIR};${MOZMAKE_DIR}/../nsis-3.01;${MOZMAKE_DIR}/../msys/bin;${MOZMAKE_DIR}/../python;${MOZMAKE_DIR}/../python3")
message(STATUS ${MOZMAKE})
message(STATUS ${MOZ_PYTHON2})
message(STATUS ${MOZ_PYTHON3})

find_program(PYTHON_EXECUTABLE NAMES python2 HINTS "${MOZMAKE}/../python")
find_program(PYTHON3_EXECUTABLE NAMES python3 HINTS "${MOZMAKE}/../python3")
find_program(BASH_EXECUTABLE NAMES bash HINTS "${MOZMAKE}/../msys/bin")
find_program(TOOL_MAKENSIS NAMES "makensis-3.01.exe" HINTS "${MOZMAKE}/../nsis-3.01")

get_filename_component(MSYS_DIR "${BASH_EXECUTABLE}" DIRECTORY)
#set(ENV{PATH} ";$ENV{PATH};${MSYS_DIR};")


# Insert msys into the path between the compiler toolset and windows system32. This prevents masking of "link.exe" but DOES mask "find.exe".
string(REPLACE ";$ENV{SystemRoot}\\system32;" ";${MSYS_DIR};$ENV{SystemRoot}\\system32;" NEWPATH "$ENV{PATH}")
string(REPLACE ";$ENV{SystemRoot}\\System32;" ";${MSYS_DIR};$ENV{SystemRoot}\\System32;" NEWPATH "${NEWPATH}")
set(ENV{PATH} "${NEWPATH}")


set(PYTHON2 ${PYTHON_EXECUTABLE})
set(PYTHON3 ${PYTHON3_EXECUTABLE})
set(BASH ${MSYS_DIR}/bash.exe)

message(STATUS ${PYTHON2})
message(STATUS ${BASH_EXECUTABLE})
message(STATUS ${MOZILLABUILD})

set(CONFIGURE_OPTIONS "${CONFIGURE_OPTIONS} --target=x86_64-pc-mingw32 --enable-64bit")
#set(CONFIGURE_OPTIONS "${CONFIGURE_OPTIONS} --target=i686-pc-mingw32")

#if(VCPKG_LIBRARY_LINKAGE STREQUAL "dynamic")
#    set(CONFIGURE_OPTIONS "${CONFIGURE_OPTIONS} --disable-static --enable-shared")
#else()
#    set(CONFIGURE_OPTIONS "${CONFIGURE_OPTIONS} --enable-static --disable-shared")
#endif()

set(CONFIGURE_OPTIONS_RELASE "--disable-debug --prefix=${CURRENT_PACKAGES_DIR}")
set(CONFIGURE_OPTIONS_DEBUG  "--enable-debug --prefix=${CURRENT_PACKAGES_DIR}/debug")

    if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "release")
        # Configure release
        message(STATUS "Configuring ${TARGET_TRIPLET}-rel")
        file(REMOVE_RECURSE ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel)
        file(MAKE_DIRECTORY ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel)
        vcpkg_execute_required_process(
            COMMAND ${BASH} --noprofile --norc -c
                "${SOURCE_PATH}/mozilla/nsprpub/configure ${CONFIGURE_OPTIONS} ${CONFIGURE_OPTIONS_RELASE}"
            WORKING_DIRECTORY "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel"
            LOGNAME "configure-${TARGET_TRIPLET}-rel")
        message(STATUS "Configuring ${TARGET_TRIPLET}-rel done")
    endif()
    if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "debug")
        # Configure debug
        message(STATUS "Configuring ${TARGET_TRIPLET}-dbg")
        file(REMOVE_RECURSE ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg)
        file(MAKE_DIRECTORY ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg)
        vcpkg_execute_required_process(
            COMMAND ${BASH} --noprofile --norc -c
                "${SOURCE_PATH}/mozilla/nsprpub/configure ${CONFIGURE_OPTIONS} ${CONFIGURE_OPTIONS_DEBUG}"
            WORKING_DIRECTORY "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg"
            LOGNAME "configure-${TARGET_TRIPLET}-dbg")
        message(STATUS "Configuring ${TARGET_TRIPLET}-dbg done")
    endif()

if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "release")
    # Build release
    message(STATUS "Package ${TARGET_TRIPLET}-rel")
    vcpkg_execute_build_process(
        COMMAND ${BASH} --noprofile --norc -c "${MOZMAKE} -j1"# ${VCPKG_CONCURRENCY} - error Waiting for unfinished jobs....
        WORKING_DIRECTORY "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel"
        LOGNAME "make-build-${TARGET_TRIPLET}-rel")
    vcpkg_execute_build_process(
        COMMAND ${BASH} --noprofile --norc -c "${MOZMAKE} install"
        WORKING_DIRECTORY "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel"
        LOGNAME "make-install-${TARGET_TRIPLET}-rel")
    message(STATUS "Package ${TARGET_TRIPLET}-rel done")
endif()

if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "debug")
    # Build debug
    message(STATUS "Package ${TARGET_TRIPLET}-dbg")
    vcpkg_execute_build_process(
        COMMAND ${BASH} --noprofile --norc -c "${MOZMAKE} -j1"# ${VCPKG_CONCURRENCY} - error Waiting for unfinished jobs....
        WORKING_DIRECTORY "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg"
        LOGNAME "make-build-${TARGET_TRIPLET}-dbg")
    vcpkg_execute_build_process(
        COMMAND ${BASH} --noprofile --norc -c "${MOZMAKE} install"
        WORKING_DIRECTORY "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg"
        LOGNAME "make-install-${TARGET_TRIPLET}-dbg")
    message(STATUS "Package ${TARGET_TRIPLET}-dbg done")
endif()

#mkdir target.debug
#cd target.debug
# run the configure script
#../mozilla/nsprpub/configure [optional configure options]
# build the libraries
#gmake

### https://mesonbuild.com/Configuring-a-build-directory.html
#vcpkg_configure_meson(
#	SOURCE_PATH ${SOURCE_PATH}
#    OPTIONS
#		--backend=ninja
#)

#vcpkg_install_meson()

###
#vcpkg_install_msbuild(
#    SOURCE_PATH ${SOURCE_PATH}
#    PROJECT_SUBPATH "ide/vs2017/mimalloc.vcxproj"
#	TARGET restore
#	SKIP_CLEAN
#	LICENSE_SUBPATH LICENSE
#	LICENSE_SUBPATH LICENSE
#	ALLOW_ROOT_INCLUDES ON
#	USE_VCPKG_INTEGRATION
#)

#vcpkg_build_msbuild(
#    PROJECT_PATH ${SOURCE_PATH}/ports/MSVC++/2015/win32/libmpg123/libmpg123.vcxproj
#    RELEASE_CONFIGURATION Release_x86${MPG123_CONFIGURATION_SUFFIX}
#    DEBUG_CONFIGURATION Debug_x86${MPG123_CONFIGURATION_SUFFIX}
#)

#file(TO_NATIVE_PATH "${CURRENT_INSTALLED_DIR}/include" PGSQL_INCLUDE_DIR)

#file(COPY ${SOURCE_PATH}/greatest.h DESTINATION ${CURRENT_PACKAGES_DIR}/include)

#vcpkg_fixup_cmake_targets(CONFIG_PATH "lib/cmake/${PORT}")
#vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/nlohmann_json TARGET_PATH share/nlohmann_json)
#file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/bin)
#file(RENAME ${CURRENT_PACKAGES_DIR}/lib/${LIB_NAME}.dll ${CURRENT_PACKAGES_DIR}/bin/${LIB_NAME}.dll
#file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/nspr RENAME copyright)

#file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/lib ${CURRENT_PACKAGES_DIR}/debug)
#file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin ${CURRENT_PACKAGES_DIR}/debug/bin ${CURRENT_PACKAGES_DIR}/debug/share ${CURRENT_PACKAGES_DIR}/debug/include)

#file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/tools)
#file(RENAME ${CURRENT_PACKAGES_DIR}/debug/bin ${CURRENT_PACKAGES_DIR}/tools/${PORT})

#vcpkg_copy_tool_dependencies(${CURRENT_PACKAGES_DIR}/tools/openexr)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME nspr)

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE00 ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
