include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://git.savannah.gnu.org/cgit/gperf.git/snapshot/gperf-master.tar.gz"
    FILENAME "gperf-master.tar.gz"
    SHA512 7db07c92742c8a56a03a8520a6532fb0ab3fb1969d530d34a1ddd766ba6aaa744ada584b871b8f66c3a6c69fbf877a6c3b345613087b24df99d4e6d98d513b56
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    # PATCHES
    #   001_port_fixes.patch
    #   002_more_port_fixes.patch
)

vcpkg_acquire_msys(MSYS_ROOT PACKAGES make diffutils)

set(ENV{PATH} ";$ENV{PATH};${MSYS_ROOT}/usr/bin")
set(BASH ${MSYS_ROOT}/usr/bin/bash.exe)

#     VSINSTALLDIR='C:\Program Files (x86)\Microsoft Visual Studio 14.0'
#     VCINSTALLDIR="${VSINSTALLDIR}"'\VC'
#     PATH=`cygpath -u "${VCINSTALLDIR}"`/bin/amd64:"$PATH"

message(STATUS "Generating MSBuild projects")
vcpkg_execute_required_process(
	SOURCE_PATH ${SOURCE_PATH}
    COMMAND
        ${BASH} --noprofile --norc
		"${SOURCE_PATH}/autogen.sh"
    WORKING_DIRECTORY "${SOURCE_PATH}"
    LOGNAME autogen-${TARGET_TRIPLET}
)

message(STATUS "Generating makefile")
#file(MAKE_DIRECTORY ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET})
vcpkg_execute_required_process(
	SOURCE_PATH ${SOURCE_PATH}
    COMMAND
        ${BASH} --noprofile --norc
#		VCINSTALLDIR="`cygpath -m %(VCToolsInstallDir)bin`"
        "${SOURCE_PATH}/configure"
		--host=x86_64-w64-mingw32
		--prefix=${CURRENT_PACKAGES_DIR} 
		CC="`pwd`/compile cl -nologo"
		CFLAGS="-MD" 
		CXX="`pwd`/compile cl -nologo"
		CXXFLAGS="-MD" 
		CPPFLAGS="-D_WIN32_WINNT=_WIN32_WINNT_WIN8 -I${CURRENT_INSTALLED_DIR}/include" 
		LDFLAGS="-L${CURRENT_INSTALLED_DIR}/lib" 
		LD="link" 
		NM="dumpbin -symbols" 
		STRIP=":" 
		AR="`pwd`/ar-lib lib"
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









