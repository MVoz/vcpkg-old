# Common Ambient Variables:
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

#string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "static" KEYSTONE_BUILD_STATIC)
#string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "dynamic" KEYSTONE_BUILD_SHARED)
#vcpkg_configure_cmake(
#    SOURCE_PATH ${SOURCE_PATH}
#    PREFER_NINJA
#    OPTIONS
#        -DKEYSTONE_BUILD_STATIC=${KEYSTONE_BUILD_STATIC}
#        -DKEYSTONE_BUILD_SHARED=${KEYSTONE_BUILD_SHARED}
#)
#string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "static" CURL_STATICLIB)
#vcpkg_check_linkage(ONLY_STATIC_LIBRARY) ## = ## VCPKG_LIBRARY_LINKAGE=static ## = ## BUILD_STATIC_LIBS=ON
#vcpkg_check_linkage(ONLY_STATIC_LIBRARY ONLY_DYNAMIC_CRT) 
#vcpkg_check_linkage(ONLY_DYNAMIC_LIBRARY) 
###

include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://ftp.mozilla.org/pub/security/nss/releases/NSS_3_44_1_RTM/src/nss-3.44.1-with-nspr-4.21.tar.gz"
    FILENAME "nss-3.44.1-with-nspr-4.21.tar.gz"
    SHA512 49139cbc7754b9bf26d12ac8c4bc9953b74f4a0fec7eac5f1cd2eed05d73aea49fabc8553d377e0a7efd0d5ae673b95c1c3049b9e86a4fe1ab33595875053298
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
#    PATCHES
#        001_port_fixes.patch
#        002_more_port_fixes.patch
)



#if(NOT EXISTS "${SOURCE_PATH}/.git")
#	message(STATUS "Cloning and fetching submodules")
#	set(error_code 1)
#	set(number_of_tries 0)
#	while(error_code AND number_of_tries LESS 3)
#	  execute_process(
#	  COMMAND ${GIT} clone --recurse-submodules --progress ${GIT_URL} ${SOURCE_PATH}
#	  WORKING_DIRECTORY ${SOURCE_PATH}
#	  RESULT_VARIABLE error_code
#	)
#	math(EXPR number_of_tries "${number_of_tries} + 1")
#	endwhile()
#	if(number_of_tries GREATER 1)
#		message(STATUS "Had to git clone more than once:	${number_of_tries} times.")
#	endif()
#	if(error_code)
#		message(FATAL_ERROR "Failed to clone repository: '${GIT_URL}'")
#	endif()
#	message(STATUS "Checkout revision ${GIT_REV}")
#	vcpkg_execute_required_process(
#	  COMMAND ${GIT} checkout ${GIT_REV}
#	  WORKING_DIRECTORY ${SOURCE_PATH}
#	  LOGNAME checkout
#	)
#endif()


#vcpkg_from_bitbucket(
#set(OPENEXR_VERSION 2.3.0)
#set(OPENEXR_HASH 268ae64b40d21d662f405fba97c307dad1456b7d996a447aadafd41b640ca736d4851d9544b4741a94e7b7c335fe6e9d3b16180e710671abfc0c8b2740b147b2)
#vcpkg_from_github(
#  OUT_SOURCE_PATH SOURCE_PATH
#  REPO openexr/openexr
#  REF v${OPENEXR_VERSION}
#  SHA512 ${OPENEXR_HASH}
#  HEAD_REF master
#  PATCHES
#    fix_clang_not_setting_modern_cplusplus.patch
#    fix_install_ilmimf.patch
#)

#vcpkg_find_acquire_program(PYTHON3)
#vcpkg_find_acquire_program(QT5)
#vcpkg_find_acquire_program(TEXLIVE)
#vcpkg_find_acquire_program(XGETTEXT)
#vcpkg_find_acquire_program(DOXYGEN)
#vcpkg_find_acquire_program(DOXYGEN)
#vcpkg_find_acquire_program(PERL)
#vcpkg_find_acquire_program(FLEX)
#vcpkg_find_acquire_program(BISON)
#get_filename_component(FLEX_DIR "${FLEX}" DIRECTORY)
#get_filename_component(BISON_DIR "${BISON}" DIRECTORY)
#get_filename_component(DOXYGEN_DIR "${DOXYGEN}" DIRECTORY)
#get_filename_component(PERL_DIR "${PERL}" DIRECTORY)
#get_filename_component(QT5_DIR "${QT5}" DIRECTORY)
#get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
#get_filename_component(DOXYGEN_DIR "${DOXYGEN}" DIRECTORY)
#get_filename_component(XGETTEXT_DIR "${XGETTEXT}" DIRECTORY)
#get_filename_component(TEXLIVE_DIR "${TEXLIVE}" DIRECTORY)
#set(ENV{PATH} ";$ENV{PATH};${QT5_DIR};${PYTHON3_DIR};${DOXYGEN_DIR};${XGETTEXT_DIR};${TEXLIVE_DIR};${FLEX_DIR};${BISON_DIR};${DOXYGEN_DIR};${PERL_DIR}")
#vcpkg_find_acquire_program(YASM)
#get_filename_component(YASM_EXE_PATH ${YASM} DIRECTORY)
#set(ENV{PATH} "$ENV{PATH};${YASM_EXE_PATH}")

#file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH})


set(ENV{NO-DEV} True)
vcpkg_find_acquire_program(MOZMAKE)
set(MOZILLABUILD "${DOWNLOADS}/tools/mozmake")

vcpkg_find_acquire_program(GYP)


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
#        file(MAKE_DIRECTORY ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel)

#        vcpkg_execute_required_process(
		execute_process(
#            COMMAND ${BASH} --noprofile --norc -c "make -C nss nss_build_all USE_64=1"
			COMMAND "${BASH} --noprofile --norc -c \"./build.sh --target=x64 --disable-tests --msvc --system-nspr=${CURRENT_INSTALLED_DIR} --nspr\""
            WORKING_DIRECTORY "${SOURCE_PATH}/nss"
#            LOGNAME "configure-${TARGET_TRIPLET}-rel")
)
        message(STATUS "Configuring ${TARGET_TRIPLET}-rel done")
    endif()
    if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "debug")
        # Configure debug
        message(STATUS "Configuring ${TARGET_TRIPLET}-dbg")
        file(REMOVE_RECURSE ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg)
#        file(MAKE_DIRECTORY ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg)
#        vcpkg_execute_required_process(
		execute_process(
#            COMMAND ${BASH} --noprofile --norc -c "make -C nss nss_build_all USE_64=1"
			COMMAND "${BASH} --noprofile --norc -c \"./build.sh --target=x64 --disable-tests --msvc --system-nspr=${CURRENT_INSTALLED_DIR} --nspr\""
			WORKING_DIRECTORY "${SOURCE_PATH}/nss"
#            LOGNAME "configure-${TARGET_TRIPLET}-dbg")
)
        message(STATUS "Configuring ${TARGET_TRIPLET}-dbg done")
    endif()

if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "release")
    # Build release
    message(STATUS "Package ${TARGET_TRIPLET}-rel")
    vcpkg_execute_build_process(
        COMMAND ${BASH} --noprofile --norc -c "make -j1 USE_64=1" # ${VCPKG_CONCURRENCY} - error Waiting for unfinished jobs....
            WORKING_DIRECTORY "${SOURCE_PATH}/nss")
    vcpkg_execute_build_process(
        COMMAND ${BASH} --noprofile --norc -c "make -j1 USE_64=1 install"
            WORKING_DIRECTORY "${SOURCE_PATH}/nss")
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
#file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/nss RENAME copyright)

#file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/lib ${CURRENT_PACKAGES_DIR}/debug)
#file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin ${CURRENT_PACKAGES_DIR}/debug/bin ${CURRENT_PACKAGES_DIR}/debug/share ${CURRENT_PACKAGES_DIR}/debug/include)

#file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/tools)
#file(RENAME ${CURRENT_PACKAGES_DIR}/debug/bin ${CURRENT_PACKAGES_DIR}/tools/${PORT})

#vcpkg_copy_tool_dependencies(${CURRENT_PACKAGES_DIR}/tools/openexr)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME nss)

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
