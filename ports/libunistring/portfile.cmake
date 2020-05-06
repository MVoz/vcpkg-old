include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://ftp.gnu.org/gnu/libunistring/libunistring-latest.tar.gz"
    FILENAME "libunistring-latest.tar.gz"
    SHA512 690082732fbbd47ab4ffbd6f21d85afece0f8e2ded24982f949f4ae52bf0a981b75ea9bc14ab289e0954cde07f31a7a4c2bb65615a8eb5b2bfa65720310b6fc9
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

#vcpkg_acquire_msys(MSYS_ROOT PACKAGES make)
#vcpkg_acquire_msys(MSYS_ROOT PACKAGES diffutils)


# Prepare msys
vcpkg_acquire_msys(MSYS_ROOT)
set(ENV{PATH} ";$ENV{PATH};${MSYS_ROOT}/usr/bin")
set(BASH ${MSYS_ROOT}/usr/bin/bash.exe)
set(CYGPATH ${MSYS_ROOT}/usr/bin/cygpath.exe)

macro(to_msys_path PATH OUTPUT_VAR)
    execute_process(
        COMMAND ${CYGPATH} -au "${PATH}"
        OUTPUT_VARIABLE ${OUTPUT_VAR}
        ERROR_VARIABLE ${OUTPUT_VAR}
        RESULT_VARIABLE error_code
    )
    if(error_code)
        message(FATAL_ERROR "cygpath failed: ${${OUTPUT_VAR}}")
    endif()
    string(REGEX REPLACE "\n" "" ${OUTPUT_VAR} "${${OUTPUT_VAR}}")
endmacro()


#set(VSINSTALLDIR "c:/Program Files (x86)/Microsoft Visual Studio 14.0/VC/bin/amd64/")
#to_msys_path(${VSINSTALLDIR} VCINSTALLDIR)
#set(VCINSTALLDIR ${VSINSTALLDIR})
#set(ENV{PATH} ";${PATH};${VCINSTALLDIR}")

#to_msys_path("${CURRENT_INSTALLED_DIR}/debug/bin" VCPKG_INSTALL_DEBUG_BIN_DIR)
#set(${VCINSTALLDIR} VCINSTALLDIR)
# Select compilers
#set(C_COMPILER "`pwd`/compile cl -nologo" )
#set(CXX_COMPILER "`pwd`/compile cl -nologo" )
#set(LD_COMPILER "link.exe" )
#set(AR_COMPILER "`pwd`/ar-lib lib.exe" )
#set(NM_COMPILER "dumpbin.exe -symbols" )
#CC="`pwd`/compile cl -nologo"
#set(ENV{PATH} ";${PATH};${VCINSTALLDIR}")

#     VSINSTALLDIR='C:\Program Files (x86)\Microsoft Visual Studio 14.0'
#     VCINSTALLDIR="${VSINSTALLDIR}"'\VC'
#     PATH=`cygpath -u "${VCINSTALLDIR}"`/bin/amd64:"$PATH"

#message(STATUS "Generating MSBuild projects")
#vcpkg_execute_required_process(
#	SOURCE_PATH ${SOURCE_PATH}
#    COMMAND
#        ${BASH} --noprofile --norc
#		"${SOURCE_PATH}/autogen.sh"
#    WORKING_DIRECTORY "${SOURCE_PATH}"
#    LOGNAME autogen-${TARGET_TRIPLET}
#)

#     VSINSTALLDIR='C:\Program Files (x86)\Microsoft Visual Studio 14.0'
#     VCINSTALLDIR="${VSINSTALLDIR}"'\VC'
#     PATH=`cygpath -u "${VCINSTALLDIR}"`/bin/amd64:"$PATH"
# Generic options

message(STATUS "Generating makefile")
#file(MAKE_DIRECTORY ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET})
vcpkg_execute_required_process(
	SOURCE_PATH ${SOURCE_PATH}
    COMMAND
        ${BASH}
        "${SOURCE_PATH}/configure"
		--host=x86_64-w64-mingw32
		--prefix=$HOME/msvc
		CC="compile cl -nologo"
		CFLAGS="-MD" 
		CXX="compile cl -nologo"
		CXXFLAGS="-MD" 
		CPPFLAGS="-D_WIN32_WINNT=_WIN32_WINNT_WIN10 -I$HOME/msvc" 
		LDFLAGS="-L$HOME/msvc" 
		LD="link"
		NM="dumpbin -symbols"
		STRIP=":" 
		AR="ar-lib lib"
		RANLIB=":"
    WORKING_DIRECTORY "${SOURCE_PATH}"
    LOGNAME configure-${TARGET_TRIPLET}
)

message(STATUS "Building makefile")
#file(MAKE_DIRECTORY ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET})
vcpkg_execute_required_process(
	SOURCE_PATH ${SOURCE_PATH}
    COMMAND
        ${BASH} --noprofile --norc
        "${SOURCE_PATH}/make"
    WORKING_DIRECTORY "${SOURCE_PATH}"
    LOGNAME makefile-${TARGET_TRIPLET}
)



# Handle copyright
file(INSTALL ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/gperf RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME gperf)



#   - for creating 64-bit binaries: through the following bash commands:

     # Set environment variables for using MSVC 14,
     # for creating native 64-bit Windows executables.

     # Windows C library headers and libraries.
#     WindowsCrtIncludeDir='C:\Program Files (x86)\Windows Kits\10\Include\10.0.10240.0\ucrt'
#     WindowsCrtLibDir='C:\Program Files (x86)\Windows Kits\10\Lib\10.0.10240.0\ucrt\'
#     INCLUDE="${WindowsCrtIncludeDir};$INCLUDE"
#     LIB="${WindowsCrtLibDir}x64;$LIB"

     # Windows API headers and libraries.
#     WindowsSdkIncludeDir='C:\Program Files (x86)\Windows Kits\8.1\Include\'
#     WindowsSdkLibDir='C:\Program Files (x86)\Windows Kits\8.1\Lib\winv6.3\um\'
#     INCLUDE="${WindowsSdkIncludeDir}um;${WindowsSdkIncludeDir}shared;$INCLUDE"
#     LIB="${WindowsSdkLibDir}x64;$LIB"

     # Visual C++ tools, headers and libraries.
#     VSINSTALLDIR='C:\Program Files (x86)\Microsoft Visual Studio 14.0'
#     VCINSTALLDIR="${VSINSTALLDIR}"'\VC'
#     PATH=`cygpath -u "${VCINSTALLDIR}"`/bin/amd64:"$PATH"
#     INCLUDE="${VCINSTALLDIR}"'\include;'"${INCLUDE}"
#     LIB="${VCINSTALLDIR}"'\lib\amd64;'"${LIB}"

#     export INCLUDE LIB

# Handle copyright
# file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/libunistring RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME libunistring)
