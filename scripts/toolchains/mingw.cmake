# http://www.cmake.org/Wiki/CMake_Cross_Compiling#The_toolchain_file
# Help improve and optimize

SET(IS_CROSSCOMPILING "YES")
SET(CMAKE_SYSTEM_VERSION 1)

#SET(CMAKE_SHARED_LIBRARY_LINK_C_FLAGS "")
#SET(CMAKE_SHARED_LIBRARY_LINK_CXX_FLAGS "")

#Detect .vcpkg-root to figure VCPKG_ROOT_DIR
SET(VCPKG_ROOT_DIR_CANDIDATE ${CMAKE_CURRENT_LIST_DIR})
while(IS_DIRECTORY ${VCPKG_ROOT_DIR_CANDIDATE} AND NOT EXISTS "${VCPKG_ROOT_DIR_CANDIDATE}/.vcpkg-root")
    get_filename_component(VCPKG_ROOT_DIR_TEMP ${VCPKG_ROOT_DIR_CANDIDATE} DIRECTORY)
    if (VCPKG_ROOT_DIR_TEMP STREQUAL VCPKG_ROOT_DIR_CANDIDATE) # If unchanged, we have reached the root of the drive
        message(FATAL_ERROR "Could not find .vcpkg-root")
    else()
        SET(VCPKG_ROOT_DIR_CANDIDATE ${VCPKG_ROOT_DIR_TEMP})
    endif()
endwhile()

set(VCPKG_ROOT_DIR ${VCPKG_ROOT_DIR_CANDIDATE})

#set(MSYS_ROOT "I:/msys2")
#set(ENV{MSYS_ROOT} "I:/msys2")

if(DEFINED $ENV{MSYS_ROOT})
	set(MSYS_ROOT I:/msys2)
else()	
#    set(MSYS_ROOT "${VCPKG_ROOT_DIR}/downloads/tools/msys2/msys64")
#else()	
	# Example full path
	set(MSYS_ROOT "I:/msys2")
endif()

if(NOT _VCPKG_MINGW_TOOLCHAIN)
SET(_VCPKG_MINGW_TOOLCHAIN 1)
get_property( _CMAKE_IN_TRY_COMPILE GLOBAL PROPERTY IN_TRY_COMPILE )
if(NOT _CMAKE_IN_TRY_COMPILE)

if(VCPKG_TARGET_TRIPLET MATCHES mingw32)
	set(CONFIG_ARCHITECTURE x86)
	set(MINGW32 ${MSYS_ROOT}/mingw32/)
	set(MINGW ${MSYS_ROOT}/mingw32/)
    set(CMAKE_SYSTEM_PROCESSOR i686)
    set(BITS 32)
	set(MSYSTEM MINGW32)
	set(MSYSTEM_CHOST "i686-w64-mingw32")
	set(arch i686)
	set(CARCH "i686")
	set(CHOST "i686-w64-mingw32")
	set(MINGW_CHOST "i686-w64-mingw32")
	set(MINGW_PREFIX "/mingw32/")
	set(MINGW_PACKAGE_PREFIX "mingw-w64-i686")
	set(tune generic)
	set(CARCH "i686")
	set(CHOST "i686-w64-mingw32")
	
# -march (or -mcpu) builds exclusively for an architecture
# -mtune optimizes for an architecture, but builds for whole processor family

	set(CPPFLAGS=" -D_FORTIFY_SOURCE=2 -D__USE_MINGW_ANSI_STDIO=1 ${CPPFLAGS} ")
	set(CFLAGS=" -march=i686 -mtune=generic -g0 -O2 -pipe -Wl,-S ${CFLAGS} ")
	set(CXXFLAGS=" -march=i686 -mtune=generic -g0 -O2 -pipe -Wl,-S ${CXXFLAGS} ")
#	set(LDFLAGS="${LDFLAGS} -pipe -Wl")
# Uncomment to enable hardening (ASLR, DEP)
#LDFLAGS="-pipe -Wl,--dynamicbase,--nxcompat"
#-- Make Flags: change this for DistCC/SMP systems

elseif(VCPKG_TARGET_TRIPLET MATCHES mingw64)
	set(CONFIG_ARCHITECTURE x64)
	set(MINGW64 ${MSYS_ROOT}/mingw64)
	set(MINGW ${MSYS_ROOT}/mingw64)
    set(CMAKE_SYSTEM_PROCESSOR x86_64)
    set(BITS 64)
	set(MSYSTEM MINGW64)
	set(MSYSTEM_CHOST "x86_64-w64-mingw32")
	set(arch x86_64)
	set(CARCH "x86_64")
	set(CHOST "x86_64-w64-mingw32")
	set(MINGW_CHOST	"x86_64-w64-mingw32")
	set(MINGW_PREFIX "/mingw64/")
	set(MINGW_PACKAGE_PREFIX "mingw-w64-x86_64")
	set(CARCH="x86_64")
	set(CHOST="x86_64-w64-mingw32")
	
	set(CPPFLAGS=" -D_FORTIFY_SOURCE=2 -D__USE_MINGW_ANSI_STDIO=1 ${CPPFLAGS}" )
	set(CFLAGS=" -march=x86-64 -mtune=generic -g0 -O2 -pipe -Wl,-S ${CFLAGS}" )
	set(CXXFLAGS=" -march=x86-64 -mtune=generic -g0 -O2 -pipe -Wl,-S ${CXXFLAGS}" )
#	set(LDFLAGS="${LDFLAGS} -Llib -pipe -Wl -version-script export_symbols")
# Uncomment to enable hardening (ASLR, High entropy ASLR, DEP)
#LDFLAGS="-pipe -Wl,--dynamicbase,--high-entropy-va,--nxcompat"
#-- Make Flags: change this for DistCC/SMP systems

endif ()


set(WINDOWS_GNU 1)
set(CMAKE_LEGACY_CYGWIN_WIN32 1)
SET(CMAKE_C_COMPILER_ID GNU)
SET(CMAKE_CXX_COMPILER_ID GNU)


# compiler/linker flags
#set(CMAKE_CXX_FLAGS_RELEASE "-I'include' -mwindows,-mthreads,-fno-exceptions,-fno-rtti,-ffunction-sections,-fdata-sections,-static-libgcc,-Wall,-Wextra,-fPIC ,-fvisibility=hidden,-DNDEBUG,${CMAKE_CXX_FLAGS_RELEASE}")
#set(CMAKE_C_FLAGS_RELEASE "-I'include' -mwindows,-mthreads,-fno-exceptions,-fno-rtti,-ffunction-sections,-fdata-sections,-static-libgcc,-Wall,-Wextra,-fPIC,-fvisibility=hidden,-DNDEBUG,${CMAKE_C_FLAGS_RELEASE}")
#set(CMAKE_CXX_FLAGS_DEBUG "-I'include' -Wl,--enable-auto-import,-Wl,--exclude-all-symbols,-mwindows,-mthreads,-static-libgcc,${CMAKE_CXX_FLAGS_DEBUG}")
#set(CMAKE_C_FLAGS_DEBUG "-I'include' -Wl,--enable-auto-import,-Wl,--exclude-all-symbols,-mwindows,-mthreads,-static-libgcc,${CMAKE_C_FLAGS_DEBUG}")

#set(LDFLAGS="-Llib -pipe,-Wl,-version-script,export_symbols,${LDFLAGS}")

#-- Debugging flags
#set(DEBUG_CFLAGS="-ggdb -Og")
#set(DEBUG_CXXFLAGS="-ggdb -Og")



#SET(CMAKE_SHARED_LINKER_FLAGS "-Wl,--no-undefined,--fix-cortex-a8,-lsupc++ -lstdc++ -L${CMAKE_INSTALL_PREFIX}/lib")
#set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} --sysroot=${CMAKE_SYSROOT}" CACHE INTERNAL "" FORCE)
#set(CMAKE_C_LINK_FLAGS "${CMAKE_C_LINK_FLAGS} --sysroot=${CMAKE_SYSROOT}" CACHE INTERNAL "" FORCE)
#set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} --sysroot=${CMAKE_SYSROOT}" CACHE INTERNAL "" FORCE)
#set(CMAKE_CXX_LINK_FLAGS "${CMAKE_CXX_LINK_FLAGS} --sysroot=${CMAKE_SYSROOT}" CACHE INTERNAL "" FORCE)

#add_definitions("--sysroot=${CMAKE_SYSROOT}")
#set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} --sysroot=${CMAKE_SYSROOT}" CACHE INTERNAL "" FORCE)
#set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} --sysroot=${CMAKE_SYSROOT}" CACHE INTERNAL "" FORCE)


#set(ENV{PATH} "${MSYS_ROOT}/mingw${BITS}/${MINGW_CHOST};${MSYS_ROOT}/mingw${BITS}/bin;${MSYS_ROOT}/usr/bin;$ENV{PATH}")

#SET(CROSS_COMPILE_TOOLCHAIN_PATH "${MSYS_ROOT}/mingw${BITS}/bin/")
#SET(CROSS_COMPILE_TOOLCHAIN_PREFIX "${MINGW_CHOST}")
#SET(CROSS_COMPILE_SYSROOT "${MSYS_ROOT}/mingw${BITS}/${MINGW_CHOST}/")

#SET(COMPILE_TOOLCHAIN_PATH "${MSYS_ROOT}/mingw${BITS}/bin/")
#SET(COMPILE_TOOLCHAIN_PREFIX "${MINGW_CHOST}")

#SET(BASH "${MSYS_ROOT}/mingw${BITS}/bin/bash.exe")

# which compilers to use for C and C++
# specify the cross linker

#find_program(CMAKE_RC_COMPILER NAMES ${MINGW_CHOST}-windres)
#find_program(CMAKE_C_COMPILER NAMES ${MINGW_CHOST}-gcc)
#find_program(CMAKE_MAKE_PROGRAM NAMES "mingw32-make.exe")
#find_program(CMAKE_C_COMPILER NAMES "${MINGW_CHOST}-gcc.exe")
#find_program(CMAKE_CXX_LINK_EXECUTABLE NAMES "${MINGW_CHOST}-g++.exe")
#find_program(CMAKE_AR NAMES "${MINGW_CHOST}-gcc-ar.exe")
#find_program(CMAKE_NM NAMES "${MINGW_CHOST}-gcc-nm.exe")
#find_program(CMAKE_RANLIB NAMES "${MINGW_CHOST}-gcc-ranlib.exe")
#find_program(CMAKE_CXX_LINK_EXECUTABLE NAMES "ld.exe")
#find_program(CMAKE_Fortran_COMPILER NAMES "gfortran.exe")

#SET(CMAKE_RC_COMPILER	"${MSYS_ROOT}/mingw${BITS}/bin/${MINGW_CHOST}-windres.exe")
#SET(CMAKE_Fortran_COMPILER	"${MSYS_ROOT}/mingw${BITS}/bin/gfortran.exe")
#SET(CMAKE_C_COMPILER	"${MSYS_ROOT}/mingw${BITS}/bin/${MINGW_CHOST}-gcc.exe")
#SET(CMAKE_CXX_COMPILER	"${MSYS_ROOT}/mingw${BITS}/bin/${MINGW_CHOST}-g++.exe")
#SET(CMAKE_CXX_LINK_EXECUTABLE	"${MSYS_ROOT}/mingw${BITS}/bin/${MINGW_CHOST}-g++.exe")
#SET(CMAKE_AR	"${MSYS_ROOT}/mingw${BITS}/bin/${MINGW_CHOST}-gcc-ar.exe")
#SET(CMAKE_NM	"${MSYS_ROOT}/mingw${BITS}/bin/${MINGW_CHOST}-gcc-nm.exe")
#SET(CMAKE_RANLIB	"${MINGW_CHOST}-gcc-ranlib.exe")
#SET(CMAKE_ASM-ATT_COMPILER	"${MINGW_CHOST}-as.exe")

#SET(COLLECT_GCC	x86_64-w64-mingw32-gcc)
#SET(COLLECT_LTO_WRAPPER	lto-wrapper)
set(VCPKG_POLICY_EMPTY_PACKAGE enabled)

SET(wintool Win32)

set(CMAKE_FIND_LIBRARY_PREFIXES "lib" "")
set(CMAKE_FIND_LIBRARY_SUFFIXES ".dll" ".dll.a" ".lib" ".a")
set(CMAKE_EXECUTABLE_SUFFIX ".exe")

set(ACLOCAL_PATH "${MSYS_ROOT}/mingw${BITS}/share/aclocal:/usr/share/aclocal")
set(PKG_CONFIG_PATH "${MSYS_ROOT}/mingw${BITS}/lib/pkgconfig")

SET(CMAKE_PREFIX_PATH
	${MSYS_ROOT}/mingw${BITS};
	${MSYS_ROOT}/mingw${BITS}/${MINGW_CHOST};
	${CURRENT_INSTALLED_DIR}
)

# Crosscompiler path
SET(USER_ROOT_PATH
	${MSYS_ROOT}/mingw${BITS}/opt/${MINGW_CHOST}
)

SET(CMAKE_FIND_ROOT_PATH
	${USER_ROOT_PATH};
	${CMAKE_SYSROOT};
	${MSYS_ROOT}/mingw${BITS};
	${MSYS_ROOT}/mingw${BITS}/${MINGW_CHOST};
	${CMAKE_PREFIX_PATH};
	${PROJECT_SOURCE_DIR}/../lib;
	${PROJECT_SOURCE_DIR}/lib;
	${PROJECT_SOURCE_DIR}/../../lib
)

# Directories where to search for DLLs
SET(DLL_SEARCH_PATH
    ${MSYS_ROOT}/mingw${BITS}/lib;
    ${MSYS_ROOT}/mingw${BITS}/bin;
    ${MSYS_ROOT}/mingw${BITS}/bin/qt-plugins/plugins
)

# here is the target environment located
#set(CMAKE_FIND_ROOT_PATH
#	/usr/i686-w64-mingw32
#	$ENV{PWD}/download-mingw-rpm/usr/i686-w64-mingw32/sys-root/mingw
#	$ENV{PWD}/mingw-install
#	$ENV{HOME}/mingw-install
#)


## where is the target environment
#SET(CMAKE_FIND_ROOT_PATH
#	/usr/i686-pc-mingw32;/usr/i586-mingw32msvc;/usr/i686-pc-mingw32/sys-root/mingw;/usr/i586-mingw32msvc/sys-root/mingw;
#	/home/USERNAME/i586-mingw32msvc;/home/USERNAME/i686-pc-mingw32;${CMAKE_PREFIX_PATH};
#	${PROJECT_SOURCE_DIR}/../libs;${PROJECT_SOURCE_DIR}/libs;${PROJECT_SOURCE_DIR}/../../libs
#)

#set(SYSROOT "C:\SysGC\raspberry\arm-linux-gnueabihf\sysroot")
#SET(CMAKE_SYSROOT "/home/sifu/test-yocto/qemuarmdfs")

#set(CMAKE_RC_COMPILER x86_64-w64-mingw32-windres)
#set(CMAKE_MC_COMPILER x86_64-w64-mingw32-windmc)

#set(CMAKE_Fortran_COMPILER x86_64-w64-mingw32-gfortran)
#set(CMAKE_AR:FILEPATH x86_64-w64-mingw32-ar)
#set(CMAKE_RANLIB:FILEPATH x86_64-w64-mingw32-ranlib)
#set(CMAKE_C_COMPILER    ${MINGW_PREFIX}gcc)
#set(CMAKE_CXX_COMPILER  ${MINGW_PREFIX}g++)
#set(CMAKE_RC_COMPILER   ${MINGW_PREFIX}windres)
#set(CMAKE_AR 		${MINGW_PREFIX}ar)
#set(CMAKE_RANLIB 	${MINGW_PREFIX}ranlib)
#set(CMAKE_LINKER 	${MINGW_PREFIX}ld)
#set(CMAKE_STRIP         ${MINGW_PREFIX}strip)

## which compilers to use for C and C++ and ASM-ATT
#SET(CMAKE_C_COMPILER       /usr/bin/i686-pc-mingw32-gcc )
#SET(CMAKE_CXX_COMPILER     /usr/bin/i686-pc-mingw32-g++ )
#SET(CMAKE_ASM-ATT_COMPILER /usr/bin/i686-pc-mingw32-as  )

# here is the target environment located
#SET(CMAKE_FIND_ROOT_PATH  /usr/i686-pc-mingw32
#                          /usr/i686-pc-mingw32/sys-root/i686-pc-mingw32
#    )


## which compilers to use for C and C++
#include(CMakeForceCompiler)
#cmake_force_c_compiler(i686-w64-mingw32-gcc GNU)
#cmake_force_cxx_compiler(i686-w64-mingw32-g++ GNU)

## compiler
#include(CMakeForceCompiler)
#cmake_force_c_compiler(/path/to/arm-none-linux-gnueabi-gcc GNU)
#cmake_force_cxx_compiler(/path/to/arm-none-linux-gnueabi-g++ GNU)

#set(CMAKE_RC_COMPILER i686-w64-mingw32-windres)
#set(CMAKE_RC_FLAGS -DGCC_WINDRES)
set(CMAKE_RC_FLAGS -DGCC_WINDRES)

# Boost Configuration
SET(Boost_USE_STATIC_LIBS ON)
set(Boost_THREADAPI win32)

set(QT_INCLUDE_DIRS_NO_SYSTEM ON)
#set(QT_BINARY_DIR /usr/x86_64-w64-mingw32/bin /usr/bin)

#SET(QT_LIBRARY_DIR	${MINGW_PREFIX}/lib)
#SET(QT_MKSPECS_DIR	${MINGW_PREFIX}/mkspecs)

#SET(QT_LIBRARY_DIR	/Qt/lib)
#SET(QT_HEADERS_DIR	/Qt/include)  --  /usr/i686-pc-mingw32/Qt/include
#SET(QT_MKSPECS_DIR	/Qt/mkspecs)
#SET(QT_DOCS_DIR	/Qt/doc)
#SET(QT_PLUGINS_DIR	/Qt/plugins)

# Modules
#SET(QT_INCLUDE_DIR              ${MINGW_PREFIX}/include)
#SET(QT_QTCORE_INCLUDE_DIR       ${MINGW_PREFIX}/include/QtCore)
#SET(QT_QTGUI_INCLUDE_DIR        ${MINGW_PREFIX}/include/QtGui)
#SET(QT_QTNETWORK_INCLUDE_DIR    ${MINGW_PREFIX}/include/QtNetwork)
#SET(QT_QTWEBKIT_INCLUDE_DIR     ${MINGW_PREFIX}/include/QtWebKit)
#SET(QT_QTSQL_INCLUDE_DIR        ${MINGW_PREFIX}/include/QtSql)
#SET(QT_QTXML_INCLUDE_DIR        ${MINGW_PREFIX}/include/QtXml)
#SET(QT_PHONON_INCLUDE_DIR		${MINGW_PREFIX}/include/phonon)


## specify the cross compiler
#find_file(MINGWv NAMES i586-mingw32msvc-gcc i586-mingw32msvc-g++ PATHS
#			/usr/bin
#			/usr/local/bin)
#if(NOT MINGWv)
#  set(MINGW_PREFIX "/usr/bin/i686-pc-mingw32-")
#  SET(Boost_COMPILER "-gcc45")
#else(NOT MINGWv)
#  set(MINGW_PREFIX "/usr/bin/i586-mingw32msvc-")
#  SET(Boost_COMPILER "-mgw")
#endif(NOT MINGWv)


## sysroot location
#set(MYSYSROOT /path/to/sysroots/cortexa7-vfp-neon-telechips-linux-gnueabi)

## cmake built-in settings to use find_xxx() functions
#set(CMAKE_FIND_ROOT_PATH "${CMAKE_SYSROOT}")
#set(CMAKE_FIND_ROOT_PATH ${MYSYSROOT})

## Path to pass to the compiler in the --sysroot flag.

## The CMAKE_SYSROOT content is passed to the compiler in the --sysroot flag, if supported. The path is also stripped from the RPATH/RUNPATH if necessary on installation. The CMAKE_SYSROOT is also used to prefix paths searched by the find_* commands.

#SET(CMAKE_SYSROOT "")

## This variable may only be set in a toolchain file specified by the 
#CMAKE_TOOLCHAIN_FILE variable.

#SET(CMAKE_SYSROOT_COMPILE "")
#SET(CMAKE_SYSROOT_LINK "")


# search for programs in the build host directories
SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# for libraries and headers in the target directories
# search headers and libraries in the target environment, search 
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

#SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM BOTH)
#SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY BOTH)
#SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE BOTH)


endif()
endif()