## the name of the target operating system
## this one is important
## Settings for compiling for Windows 64-bit machines using MinGW-w64
SET(IS_CROSSCOMPILING "YES")
##this one not so much
SET(CMAKE_SYSTEM_VERSION 1)
## SET(CMAKE_SYSTEM_PROCESSOR i686)
## SET(CMAKE_SYSTEM_PROCESSOR x86_64)

if(CMAKE_SYSTEM_PROCESSOR MATCHES "^x64$")
    set (CMAKE_SYSTEM_PROCESSOR x86_64)
    set (BITS 64)
endif()

## if (CMAKE_SYSTEM_PROCESSOR MATCHES "^x86$")
##    set (CMAKE_SYSTEM_PROCESSOR i686)
##    set (BITS 32)
##elseif (CMAKE_SYSTEM_PROCESSOR MATCHES "^x64$")
##    set (CMAKE_SYSTEM_PROCESSOR x86_64)
##    set (BITS 64)
##endif ()

## SET (IS_32_BIT "32-")

if(VCPKG_TARGET_ARCHITECTURE STREQUAL x64)
    set(TARGET_ARCH "x86_64-w64-mingw32")
    set(ARCH_DIR "x86_64")
endif()

if(CMAKE_SYSTEM_PROCESSOR MATCHES "^x64$")
    set (CMAKE_SYSTEM_PROCESSOR x86_64)
    set (BITS 64)
endif()

set(MSYSTEM MSYS)
set(CONFIGURE_OPTIONS "${CONFIGURE_OPTIONS} --target=x86_64-w64-mingw32 --host=x86_64-w64-mingw32 --build=x86_64-w64-mingw32")

## Windows msys mingw ships with a mostly suitable preconfigured environment
if(DEFINED ENV{MSYSCON})
#	set(CMAKE_GENERATOR         "MSYS Makefiles" CACHE STRING "" FORCE)
## set(MINGW_PREFIX            "I:/msys2/mingw${MINGW_ARCH}")

## set(MINGW_TOOL_PREFIX       "${MINGW_PREFIX}/bin/") 
	set(MINGW_CHOST				"x86_64-w64-mingw32")
	set(GNU_HOST				"x86_64-w64-mingw32")
	set(MSYS2_ARCH				"x86_64")
## Msys compiler does not support @CMakeFiles/Include syntax
	set(CMAKE_C_USE_RESPONSE_FILE_FOR_INCLUDES   OFF)
	set(CMAKE_CXX_USE_RESPONSE_FILE_FOR_INCLUDES OFF)
endif()

set(MINGW_PREFIX            "I:/msys2/mingw${BITS}")
set(MSYS_ROOT				"I:/msys2")
set(MINGW_TOOL_PREFIX		${MINGW_PREFIX}/bin/${CMAKE_SYSTEM_PROCESSOR}-w64-mingw32-)
set(ENV{PATH}				"${MSYS_ROOT}/usr/bin;${MINGW_PREFIX}/bin")

set(CMAKE_FIND_ROOT_PATH "I:/msys2/mingw${BITS}" "I:/msys2/mingw${BITS}/${CMAKE_SYSTEM_PROCESSOR}-w64-mingw32")
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM ONLY)
set(ENV{PATH} "I:\\msys2\\mingw${BITS}\\bin;I:\\msys2\\mingw${BITS}\\${CMAKE_SYSTEM_PROCESSOR}-w64-mingw32\\bin;$ENV{PATH}")

## the name of the target operating system
## i686-pc-mingw32.cmake содержал следующие настрйки:
## http://www.cmake.org/Wiki/CMake_Cross_Compiling##The_toolchain_file
## http://bulletphysics.org/Bullet/phpBB3/viewtopic.php?t=8959
## http://stackoverflow.com/questions/19754316/cross-compiling-opencv-with-mingw-using-cmakein-linux-for-windows



## SET(CMAKE_SYSTEM_NAME Windows)
SET(CMAKE_SHARED_LIBRARY_LINK_C_FLAGS "")
SET(CMAKE_SHARED_LIBRARY_LINK_CXX_FLAGS "")


SET(CROSS_COMPILE_TOOLCHAIN_PATH "I:/msys2/mingw64/bin/")
SET(CROSS_COMPILE_TOOLCHAIN_PREFIX "x86_64-w64-mingw32")
SET(CROSS_COMPILE_SYSROOT "I:/msys2/mingw64/x86_64-w64-mingw32/")

SET(COMPILE_TOOLCHAIN_PATH "I:/msys2/mingw64/bin/")
SET(COMPILE_TOOLCHAIN_PREFIX "x86_64-w64-mingw32")

## SET(COMPILER_DIR /opt/apps/intel/11.1/bin/intel64)
## which compilers to use for C and C++
## which compilers to use for C and C++ and ASM-ATT
## specify the cross compiler
## for classical mingw32
## SET(COMPILER_PREFIX "i586-mingw32msvc")
## for 32 or 64 bits mingw-w64
## SET(COMPILER_PREFIX "i686-w64-mingw32")

# vcpkg_acquire_msys(MSYS_ROOT)

set(COMPILER_PREFIX x86_64-w64-mingw32)
SET(PREFIX	x86_64-w64-mingw32)
## SET(CMAKE_MAKE_PROGRAM	mingw32-make)
SET(CMAKE_MAKE_PROGRAM	"I:/msys2/mingw64/bin/make.exe")

set(BASH ${MSYS_ROOT}/usr/bin/bash.exe)
##vcpkg_execute_required_process(
##    COMMAND ${BASH} --noprofile --norc
##)

## which compilers to use for C and C++
SET(CMAKE_RC_COMPILER	"I:/msys2/mingw64/bin/x86_64-w64-mingw32-windres.exe")
#SET(CMAKE_C_COMPILER ${MSYS_ROOT}/mingw64/bin/${COMPILER_PREFIX}-gcc.exe)
SET(CMAKE_C_COMPILER	"I:/msys2/mingw64/bin/x86_64-w64-mingw32-gcc.exe")
SET(CMAKE_CXX_COMPILER	"I:/msys2/mingw64/bin/x86_64-w64-mingw32-g++.exe")
## SET(CMAKE_Fortran_COMPILER ${COMPILER_DIR}/ifort)
set(CMAKE_Fortran_COMPILER	"I:/msys2/mingw64/bin/x86_64-w64-mingw32-gfortran.exe")

SET(CMAKE_CXX_LINK_EXECUTABLE	"I:/msys2/mingw64/bin/x86_64-w64-mingw32-g++.exe")
SET(CMAKE_AR	"I:/msys2/mingw64/bin/x86_64-w64-mingw32-gcc-ar.exe")
SET(CMAKE_NM	"I:/msys2/mingw64/bin/x86_64-w64-mingw32-gcc-nm.exe")
SET(QT_QMAKE_EXECUTABLE qmake.exe)
SET(CMAKE_LINKER	"I:/msys2/mingw64/bin/ld.exe")
## specify the cross linker
SET(CMAKE_RANLIB	"I:/msys2/mingw64/bin/x86_64-w64-mingw32-gcc-ranlib.exe")
SET(CMAKE_ASM-ATT_COMPILER	${PREFIX}-as.exe)
## SET(COLLECT_GCC	x86_64-w64-mingw32-gcc.exe)
## SET(COLLECT_LTO_WRAPPER	lto-wrapper.exe)

## here is the target environment located
## here is the target environment located
## where is the target environment
## Croscompiler path
## SET(CMAKE_FIND_ROOT_PATH /usr/i686-pc-mingw32/sys-root/mingw)
## SET(CMAKE_FIND_ROOT_PATH /mingw64 /mingw64/${PREFIX})
SET(USER_ROOT_PATH	/mingw64/opt/${PREFIX})
## SET(CMAKE_FIND_ROOT_PATH  /usr/${COMPILER_PREFIX} ${USER_ROOT_PATH})
SET(CMAKE_FIND_ROOT_PATH	${CMAKE_FIND_ROOT_PATH}
							${USER_ROOT_PATH}
							/mingw64/
							/mingw64/${PREFIX}
							/usr/${COMPILER_PREFIX}
)

## SET(CMAKE_PREFIX_PATH /usr/x86_64-w64-mingw32)
SET(CMAKE_PREFIX_PATH	/mingw64/${PREFIX}
						/mingw64/

)

## adjust the default behaviour of the FIND_XXX() commands:
## search headers and libraries in the target environment, search 
## programs in the host environment
## search for programs in the build host directories
SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
## for libraries and headers in the target directories
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

SET(wintool Win32)

## SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM BOTH)
## SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY BOTH)
## SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE BOTH)

## Directories where to search for DLLs
## SET(MINGW_PREFIX	/usr/x86_64-w64-mingw32)
## SET(MINGW_PREFIX	/mingw64/${PREFIX})
SET(MINGW_PREFIX	/mingw64/)

## SET(QT_LIBRARY_DIR	${MINGW_PREFIX}/lib)
## SET(QT_MKSPECS_DIR	${MINGW_PREFIX}/mkspecs)

## SET(QT_LIBRARY_DIR	/Qt/lib)
## SET(QT_HEADERS_DIR	/Qt/include)  --  /usr/i686-pc-mingw32/Qt/include
## SET(QT_MKSPECS_DIR	/Qt/mkspecs)
## SET(QT_DOCS_DIR	/Qt/doc)
## SET(QT_PLUGINS_DIR	/Qt/plugins)

## Modules
## SET(QT_INCLUDE_DIR              ${MINGW_PREFIX}/include)
## SET(QT_QTCORE_INCLUDE_DIR       ${MINGW_PREFIX}/include/QtCore)
## SET(QT_QTGUI_INCLUDE_DIR        ${MINGW_PREFIX}/include/QtGui)
## SET(QT_QTNETWORK_INCLUDE_DIR    ${MINGW_PREFIX}/include/QtNetwork)
## SET(QT_QTWEBKIT_INCLUDE_DIR     ${MINGW_PREFIX}/include/QtWebKit)
## SET(QT_QTSQL_INCLUDE_DIR        ${MINGW_PREFIX}/include/QtSql)
## SET(QT_QTXML_INCLUDE_DIR        ${MINGW_PREFIX}/include/QtXml)
## SET(QT_PHONON_INCLUDE_DIR		${MINGW_PREFIX}/include/phonon)

## Directories where to search for DLLs
SET(DLL_SEARCH_PATH
    ${MINGW_PREFIX}/lib
    ${MINGW_PREFIX}/bin
    ${MINGW_PREFIX}/bin/qt-plugins/plugins
)

## Tell pkg-config not to look at the target environment's .pc files.
## Setting PKG_CONFIG_LIBDIR sets the default search directory, but we have to
## set PKG_CONFIG_PATH as well to prevent pkg-config falling back to the host's
## path.
SET(ENV{PKG_CONFIG_LIBDIR} ${CMAKE_FIND_ROOT_PATH}/lib/pkgconfig)
SET(ENV{PKG_CONFIG_PATH} ${CMAKE_FIND_ROOT_PATH}/lib/pkgconfig)

SET(ENV{MINGDIR} ${CMAKE_FIND_ROOT_PATH})













