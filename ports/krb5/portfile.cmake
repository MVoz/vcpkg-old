# Common Ambient Variables:
#   CURRENT_BUILDTREES_DIR    = ${VCPKG_ROOT_DIR}\buildtrees\${PORT}
#   CURRENT_PACKAGES_DIR      = ${VCPKG_ROOT_DIR}\packages\${PORT}_${TARGET_TRIPLET}
#   CURRENT_PORT_DIR          = ${VCPKG_ROOT_DIR}\ports\${PORT}
#   PORT                      = current port name (zlib, etc)
#   TARGET_TRIPLET            = current triplet (x86-windows, x64-windows-static, etc)
#   VCPKG_CRT_LINKAGE         = C runtime linkage type (static, dynamic)
#   VCPKG_LIBRARY_LINKAGE     = target library linkage type (static, dynamic)
#   VCPKG_ROOT_DIR            = <C:\path\to\current\vcpkg>
#   VCPKG_TARGET_ARCHITECTURE = target architecture (x64, x86, arm)
#
include(vcpkg_common_functions)

message(WARNING "\nHelp to improve PORT and add ARCH with STATIC\n"
	""
	)

if(VCPKG_CMAKE_SYSTEM_NAME)
    message(FATAL_ERROR "\nThis port is only for building krb5 on Windows Desktop\n")
endif()



#vcpkg_check_linkage(ONLY_DYNAMIC_LIBRARY AND VCPKG_LIBRARY_LINKAGE STREQUAL "static")

#if(TARGET_TRIPLET MATCHES "^(arm-|arm64)")
#    message(FATAL_ERROR "\nkrb5 doesn't support 32-bit or 64-bit ARM architecture."
#	)
#elseif(TARGET_TRIPLET MATCHES "^arm64")
#    message(FATAL_ERROR "\nkrb5 doesn't support ARM64 architecture currently.\n"
#	"\nOnly for building krb5 on x64\n"
#	)
#endif()

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/krb5/krb5/archive/krb5-1.17-final.tar.gz"
    FILENAME "krb5-1.17-final.tar.gz"
    SHA512 752f3b6eac83e2936af78f97839d5a99b0dd73e89efd0f0d0695a44f5e848518fdd284a4d7609f78363ffcb8a46d581935d39b466cc3a33d4dc2de458110c14a
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE} 
    # (Optional) A friendly name to use instead of the filename of the archive (e.g.: a version number or tag).
    # REF 1.0.0
    # (Optional) Read the docs for how to generate patches at: 
    # https://github.com/Microsoft/vcpkg/blob/master/docs/examples/patching.md
    # PATCHES
    #   001_port_fixes.patch
    #   002_more_port_fixes.patch
)

vcpkg_find_acquire_program(GIT)
find_program(GIT NAMES git git.cmd)

# sed and awk are installed with git but in a different directory
get_filename_component(GIT_EXE_PATH ${GIT} DIRECTORY)
set(SED_EXE_PATH "${GIT_EXE_PATH}/../usr/bin")

# openblas require perl to generate .def for exports
vcpkg_find_acquire_program(PERL)
get_filename_component(PERL_EXE_PATH ${PERL} DIRECTORY)
set(ENV{PATH} "$ENV{PATH};${PERL_EXE_PATH}")
set(ENV{PATH} "$ENV{PATH};${PERL_EXE_PATH};${SED_EXE_PATH}")

find_program(SED sed)
find_program(CAT cat)
find_program(CP cp)
find_program(AWK awk)

find_program(NMAKE nmake)

# Debug build
message(STATUS "very, very long compilation")
message(STATUS "Building ${TARGET_TRIPLET}-dgb")

## Ignore ??? TARGET_TRIPLET and VCPKG_TARGET_ARCHITECTURE

#if(TARGET_TRIPLET MATCHES "^x86")
#if(VCPKG_TARGET_ARCHITECTURE STREQUAL "x86")
#	set(PROCESSOR_ARCHITECTURE i386)
#	set(BITS 32)
#	set(CPU i386)
#elseif(VCPKG_TARGET_ARCHITECTURE STREQUAL "x64")
#	set(PROCESSOR_ARCHITECTURE AMD64)
#    set(BITS 64)
#	set(CPU AMD64)
#endif()

if(VCPKG_TARGET_ARCHITECTURE STREQUAL x64)
    set(CMAKE_SYSTEM_PROCESSOR AMD64)
else()
    set(CMAKE_SYSTEM_PROCESSOR ${VCPKG_TARGET_ARCHITECTURE})
endif()


# COMMAND ${NMAKE} VERBOSE=1 /NOLOGO -f Makefile.in prep-windows CPU=i386 BITS=32
if(VCPKG_TARGET_ARCHITECTURE STREQUAL "x86")

set(VCPKG_TARGET_ARCHITECTURE x86)
set(VCPKG_HOST_ARCHITECTURE x86)

set(CMAKE_TARGET_ARCHITECTURE x86)
set(CMAKE_HOST_ARCHITECTURE x86)

set(target_architecture x86)
set(host_architectures x86)

set(VCPKG_CMAKE_SYSTEM_PROCESSOR x86)
set(CMAKE_HOST_SYSTEM_PROCESSOR x86)
set(TARGET_CPU x86)
set(VCPKG_TARGET_TRIPLET_ARCH x86)
set(CMAKE_GENERATOR_PLATFORM Win32)
set(CMAKE_SYSTEM_PROCESSOR x86)
set(CMAKE_VS_PLATFORM_TOOLSET_HOST_ARCHITECTURE x86)
vcpkg_execute_required_process(
	COMMAND ${NMAKE} VERBOSE=1 /NOLOGO -f Makefile.in CPU=i386 prep-windows
	WORKING_DIRECTORY ${SOURCE_PATH}/src
	LOGNAME prep-windows-${TARGET_TRIPLET}-${CMAKE_BUILD_TYPE}-dbg
)
#vcpkg_execute_required_process(
#	COMMAND ${NMAKE} VERBOSE=1 /NOLOGO -f Makefile CPU=i386 clean
#	WORKING_DIRECTORY ${SOURCE_PATH}/src
#	LOGNAME clean-${TARGET_TRIPLET}-${CMAKE_BUILD_TYPE}-dbg
#)
	vcpkg_execute_required_process(
	COMMAND ${NMAKE} VERBOSE=1 /NOLOGO -f Makefile CPU=i386
	WORKING_DIRECTORY ${SOURCE_PATH}/src
	LOGNAME nmake-build-${TARGET_TRIPLET}-debug
)

file(MAKE_DIRECTORY "${CURRENT_PACKAGES_DIR}/debug")

vcpkg_execute_required_process(
	COMMAND ${NMAKE} VERBOSE=1 /NOLOGO -f Makefile CPU=i386 KRB_INSTALL_DIR=${CURRENT_PACKAGES_DIR}/debug install
	WORKING_DIRECTORY ${SOURCE_PATH}/src
	LOGNAME install-${TARGET_TRIPLET}-${CMAKE_BUILD_TYPE}-dbg
)
message(STATUS "Building ${TARGET_TRIPLET}-dbg done")

# Release build
message(STATUS "Building ${TARGET_TRIPLET}-rel")
#vcpkg_execute_required_process(
#	COMMAND ${NMAKE} VERBOSE=1 /NOLOGO -f Makefile.in prep-windows
#	WORKING_DIRECTORY ${SOURCE_PATH}/src
#	LOGNAME prep-windows-${TARGET_TRIPLET}-${CMAKE_BUILD_TYPE}-rel
#)
vcpkg_execute_required_process(
	COMMAND ${NMAKE} VERBOSE=1 /NOLOGO -f Makefile CPU=i386 clean
	WORKING_DIRECTORY ${SOURCE_PATH}/src
	LOGNAME clean-${TARGET_TRIPLET}-${CMAKE_BUILD_TYPE}-rel
)
vcpkg_execute_required_process(
	COMMAND ${NMAKE} VERBOSE=1 /NOLOGO -f Makefile NODEBUG=1 CPU=i386
	WORKING_DIRECTORY ${SOURCE_PATH}/src
	LOGNAME nmake-build-${TARGET_TRIPLET}-rel
)
vcpkg_execute_required_process(
	COMMAND ${NMAKE} VERBOSE=1 /NOLOGO -f Makefile NODEBUG=1 CPU=i386 KRB_INSTALL_DIR=${CURRENT_PACKAGES_DIR} install
	WORKING_DIRECTORY ${SOURCE_PATH}/src
	LOGNAME install-${TARGET_TRIPLET}-${CMAKE_BUILD_TYPE}-rel
)
message(STATUS "Building ${TARGET_TRIPLET}-rel done")

else(VCPKG_TARGET_ARCHITECTURE STREQUAL "x64")
set(ENV{PROCESSOR_ARCHITECTURE} AMD64)
set(ENV{CPU} AMD64)
set(ENV{BITS} 64)

vcpkg_execute_required_process(
	COMMAND ${NMAKE} VERBOSE=1 /NOLOGO -f Makefile.in prep-windows CPU=AMD64
	WORKING_DIRECTORY ${SOURCE_PATH}/src
	LOGNAME prep-windows-${TARGET_TRIPLET}-${CMAKE_BUILD_TYPE}-dbg
)
vcpkg_execute_required_process(
	COMMAND ${NMAKE} VERBOSE=1 /NOLOGO -f Makefile clean CPU=AMD64
	WORKING_DIRECTORY ${SOURCE_PATH}/src
	LOGNAME clean-${TARGET_TRIPLET}-${CMAKE_BUILD_TYPE}-dbg
)
	vcpkg_execute_required_process(
	COMMAND ${NMAKE} VERBOSE=1 /NOLOGO -f Makefile CPU=AMD64
	WORKING_DIRECTORY ${SOURCE_PATH}/src
	LOGNAME nmake-build-${TARGET_TRIPLET}-debug
)

file(MAKE_DIRECTORY "${CURRENT_PACKAGES_DIR}/debug")

vcpkg_execute_required_process(
	COMMAND ${NMAKE} VERBOSE=1 /NOLOGO -f Makefile install CPU=AMD64 KRB_INSTALL_DIR=${CURRENT_PACKAGES_DIR}/debug
	WORKING_DIRECTORY ${SOURCE_PATH}/src
	LOGNAME install-${TARGET_TRIPLET}-${CMAKE_BUILD_TYPE}-dbg
)
message(STATUS "Building ${TARGET_TRIPLET}-dbg done")

# Release build
message(STATUS "Building ${TARGET_TRIPLET}-rel")
#vcpkg_execute_required_process(
#	COMMAND ${NMAKE} VERBOSE=1 /NOLOGO -f Makefile.in prep-windows  PROCESSOR_ARCHITECTURE=AMD64 CPU=AMD64 BITS=64
#	WORKING_DIRECTORY ${SOURCE_PATH}/src
#	LOGNAME prep-windows-${TARGET_TRIPLET}-${CMAKE_BUILD_TYPE}-rel
#)
vcpkg_execute_required_process(
	COMMAND ${NMAKE} VERBOSE=1 /NOLOGO -f Makefile clean CPU=AMD64
	WORKING_DIRECTORY ${SOURCE_PATH}/src
	LOGNAME clean-${TARGET_TRIPLET}-${CMAKE_BUILD_TYPE}-rel
)
vcpkg_execute_required_process(
	COMMAND ${NMAKE} VERBOSE=1 /NOLOGO -f Makefile NODEBUG=1 CPU=AMD64
	WORKING_DIRECTORY ${SOURCE_PATH}/src
	LOGNAME nmake-build-${TARGET_TRIPLET}-rel
)
vcpkg_execute_required_process(
	COMMAND ${NMAKE} VERBOSE=1 /NOLOGO -f Makefile NODEBUG=1 install CPU=AMD64 KRB_INSTALL_DIR=${CURRENT_PACKAGES_DIR}
	WORKING_DIRECTORY ${SOURCE_PATH}/src
	LOGNAME install-${TARGET_TRIPLET}-${CMAKE_BUILD_TYPE}-rel
)
message(STATUS "Building ${TARGET_TRIPLET}-rel done")
endif()

file(INSTALL ${SOURCE_PATH}/doc/copyright.rst DESTINATION ${CURRENT_PACKAGES_DIR}/share/krb5 RENAME copyright)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include ${CURRENT_PACKAGES_DIR}/debug/bin ${CURRENT_PACKAGES_DIR}/bin)
set(VCPKG_POLICY_EMPTY_PACKAGE enabled)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME krb5)
