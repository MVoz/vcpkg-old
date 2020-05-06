

if(NOT _VCPKG_MINGW64_TOOLCHAIN)
set(_VCPKG_MINGW64_TOOLCHAIN 1)
set(CMAKE_HOST_SYSTEM_NAME "MSYS")
set(CMAKE_SYSTEM_NAME "MSYS")
endif()


# the name of the target operating system
# i686-pc-mingw32.cmake содержал следующие настрйки:
# http://www.cmake.org/Wiki/CMake_Cross_Compiling#The_toolchain_file
# http://bulletphysics.org/Bullet/phpBB3/viewtopic.php?t=8959
# http://stackoverflow.com/questions/19754316/cross-compiling-opencv-with-mingw-using-cmakein-linux-for-windows


# the name of the target operating system
# this one is important
# Settings for compiling for Windows 64-bit machines using MinGW-w64
SET(IS_CROSSCOMPILING "YES")
#SET(CMAKE_SYSTEM_NAME Windows)
SET(CMAKE_SHARED_LIBRARY_LINK_C_FLAGS "")
SET(CMAKE_SHARED_LIBRARY_LINK_CXX_FLAGS "")

#this one not so much
#SET(CMAKE_SYSTEM_VERSION 1)
#SET(CMAKE_SYSTEM_PROCESSOR i686)
#SET(CMAKE_SYSTEM_PROCESSOR x86_64)

if(CMAKE_SYSTEM_PROCESSOR MATCHES "^x64$")
    set (CMAKE_SYSTEM_PROCESSOR x86_64)
    set (BITS 64)
endi()

## if (CMAKE_SYSTEM_PROCESSOR MATCHES "^x86$")
#    set (CMAKE_SYSTEM_PROCESSOR i686)
#    set (BITS 32)
#elseif (CMAKE_SYSTEM_PROCESSOR MATCHES "^x64$")
#    set (CMAKE_SYSTEM_PROCESSOR x86_64)
#    set (BITS 64)
#endif ()

#set (IS_32_BIT "32-")

SET(CROSS_COMPILE_TOOLCHAIN_PATH "$ENV{MSYS_ROOT}/mingw64/bin/")
SET(CROSS_COMPILE_TOOLCHAIN_PREFIX "x86_64-w64-mingw32")
SET(CROSS_COMPILE_SYSROOT "$ENV{MSYS_ROOT}/usr/x86_64-w64-mingw32/")

SET(COMPILE_TOOLCHAIN_PATH "$ENV{MSYS_ROOT}/mingw64/bin/")
SET(COMPILE_TOOLCHAIN_PREFIX "x86_64-w64-mingw32")

#set(COMPILER_DIR /opt/apps/intel/11.1/bin/intel64)
# which compilers to use for C and C++
# which compilers to use for C and C++ and ASM-ATT
# specify the cross compiler
# for classical mingw32
#set(COMPILER_PREFIX "i586-mingw32msvc")
# for 32 or 64 bits mingw-w64
#set(COMPILER_PREFIX "i686-w64-mingw32")
vcpkg_acquire_msys(MSYS_ROOT)

set(COMPILER_PREFIX x86_64-w64-mingw32)
SET(PREFIX	x86_64-w64-mingw32)
#SET(CMAKE_MAKE_PROGRAM	mingw32-make)
SET(CMAKE_MAKE_PROGRAM	"{MSYS_ROOT}/mingw64/bin/make.exe")

set(BASH ${MSYS_ROOT}/usr/bin/bash.exe)
#vcpkg_execute_required_process(
#    COMMAND ${BASH} --noprofile --norc
#)

# which compilers to use for C and C++
#find_program(CMAKE_RC_COMPILER NAMES ${COMPILER_PREFIX}-windres)
SET(CMAKE_RC_COMPILER ${MSYS_ROOT}/mingw64/bin/${COMPILER_PREFIX}-windres.exe)
#find_program(CMAKE_C_COMPILER NAMES ${COMPILER_PREFIX}-gcc)
SET(CMAKE_C_COMPILER ${MSYS_ROOT}/mingw64/bin/${COMPILER_PREFIX}-gcc.exe)
#find_program(CMAKE_CXX_COMPILER NAMES ${COMPILER_PREFIX}-g++)
SET(CMAKE_CXX_COMPILER ${MSYS_ROOT}/mingw64/bin/${COMPILER_PREFIX}-g++.exe)
#set(CMAKE_Fortran_COMPILER ${COMPILER_DIR}/ifort)
set(CMAKE_Fortran_COMPILER ${MSYS_ROOT}/mingw64/bin/gfortran.exe)

#SET(CMAKE_C_COMPILER	${PREFIX}-gcc)
#SET(CMAKE_CXX_COMPILER	${PREFIX}-g++)
SET(CMAKE_CXX_LINK_EXECUTABLE	${MSYS_ROOT}/mingw64/bin/${PREFIX}-g++.exe)
SET(CMAKE_AR	${MSYS_ROOT}/mingw64/bin/${PREFIX}-gcc-ar.exe)
SET(CMAKE_NM	${MSYS_ROOT}/mingw64/bin/${PREFIX}-gcc-nm.exe)
#SET(CMAKE_RC_COMPILER	windres)
SET(QT_QMAKE_EXECUTABLE qmake.exe)

# specify the cross linker
SET(CMAKE_RANLIB ${PREFIX}-gcc-ranlib.exe)
SET(CMAKE_ASM-ATT_COMPILER	${PREFIX}-as.exe)
#SET(COLLECT_GCC	x86_64-w64-mingw32-gcc)
#SET(COLLECT_LTO_WRAPPER	lto-wrapper)

# here is the target environment located
# here is the target environment located
# where is the target environment
# Croscompiler path
#SET(CMAKE_FIND_ROOT_PATH /usr/i686-pc-mingw32/sys-root/mingw)
#SET(CMAKE_FIND_ROOT_PATH /mingw64 /mingw64/${PREFIX})
SET(USER_ROOT_PATH	/mingw64/opt/${PREFIX})
#SET(CMAKE_FIND_ROOT_PATH  /usr/${COMPILER_PREFIX} ${USER_ROOT_PATH})
SET(CMAKE_FIND_ROOT_PATH	${CMAKE_FIND_ROOT_PATH}
							${USER_ROOT_PATH}
							/mingw64/
							/mingw64/${PREFIX}
							/usr/${COMPILER_PREFIX}
)

#SET(CMAKE_PREFIX_PATH /usr/x86_64-w64-mingw32)
SET(CMAKE_PREFIX_PATH	/mingw64/${PREFIX}
						/mingw64/

)

# adjust the default behaviour of the FIND_XXX() commands:
# search headers and libraries in the target environment, search 
# programs in the host environment
# search for programs in the build host directories
SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# for libraries and headers in the target directories
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

SET(wintool Win32)

#SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM BOTH)
#SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY BOTH)
#SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE BOTH)

# Directories where to search for DLLs
#SET(MINGW_PREFIX	/usr/x86_64-w64-mingw32)
#SET(MINGW_PREFIX	/mingw64/${PREFIX})
SET(MINGW_PREFIX	/mingw64/)

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

# Directories where to search for DLLs
SET(DLL_SEARCH_PATH
    ${MINGW_PREFIX}/lib
    ${MINGW_PREFIX}/bin
    ${MINGW_PREFIX}/bin/qt-plugins/plugins
)

# Tell pkg-config not to look at the target environment's .pc files.
# Setting PKG_CONFIG_LIBDIR sets the default search directory, but we have to
# set PKG_CONFIG_PATH as well to prevent pkg-config falling back to the host's
# path.
SET(ENV{PKG_CONFIG_LIBDIR} ${CMAKE_FIND_ROOT_PATH}/lib/pkgconfig)
SET(ENV{PKG_CONFIG_PATH} ${CMAKE_FIND_ROOT_PATH}/lib/pkgconfig)

SET(ENV{MINGDIR} ${CMAKE_FIND_ROOT_PATH})







