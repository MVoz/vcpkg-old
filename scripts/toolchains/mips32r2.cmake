cmake_minimum_required(VERSION 3.12...3.13 FATAL_ERROR)

include(CMakeForceCompiler)
include(GNUInstallDirs)
include(TryRunResults)
include(CheckIncludeFile)
#include(CheckSymbolExists)
#include(CheckFunctionExists)
#include(CheckLibraryExists)
#include(CheckTypeSize)
include(CheckCXXSourceCompiles)
include(CheckCSourceCompiles)

#include(CheckIncludeFile)
# No runtime cpu detect for mips32-linux-gcc.
if(CONFIG_RUNTIME_CPU_DETECT)
  message("--- CONFIG_RUNTIME_CPU_DETECT not supported for mips32 targets.")
endif ()
set(CONFIG_RUNTIME_CPU_DETECT 0 CACHE NUMBER "" FORCE)

#set(CMAKE_CROSSCOMPILING TRUE)
#if(DEFINED CMAKE_CROSSCOMPILING )
#	return()
#endif()

#get_property(IS_IN_TRY_COMPILE GLOBAL PROPERTY IN_TRY_COMPILE)
#if(IS_IN_TRY_COMPILE)
	# this seems necessary and works fine but I'm unsure if it breaks anything
#	return()
#endif()

#get_property(IS_IN_TRY_RUN GLOBAL PROPERTY IN_TRY_RUN)
#if(IS_IN_TRY_RUN)
	# this seems necessary and works fine but I'm unsure if it breaks anything
#	return()
#endif()

#set(IN_TRY_COMPILE "0" CACHE STRING "Result from TRY_RUN" FORCE)

#CMake Error: TRY_RUN() invoked in cross-compiling mode, please set the following cache variables appropriately:
set(CMAKE_CROSSCOMPILING TRUE)

if(NOT _VCPKG_MipsEL_TOOLCHAIN)
set(_VCPKG_MipsEL_TOOLCHAIN 1)
get_property( _IN_TRY_COMPILE GLOBAL PROPERTY IN_TRY_COMPILE )
if(NOT _IN_TRY_COMPILE)


set(CMAKE_CROSSCOMPILING TRUE)
set(CMAKE_SYSTEM_PROCESSOR mipsel)

set(CMAKE_SYSTEM_NAME "Linux" CACHE STRING "" FORCE)
set(CMAKE_SYSTEM_VERSION 1)      # this one not so much

set(CMAKE_C_PLATFORM_ID "Linux")
set(CMAKE_C_SIMULATE_ID "Linux")
set(CMAKE_CXX_PLATFORM_ID "Linux")
set(CMAKE_CXX_SIMULATE_ID "Linux")

set(IS_CROSSCOMPILING "YES")
set(CMAKE_SYSTEM_LOADED 1)
set(CMAKE_CXX_COMPILER_ID "GNU")
set(CMAKE_C_COMPILER_ID "GNU")
set(GCC_COMPILER_VERSION "6.3.0" CACHE STRING "GCC Compiler version")
set(ARCH "mipsel")
set(COMPANY_NAME "PilotGroup")

set(CMAKE_COMPILER_IS_GNUC 1)
set(CMAKE_C_COMPILER_LOADED 1)
set(CMAKE_C_COMPILER_ID_RUN 1)
if(CMAKE_C_COMPILER_FORCED)
  # The compiler configuration was forced by the user.
  # Assume the user has configured all compiler information.
  set(CMAKE_C_COMPILER_WORKS TRUE)
  return()
endif()

set(CMAKE_C_ABI_COMPILED TRUE)
set(CMAKE_C_SOURCE_FILE_EXTENSIONS C;M;c++;cc;cpp;cxx;mm;CPP)
#set(CMAKE_C_SIZEOF_DATA_PTR "4")
set(CMAKE_C_COMPILER_ABI "ELF")
set(CMAKE_INTERNAL_PLATFORM_ABI "ELF")
#if(CMAKE_C_COMPILER_ABI)
#  set(CMAKE_INTERNAL_PLATFORM_ABI "${CMAKE_C_COMPILER_ABI}")
#endif()
#if(CMAKE_C_LIBRARY_ARCHITECTURE)
#  set(CMAKE_LIBRARY_ARCHITECTURE "")
#endif()

set(CMAKE_CXX_COMPILER_ENV_VAR "CXX")
set(CMAKE_CXX_COMPILER_ID_RUN 1)
set(CMAKE_COMPILER_IS_GNUCXX 1)
set(CMAKE_CXX_COMPILER_LOADED 1)
if(CMAKE_CXX_COMPILER_FORCED)
  # The compiler configuration was forced by the user.
  # Assume the user has configured all compiler information.
  set(CMAKE_CXX_COMPILER_WORKS TRUE)
  return()
endif()
set(CMAKE_CXX_ABI_COMPILED TRUE)
set(CMAKE_CXX_SOURCE_FILE_EXTENSIONS C;M;c++;cc;cpp;cxx;mm;CPP)


#set(CMAKE_INSTALL_LIBDIR "${CMAKE_INSTALL_PREFIX}/lib")
#set(CMAKE_INSTALL_LIBDIR "${CURRENT_INSTALLED_DIR}/lib")

#set(TOOLCHAIN_DIR ${PROJECT_BINARY_DIR}/external/openwrt/toolchain)
#set(ENV{TOOLCHAIN_DIR} "I:/Compile/Imagination/Toolchains/mips-mti-linux-gnu/2018.09-03")
#set($ENV{TOOLCHAIN_DIR} "I:/Compile/Imagination/Toolchains/mips-mti-linux-gnu/2018.09-03")

set(IMG_TOOLCHAIN_DIR "I:/Compile/Imagination/Toolchains/mips-mti-linux-gnu/2018.09-03/bin")
set(IMG_GCC_PREFIX mips-mti-linux-gnu)
set(IMG_TOOLCHAIN ${IMG_TOOLCHAIN_DIR}/${IMG_GCC_PREFIX})

set(GCC_PREFIX mips-mti-linux-gnu)
set(TOOLCHAIN_DIR "I:/Compile/Imagination/Toolchains/mips-mti-linux-gnu/2018.09-03")
set(TOOLCHAIN_PREFIX "I:/Compile/Imagination/Toolchains/mips-mti-linux-gnu/2018.09-03")
set(TOOLCHAIN_BIN_DIR "I:/Compile/Imagination/Toolchains/mips-mti-linux-gnu/2018.09-03/bin")
set(TOOLCHAIN ${TOOLCHAIN_DIR}/${GCC_PREFIX})

set(COMPILE_DIR "${TOOLCHAIN_DIR}")
#set(CMAKE_SYSROOT "${TOOLCHAIN_DIR}/sysroot/mipsel-r1-hard")
set(ROOTFS "E:/tools/vcpkg/installed/mipsel")
set(COMPILER_ROOT "${TOOLCHAIN_DIR}/bin")

#set(CMAKE_SYSROOT $ENV{SDKSYSROOT})
#set(CMAKE_FIND_ROOT_PATH $ENV{SDKSYSROOT})
#set(CMAKE_SYSROOT "${TOOLCHAIN_DIR}/sysroot/mipsel-r1-hard" "${TOOLCHAIN_DIR}/sysroot")
#set(CMAKE_SYSROOT "/sysroot/mipsel-r1-hard")
#set(ENV{PATH} "$ENV{PATH};${TOOLCHAIN_DIR}/bin")
#set(CMAKE_STAGING_PREFIX "${CURRENT_INSTALLED_DIR};${CMAKE_SYSROOT}")

set(CMAKE_STAGING_DIR "${TOOLCHAIN_DIR}/sysroot/mipsel-r1-hard")
set(CMAKE_STAGING "${TOOLCHAIN_DIR}/sysroot/mipsel-r1-hard")
set(CMAKE_STAGING_ROOT "${TOOLCHAIN_DIR}/sysroot/mipsel-r1-hard")
set(CMAKE_STAGING_PREFIX "${TOOLCHAIN_DIR}")
#set(CMAKE_SYSROOT "I:/Compile/Imagination/Toolchains/mips-mti-linux-gnu/2018.09-03/sysroot")
#set(CMAKE_FIND_ROOT_PATH "${TOOLCHAIN_DIR}")
#set(CMAKE_FIND_ROOT_PATH ${ROOTFS})

LIST(APPEND CMAKE_PROGRAM_PATH "${TOOLCHAIN_DIR}/bin/ $ENV{PATH}")
## LIST(APPEND CMAKE_PROGRAM_PATH "${TOOLCHAIN_DIR}/bin" "$ENV{PATH}")
set(ENV{PATH} "${TOOLCHAIN_DIR}/bin ${TOOLCHAIN_DIR}/mips-mti-linux-gnu/bin $ENV{PATH}")

set(CMAKE_INCLUDE_SYSTEM_FLAG_C "-isystem")

#set(CMAKE_FIND_STAGING_PATH "${CURRENT_INSTALLED_DIR};${CMAKE_SYSROOT}" CACHE STRING "")
#set(CMAKE_FIND_STAGING_PATH 
#	${CMAKE_SYSROOT}
#	${CMAKE_STAGING}
#	${ROOTFS}
#	${CURRENT_INSTALLED_DIR}
#)

set(CONFIG_ARCHITECTURE "mips32")
#	set(CMAKE_SYSROOT "${TOOLCHAIN_DIR}/sysroot")
set(CMAKE_CONFIG_ARCHITECTURE "mips32")
#	set(MINGW ${MSYS_ROOT}/mingw32/)
#	set(MSYSTEM MINGW32)
set(HOST "mips-mti-linux-gnu")
set(MACHINE "mipsel")
set(TARGET_ARCH "mipsel")
set(TARGET_TRIPLET "mips-mti-linux-gnu")

#set(arch "mipsel")
set(CARCH "mipsel")
#	set(MINGW_CHOST "i686-w64-mingw32")
#	set(PREFIX "/sysroot/")
#	set(PACKAGE_PREFIX "mips-mti-linux-gnu")
set(tune mips32)
set(CHOST "mips-mti-linux-gnu")
set(TARGET_MACHINE mips-mti-linux-gnu)
set(MIPS_TARGET mips-mti-linux-gnu)
set(DEFAULT_TARGET_TRIPLE "mips-mti-linux-gnu")
#set(CROSS_PREFIX "")
set(CROSS_COMPILE mips-mti-linux-gnu-)
#if ("${CROSS_COMPILE}" STREQUAL "")
	# TODO(tomfinegan): Make it possible to turn this off. The $CROSS prefix
	# won't be desired on a mips host.
	# Default cross compiler prefix to something that might work for an
	# unoptimized build.
	#set(CROSS_COMPILE mips-mti-linux-gnu-)
#endif ()

if(WIN32)
	set(EXECUTABLE_SUFFIX ".exe" )
endif()

set(MIPS_COMPILER mips-mti-linux-gnu-gcc${EXECUTABLE_SUFFIX})

set(SYSTEM_HEADER_DIR 
	${SYSTEM_HEADER_DIR}
	${ROOTFS}/include
	${CURRENT_INSTALLED_DIR}/include

)
set(OTHER_FIXINCLUDES_DIRS 
	${OTHER_FIXINCLUDES_DIRS}
	${ROOTFS}/include
	${CURRENT_INSTALLED_DIR}/include
	
)

#set (CMAKE_UNAME ${CMAKE_SYSROOT}/bin/uname)

#set(CURRENT_INSTALLED_DIR "E:/tools/vcpkg/installed/mipsel")
#set(CMAKE_STAGING_PREFIX "${CURRENT_INSTALLED_DIR};${CMAKE_SYSROOT}" CACHE STRING "")
#set(CMAKE_STAGING "${CURRENT_INSTALLED_DIR};${CMAKE_SYSROOT}" CACHE STRING "")

#set(CMAKE_STAGING "${CURRENT_INSTALLED_DIR}" CACHE STRING "")
#set(CMAKE_STAGING_PREFIX "${CURRENT_INSTALLED_DIR}" CACHE STRING "")
#CMAKE_FIND_NO_INSTALL_PREFIX
#CMAKE_INSTALL_PREFIX
#set(CMAKE_SYSTEM_IGNORE_PATH "")
#set(CMAKE_SKIP_INSTALL_ALL_DEPENDENCY "")

#set(CMAKE_FIND_SYSROOT_PATH "${CMAKE_SYSROOT}" CACHE STRING "")

# resetting pkg-config paths
set(ENV{PKG_CONFIG_DIR} "")
set(ENV{PKG_CONFIG_LIBDIR} "${CMAKE_STAGING}/usr/lib/pkgconfig:${CMAKE_STAGING}/lib/pkgconfig:${CMAKE_STAGING}/usr/local/lib/pkgconfig:${CMAKE_STAGING}/usr/lib/aarch64-linux-gnu/pkgconfig:${CMAKE_STAGING}/usr/share/pkgconfig")
## PKG_CONFIG_LIBDIR=/usr/lib/pkgconfig CC="gcc -m32 -mfpmath=sse -msse -msse2" CXX="g++ -m32 -mfpmath=sse -msse -msse2" AR=ar
set(ENV{PKG_CONFIG_SYSROOT_DIR} 
	${CMAKE_STAGING}
	${ROOTFS}
	${CURRENT_INSTALLED_DIR}
)

# Initialize the state of the variables. This initialization is not
# necessary but this shows you what value the variables initially have.
#set(CMAKE_REQUIRED_DEFINITIONS "")
#set(CMAKE_REQUIRED_INCLUDES "")
#set(CMAKE_REQUIRED_LIBRARIES "")
#set(CMAKE_REQUIRED_FLAGS "")
# For other tests to use the same libraries
set (CMAKE_REQUIRED_LIBRARIES ${CMAKE_REQUIRED_LIBRARIES} ${LINK_LIBS})

#set(THREADS_PTHREAD_ARG "0" CACHE STRING "Result from TRY_RUN" FORCE)
#set(HAVE_DEFAULT_SOURCE_RUN "0" CACHE STRING "Result from TRY_RUN" FORCE)
#set(HAVE_DEFAULT_SOURCE_RUN__TRYRUN_OUTPUT "" CACHE STRING "Result from TRY_RUN" FORCE)

#set(THREADS_PTHREAD_ARG "0" CACHE STRING "Forcibly set by CMakeLists.txt." FORCE)
#set(THREADS_PTHREAD_ARG CACHE STRING "${TOOLCHAIN_DIR}" FORCE)
#set(THREADS_PTHREAD_ARG OFF)

   
#if(NOT DEFINED CMAKE_SYSROOT)
#  message(FATAL_ERROR "Missing required option -DCMAKE_SYSROOT=<sysroot path>.")
#endif()

#set(CMAKE_HOST_WIN32 ON)
#if()
#    set(ENV_COMMAND set)
#    set(PATH_VAR ";%PATH%")
#	file(TO_NATIVE_PATH ENV_PATH "${COMPILER_ROOT};${TOOLCHAIN_DIR}/bin;${TOOLCHAIN_DIR}/mips-mti-linux-gnu/bin;$ENV{PATH}")
#	set(HOST_EXECUTABLE_SUFFIX ".exe")
#endif()


#set(ENV{ANDROID_DEV} "${CMAKE_SYSROOT}/usr")
#set(ENV{CC} "${CMAKE_C_COMPILER}")

# Use CMAKE_SYSROOT prefix for FIND_XXX() commands.
#set(CMAKE_FIND_ROOT_PATH "${CURRENT_INSTALLED_DIR};${CMAKE_SYSROOT}" CACHE STRING "")

#---General Build options----------------------------------------------------------------------
# use, i.e. don't skip the full RPATH for the build tree
set(CMAKE_SKIP_BUILD_RPATH TRUE)
# when building, don't use the install RPATH already (but later on when installing)
#set(CMAKE_BUILD_WITH_INSTALL_RPATH FALSE)
# add the automatically determined parts of the RPATH
# which point to directories outside the build tree to the install RPATH
#set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)

# the RPATH to be used when installing---------------------------------------------------------
#if(rpath)
#  set(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}")
#  set(CMAKE_BUILD_WITH_INSTALL_RPATH TRUE CACHE BOOL "")
#endif()
if(rpath)
  # Make sure static libs use the gnu format.
  set(CMAKE_STATIC_LINKER_FLAGS "-format gnu" CACHE STRING "")
  if(CMAKE_GENERATOR STREQUAL "Ninja")
    set(CMAKE_BUILD_WITH_INSTALL_RPATH TRUE CACHE BOOL "")
	set(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}")
  endif() 
endif()

#if (NOT BUILD_CMAKE_TOOLCHAINS_MIPS32_LINUX_GCC_CMAKE_)
#set(BUILD_CMAKE_TOOLCHAINS_MIPS32_LINUX_GCC_CMAKE_ 1)
#set(CMAKE_SKIP_INSTALL_RPATH YES)
#set(CMAKE_SKIP_RPATH YES)
# use, i.e. don't skip the full RPATH for the build tree
#set(CMAKE_SKIP_BUILD_RPATH TRUE)
#set(NO_CMAKE_FIND_ROOT_PATH TRUE)
# when building, don't use the install RPATH already
# (but later on when installing)

#set(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}")
#set(CMAKE_INSTALL_RPATH "${CURRENT_INSTALLED_DIR}")
#set(CMAKE_BUILD_WITH_INSTALL_RPATH "${CURRENT_INSTALLED_DIR}")
## Рабочая связка игнорировать RPATH
#set(NO_CMAKE_FIND_ROOT_PATH TRUE)
#set(CMAKE_BUILD_WITH_INSTALL_RPATH 1)


#set(CMAKE_FIND_ROOT_PATH "${TOOLCHAIN_DIR}")
set(CMAKE_FIND_ROOT_PATH
	${TOOLCHAIN_DIR}
	${CMAKE_STAGING}
	${CMAKE_STAGING}
	${ROOTFS}
	${CURRENT_INSTALLED_DIR}
)

set(CMAKE_PREFIX_PATH 
	${CMAKE_STAGING}/usr
	${CMAKE_STAGING}
	${ROOTFS}
	${CURRENT_INSTALLED_DIR}
)

#if(DEFINED $ENV{TOOLCHAIN_DIR})
#	set(TOOLCHAIN_DIR I:/Compile/Imagination/Toolchains/mips-mti-linux-gnu/2018.09-03)
#else()	
#	set(TOOLCHAIN_DIR "I:/Compile/Imagination/Toolchains/mips-mti-linux-gnu/2018.09-03")
#endif()

#set(ARCH "mipsel")
#set(ARCH_MIPS 1)

# Assembly flavors available for the target.
#set(HAVE_MIPS32 1)

#if(ENABLE_MSA)
#  set(HAVE_MSA 1 CACHE BOOL "" FORCE)
#  if ("${CROSS_COMPILE}" STREQUAL "")
#    # Default the cross compiler prefix to something known to work.
#    set(CROSS_COMPILE mips-mti-linux-gnu-)
#  endif ()
#  set(MIPS_CFLAGS "-mmsa")
#  set(MIPS_CXXFLAGS "-mmsa")
#endif ()




set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_VERBOSE_MAKEFILE TRUE)

# CMAKE_EXECUTABLE_SUFFIX is undefined in CMAKE_TOOLCHAIN_FILE


#if(VCPKG_TARGET_TRIPLET MATCHES mipsel)
#	if ("${MIPS_CPU}" STREQUAL "")
#		set(MIPS_CFLAGS "${MIPS_CFLAGS} --eh-frame-hdr -melf32ltsmip -dynamic-linker -mips32 -mnan=legacy -mfp32 -mgp32 -mabi=32 -mabicalls -mshared -fPIC -fpic ")
#		set(MIPS_CXXFLAGS "${MIPS_CXXFLAGS} --eh-frame-hdr -melf32ltsmip -dynamic-linker -mips32 -mnan=legacy -mfp32 -mgp32 -mabi=32 -mabicalls -mshared -fPIC -fpic ")
#		set(MIPS_CFLAGS "${MIPS_CFLAGS} -mips32 -mshared -fPIC -fpic -mabi=32 -mfpxx -pthread ")
#		set(MIPS_CXXFLAGS "${MIPS_CXXFLAGS} -mips32 -mshared -fPIC -fpic -mabi=32 -mfpxx -pthread ")
#		set(MIPS_CFLAGS "${MIPS_CFLAGS} -mips32 -fPIC -mfpxx -mgp32 -mabi=32 -shared -pthread ")
#		set(MIPS_CXXFLAGS "${MIPS_CXXFLAGS} -mips32 -fPIC -mfpxx -mgp32 -mabi=32 -shared -pthread ")
#	endif ()

#	set(CPPFLAGS=" -D_FORTIFY_SOURCE=2 -D__USE_MINGW_ANSI_STDIO=1 ${CPPFLAGS} ")
#	set(CFLAGS=" -march=i686 -mtune=generic -g0 -O2 -pipe -Wl,-S ${CFLAGS} ")
#	set(CXXFLAGS=" -march=i686 -mtune=generic -g0 -O2 -pipe -Wl,-S ${CXXFLAGS} ")
set(CMAKE_C_COMPILER "${TOOLCHAIN_DIR}/bin/${CROSS_COMPILE}gcc${EXECUTABLE_SUFFIX}")
set(CMAKE_CXX_COMPILER "${TOOLCHAIN_DIR}/bin/${CROSS_COMPILE}g++${EXECUTABLE_SUFFIX}")
set(CC "${TOOLCHAIN_DIR}/bin/${CROSS_COMPILE}gcc${EXECUTABLE_SUFFIX}")
set(AS_EXECUTABLE "${TOOLCHAIN_DIR}/bin/${CROSS_COMPILE}as${EXECUTABLE_SUFFIX}")
#	set(CMAKE_COLLECT_GCC "${TOOLCHAIN_DIR}/bin/${CROSS_COMPILE}gcc")
#	set(CMAKE_C_COMPILER_ARG1 "-EL -march=mips32 -mips32 -fPIC -mfpxx -mgp32 -mabi=32 -shared -pthread ")
#	set(CMAKE_CXX_COMPILER_ARG1 "-EL -march=mips32 -mips32 -fPIC -mfpxx -mgp32 -mabi=32 -shared -pthread ")
set(CMAKE_C_FLAGS_RELEASE "-O3 -DNDEBUG")
set(CMAKE_C_FLAGS_DEBUG "-g")
set(CMAKE_C_FLAGS "-EL -march=mips32 -mips32 -fPIC -mfpxx -mgp32 -mabi=32 -shared -pthread -ldl -lm -lc")
set(CMAKE_CXX_FLAGS "-EL -march=mips32 -mips32 -fPIC -mfpxx -mgp32 -mabi=32 -shared -pthread -ldl -lm -lc")



set(CMAKE_EXECUTABLE_SUFFIX "")
#set(EXECUTABLE_SUFFIX ".exe")
#set(HOST_EXECUTABLE_SUFFIX ".exe")


#set(CMAKE_C_FLAGS "${CMAKE_CXX_FLAGS} -ldl -lm")
#set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -ldl -lm")

#set(VCPKG_C_FLAGS "${CMAKE_C_FLAGS}")
#set(VCPKG_CXX_FLAGS "${CMAKE_CXX_FLAGS}")
#endif ()

#set(LIBRARY_INCLUDE_DIRS 
#	${LIBRARY_INCLUDE_DIRS}
#	${CMAKE_SYSROOT}/include
#	${TOOLCHAIN_DIR}/include
#	${CMAKE_SYSROOT}/include
#	${CMAKE_STAGING}/include
#	${ROOTFS}/include
#	${CURRENT_INSTALLED_DIR}/include
#)

#set(LIBRARY_LIBS 
#	${LIBRARY_LIBS}
#	${CMAKE_SYSROOT}/lib
#	${CMAKE_SYSROOT}/lib
#	${TOOLCHAIN_DIR}/lib
#	${CMAKE_SYSROOT}/lib
#	${CMAKE_STAGING}/lib
#	${ROOTFS}/lib
#	${CURRENT_INSTALLED_DIR}/lib
#)

#set(CMAKE_FIND_LIBRARY_PREFIXES "")
#set(CMAKE_FIND_LIBRARY_SUFFIXES ".lib" ".dll")

set(CMAKE_FIND_LIBRARY_PREFIXES "lib" "lib32")
set(CMAKE_FIND_LIBRARY_SUFFIXES ".so" ".a")

#find_package(M REQUIRED)
#find_package(LZ4 REQUIRED)
#LD_LIBRARY_PATH 

#set(LDFLAGS "${EXTRA_LDFLAGS} ${LDFLAGS} -ldl -lm ")
#set(CMAKE_LDFLAGS "${EXTRA_LDFLAGS} ${LDFLAGS} -ldl -lm ")

#set(CMAKE_REQUIRED_LIBRARIES "-lm ")


#set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -lm -ldl")
#add_definitions( "-lm -ldl ")
#message("CMAKE_CXX_FLAGS is ${CMAKE_CXX_FLAGS}")

#set(SYSLIBS "-lm ${EXTRA_LDFLAGS} ${FINK_LDFLAGS} ${CMAKE_THREAD_LIBS_INIT} -ldl -lws2_32 -lwsock32")
#set(XLIBS "${XPMLIBDIR} ${XPMLIB} ${X11LIBDIR} -lXext -lX11")
#set(CILIBS "-lm ${EXTRA_LDFLAGS} ${FINK_LDFLAGS} -ldl -lws2_32 -lwsock32")



#set(CRYPTLIBS "-lcrypt")
set(CMAKE_M_LIBS "-lm")
set(CMAKE_DL_LIBS "-ldl")

#set(CMAKE_REQUIRED_FLAGS "-lm -ldl ")
#set(CMAKE_REQUIRED_LIBRARIES "-lm -ldl ")

#set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -pthread")
#set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -dl")
#set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -m")

#set(CMAKE_CXX_FLAGS "${CMAKE_C_FLAGS} -pthread")
#set(CMAKE_CXX_FLAGS "${CMAKE_C_FLAGS} -dl")
#set(CMAKE_CXX_FLAGS "${CMAKE_C_FLAGS} -m")

#set(CMAKE_USE_PTHREADS_INIT ON)
#set(CMAKE_CXX_FLAGS ${CMAKE_CXX_FLAGS} "-std=c++11 -pthread")
#find_package (Threads)
#add_executable (main src/main.cpp)
#target_link_libraries (main ${CMAKE_THREAD_LIBS_INIT})


#set(CMAKE_C_FLAGS ${CMAKE_C_FLAGS} "-pthread")


#set(CMAKE_EXE_LINKER_FLAGS "-shared --nable-shared -disable-static")
#set(CMAKE_SHARED_LINKER_FLAGS "-shared -enable-shared -disable-static")

#target_link_libraries(${LIBNAME} -pthread -c)

#link_directories("${TOOLCHAIN_DIR}/lib:${TOOLCHAIN_DIR}/sysroot:${CMAKE_INSTALL_PREFIX}/lib")


## '-mthreads' or '-Wl,--export-all-symbols' linking_type("--disable-static" "--enable-shared")
#set(CMAKE_EXE_LINKER_FLAGS
#set(CMAKE_MODULE_LINKER_FLAGS

##	-I PROGRAM, --dynamic-linker Set PROGRAM as the dynamic linker to use
##	--no-dynamic-linker         Produce an executable with no program interpreter header

##	-Bdynamic, -dy, -call_shared \\Link against shared libraries
##	-Bstatic, -dn, -non_shared, -static \\Do not link against shared libraries

#set(CMAKE_SHARED_LINKER_FLAGS " -EL --export-dynamic -Wl,--no-whole-archive -nodefaultlibs --for-linker --shared --enable-shared --disable-static ${SHARED_LINKER_FLAGS}")
set(CMAKE_SHARED_LINKER_FLAGS " -EL -export-dynamic --whole-file -nodefaultlibs -Bdynamic --no-sanitize=undefined -Wold-style-definition --warn-coverage-mismatch --no-cond-mismatch -shared --warn-unused-import -z muldefs ${SHARED_LINKER_FLAGS}")

#set(CMAKE_SHARED_LINKER_FLAGS " -no-whole-archive --nodefaultlibs -dynamic-linker -enable-shared -disable-static -export-all-symbols ${SHARED_LINKER_FLAGS}")
#set(CMAKE_SHARED_LINKER_FLAGS " -as-needed -no-whole-archive -dynamic-linker -enable-shared -disable-static -allow-multiple-definition ${SHARED_LINKER_FLAGS}")

#set(CMAKE_LINKER_FLAGS " -as-needed -no-whole-archive -dynamic-linker -enable-shared -disable-static -allow-multiple-definition ${SHARED_LINKER_FLAGS}")
#set(CMAKE_CXX_LINK_FLAGS "")
#set(CMAKE_C_LINK_FLAGS "")

#set(CMAKE_MODULE_LINKER_FLAGS "-Wl,--allow-multiple-definition")

#set(C_FAMILY_FLAGS_INIT "-ffunction-sections -fdata-sections -g -fno-common -fmessage-length=0 --specs=nosys.specs --specs=nano.specs")
#set(CMAKE_C_FLAGS_INIT "${C_FAMILY_FLAGS_INIT} -std=c99")
#set(CMAKE_CXX_FLAGS_INIT "${C_FAMILY_FLAGS_INI} -std=c++11")
#set(CMAKE_ASM_FLAGS_INIT "-fno-exceptions -fno-unwind-tables -x assembler-with-cpp")
#set(CMAKE_EXE_LINKER_FLAGS_INIT "-Wl,-gc-sections,-print-memory-usage")

#-DCMAKE_EXE_LINKER_FLAGS="-O3 -g0 -s 'EXPORTED_FUNCTIONS=[\"_argon2_hash\"]' -s BINARYEN=1"
#(-DCMAKE_EXE_LINKER_FLAGS="-static-libstdc++ -static-libgcc")
#-DCMAKE_EXE_LINKER_FLAGS="-nodefaultlibs -lc++ -lc++abi -lm -lc -lgcc_s -lgcc"


#-DCMAKE_MODULE_LINKER_FLAGS="-Wl,--allow-multiple-definition" \
#-DCMAKE_EXE_LINKER_FLAGS="-Wl,--allow-multiple-definition" \


#set(CMAKE_EXE_LINKER_FLAGS_INIT " -Wl,--enable-auto-import")


## 3.13 CMake has special command for such purpose: add_link_options
## "LINKER:-z,defs" //-Wl,-z,defs for GNU GCC// "LINKER:SHELL:-z defs"
#set(CMAKE_SHARED_LINKER_FLAGS "-Wl,--as-needed")

#set(CMAKE_STATIC_LINKER_FLAGS

#-mabi=32 -mfp64 -mframe-header-opt -modd-spreg -mhard-float



#--host=mipsel-linux-gnu 
#--target=mips-mti-linux-gnu
#--with-arch=mips32
#--enable-languages=c,c++
#--with-float=soft 
#--with-micromips



# RTCD versions of assembly flavor flags ("yes" means on in rtcd.pl, not 1).
#set(RTCD_ARCH_MIPS "yes")

#if (HAVE_DSPR2)
#  set(RTCD_HAVE_DSPR2 "yes")
#endif ()

#if (HAVE_MSA)
#  set(RTCD_HAVE_MSA "yes")
#endif ()

#foreach (config_var ${CONFIG_VARS})
#  if (${${config_var}})
#    set(RTCD_${config_var} yes)
#  endif ()
#endforeach ()

#if (ENABLE_DSPR2 AND ENABLE_MSA)
#  message(FATAL_ERROR "ENABLE_DSPR2 and ENABLE_MSA cannot be combined.")
#endif ()

#if (ENABLE_DSPR2)
#  set(HAVE_DSPR2 1 CACHE BOOL "" FORCE)

#  if ("${CROSS_COMPILE}" STREQUAL "")
#    # Default the cross compiler prefix to something known to work.
#    set(CROSS_COMPILE mips-linux-gnu-)
#  endif ()

#  set(MIPS_CFLAGS "-mdspr2")
#  set(MIPS_CXXFLAGS "-mdspr2")
#elseif (ENABLE_MSA)
#  set(HAVE_MSA 1 CACHE BOOL "" FORCE)

#  if ("${CROSS_COMPILE}" STREQUAL "")
#    # Default the cross compiler prefix to something known to work.
#    set(CROSS_COMPILE mips-mti-linux-gnu-)
#  endif ()

#  set(MIPS_CFLAGS "-mmsa")
#  set(MIPS_CXXFLAGS "-mmsa")
#endif ()

set(CMAKE_C_IMPLICIT_LINK_LIBRARIES "dl;m;posix4;c;gcc;gcc_s;pthread")
set(CMAKE_C_IMPLICIT_LINK_DIRECTORIES "I:/Compile/Imagination/Toolchains/mips-mti-linux-gnu/2018.09-03/lib/gcc/mips-mti-linux-gnu/6.3.0/mipsel-r1-hard/lib;I:/Compile/Imagination/Toolchains/mips-mti-linux-gnu/2018.09-03/mips-mti-linux-gnu/lib/mipsel-r1-hard/lib;I:/Compile/Imagination/Toolchains/mips-mti-linux-gnu/2018.09-03/lib/gcc/mips-mti-linux-gnu/6.3.0;I:/Compile/Imagination/Toolchains/mips-mti-linux-gnu/2018.09-03/lib/gcc;I:/Compile/Imagination/Toolchains/mips-mti-linux-gnu/2018.09-03/mips-mti-linux-gnu/lib;I:/Compile/Imagination/Toolchains/mips-mti-linux-gnu/2018.09-03/sysroot/mipsel-r1-hard/lib;I:/Compile/Imagination/Toolchains/mips-mti-linux-gnu/2018.09-03/sysroot/mipsel-r1-hard/usr/lib")
set(CMAKE_C_IMPLICIT_LINK_FRAMEWORK_DIRECTORIES "")

set(CMAKE_CXX_IMPLICIT_LINK_LIBRARIES ${CMAKE_C_IMPLICIT_LINK_LIBRARIES})
set(CMAKE_CXX_IMPLICIT_LINK_DIRECTORIES "${CMAKE_C_IMPLICIT_LINK_DIRECTORIES}")
set(CMAKE_CXX_IMPLICIT_LINK_FRAMEWORK_DIRECTORIES "")

# search for programs in the build host directories
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM BOTH)
# for libraries and headers in the target directories
# search headers and libraries in the target environment, search 
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY BOTH)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE BOTH)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE BOTH)

set(CPACK_DEBIAN_PACKAGE_ARCHITECTURE mipsel)
#INCLUDE_DIRECTORIES(SYSTEM /data/x-tools/mips-openwrt-linux/target-mips_34kc_uClibc-0.9.33.2/usr/include/)
#set(CROSS_COMPILE_LIBS /data/x-tools/mips-openwrt-linux/target-mips_34kc_uClibc-0.9.33.2/usr/lib)

include(CheckCSourceCompiles)
macro(add_header_include check header)
  if(${check})
    set(_source "#include <${header}>")
  endif()
endmacro()
if(HAVE_WINDOWS_H)
  add_header_include(HAVE_WINSOCK2_H "winsock2.h")
  add_header_include(HAVE_WINDOWS_H "windows.h")
  add_header_include(HAVE_WINSOCK_H "winsock.h")
  set(_source_epilogue
      "${_source}\n#ifndef WIN32_LEAN_AND_MEAN\n#define WIN32_LEAN_AND_MEAN\n#endif")
  set(signature_call_conv "PASCAL")
  if(HAVE_LIBWS2_32)
    set(CMAKE_REQUIRED_LIBRARIES ws2_32)
  endif()
else()
  add_header_include(HAVE_SYS_TYPES_H "sys/types.h")
  add_header_include(HAVE_SYS_SOCKET_H "sys/socket.h")
endif()

if(HAVE_WINDOWS_H)
  set(CMAKE_EXTRA_INCLUDE_FILES winsock2.h)
else()
  set(CMAKE_EXTRA_INCLUDE_FILES)
  if(HAVE_SYS_SOCKET_H)
    set(CMAKE_EXTRA_INCLUDE_FILES sys/socket.h)
  endif()
endif()

if(NOT HAVE_WINDOWS_H)
  add_header_include(HAVE_SYS_TIME_H "sys/time.h")
  add_header_include(TIME_WITH_SYS_TIME "time.h")
  add_header_include(HAVE_TIME_H "time.h")
endif()

endif ()
endif ()