if(CMAKE_SYSTEM_NAME STREQUAL "WindowsStore")
    set(CMAKE_SYSTEM_VERSION 10.0 CACHE STRING "")
endif()

#set (I386 "^(i[3-7]|x)86$")
#set (AMD64 "^(x86_|x86-|AMD|amd|x)64$")
#set (ARM32 "^(arm|ARM|A)(32)?$")
#set (ARM64 "^(arm|ARM|A|aarch|AArch)(64)?$")

#if (CMAKE_GENERATOR_PLATFORM)
#    set (_ARCH "${CMAKE_GENERATOR_PLATFORM}")
#else ()
#    set (_ARCH "${CMAKE_SYSTEM_PROCESSOR}")
#endif ()

#    if (CMAKE_GENERATOR MATCHES "^.*Win64$" OR _ARCH MATCHES "${AMD64}")
#        set (ARCH "x86_64")
#        set (ABI "win")
#        set (BITS 64)

if(NOT CMAKE_SYSTEM_PROCESSOR)
    if(VCPKG_TARGET_ARCHITECTURE STREQUAL "arm")
        set(CMAKE_SYSTEM_PROCESSOR ARM CACHE STRING "")
    elseif(VCPKG_TARGET_ARCHITECTURE STREQUAL "arm64")
        set(CMAKE_SYSTEM_PROCESSOR ARM64 CACHE STRING "")
		
    elseif(VCPKG_TARGET_ARCHITECTURE STREQUAL "x64")
        set(CMAKE_SYSTEM_PROCESSOR AMD64 CACHE STRING "")
        set(TARGET_ARCHITECTURE AMD64 CACHE STRING "")
		set(BITS 64 CACHE STRING "")
        set(ABI "win" CACHE STRING "")
		set(ARCH "x86_64"  CACHE STRING "")
		
    elseif(VCPKG_TARGET_ARCHITECTURE STREQUAL "x86")
        set(CMAKE_SYSTEM_PROCESSOR X86 CACHE STRING "")
        set(TARGET_ARCHITECTURE X86 CACHE STRING "")
        set(ARCH "i386" CACHE STRING "")
        set(ABI "cdecl" CACHE STRING "")
        set(BITS 32 CACHE STRING "")
        set(ARCH_x86 1 CACHE STRING "")
		
    elseif(VCPKG_TARGET_ARCHITECTURE STREQUAL "i386")
        set(CMAKE_SYSTEM_PROCESSOR X86 CACHE STRING "")
        set(TARGET_ARCHITECTURE X86 CACHE STRING "")
    elseif(VCPKG_TARGET_ARCHITECTURE STREQUAL "x86_64")
        set(CMAKE_SYSTEM_PROCESSOR AMD64 CACHE STRING "")
        set(TARGET_ARCHITECTURE AMD64 CACHE STRING "")
    elseif(NOT VCPKG_TARGET_ARCHITECTURE)
        message(STATUS "VCPKG_TARGET_ARCHITECTURE is not set")
    else()
        message(FATAL_ERROR "Unknow target architecture: ${VCPKG_TARGET_ARCHITECTURE}")
    endif()
endif()

get_property( _CMAKE_IN_TRY_COMPILE GLOBAL PROPERTY IN_TRY_COMPILE )
if(NOT _CMAKE_IN_TRY_COMPILE)

    if(VCPKG_CRT_LINKAGE STREQUAL "dynamic")
        set(VCPKG_CRT_LINK_FLAG_PREFIX " /MD")
    elseif(VCPKG_CRT_LINKAGE STREQUAL "static")
        set(VCPKG_CRT_LINK_FLAG_PREFIX " /MT")
    else()
        message(FATAL_ERROR "Invalid setting for VCPKG_CRT_LINKAGE: \"${VCPKG_CRT_LINKAGE}\". It must be \"static\" or \"dynamic\"")
    endif()
	
#    if(VCPKG_PLATFORM_TOOLSET MATCHES "v120")
#    set(CHARSET_FLAG "/utf-8")
#    if (NOT VCPKG_SET_CHARSET_FLAG OR VCPKG_PLATFORM_TOOLSET MATCHES "v120")
#        # VS 2013 does not support /utf-8
#        set(CHARSET_FLAG)
#    endif()

    if(VCPKG_FORTRAN_ENABLED AND DEFINED VCPKG_FORTRAN_COMPILER AND VCPKG_FORTRAN_COMPILER STREQUAL Intel)
        # Make sure the name mangling of Intel Fortran generated symbols is all lowercase with underscore suffix
        # because this is assumed by many libraries (that e.g. consume BLAS/LAPACK)
		
#		set(ENV{FFLAGS} " /W4 /nologo /libs:static /names:lowercase /assume:underscore ")
#		set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -fpp")
#		set(ENV{FFLAGS} "$ENV{FFLAGS} /nologo /names:lowercase /assume:underscore")
		set(CMAKE_Fortran_FLAGS " /fpp /W4 /nologo /names:lowercase /assume:underscore /threads ")
        # When using the Intel and VS2017 command line environments together there is a bug when
        # using cl and some standard headers are included (e.g. stdint.h). This is because Intel does
        # not handle the changed directory structure of the runtime headers between VS2015 and VS2017 correctly.
        # The following code works around those issues. This is true as of Intel 2017.4 and VS2017.3.
		
#        set(CMAKE_Fortran_COMPILER "ifort" CACHE STRING "")
#        set(CMAKE_FC_COMPILER "ifort" CACHE STRING "")
#        set(CMAKE_C_COMPILER "cl" CACHE STRING "")
#        set(CMAKE_CXX_COMPILER "cl" CACHE STRING "")
		
#		set(CMAKE_Fortran_COMPILER "C:/Program Files (x86)/IntelSWTools/compilers_and_libraries/windows/bin/intel64/ifort.exe" CACHE STRING "")
#		set(CMAKE_FC_COMPILER "C:/Program Files (x86)/IntelSWTools/compilers_and_libraries/windows/bin/intel64/ifort.exe" CACHE STRING "")

		if(VCPKG_CRT_LINKAGE STREQUAL "static")
#			string(REPLACE "/libs:dll" "/libs:static" CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS}")
#			set(ENV{FFLAGS} "$ENV{FFLAGS} /libs:static")
			set(CMAKE_Fortran_FLAGS " ${CMAKE_Fortran_FLAGS} /libs:static ")
		elseif(VCPKG_CRT_LINKAGE STREQUAL "dynamic")
			set(CMAKE_Fortran_FLAGS " ${CMAKE_Fortran_FLAGS} /libs:dll ")
		endif()
		## CMAKE_Fortran_STANDARD_LIBRARIES
        if(VCPKG_PLATFORM_TOOLSET STREQUAL "v163")
            file(TO_CMAKE_PATH "$ENV{VCToolsInstallDir}" VCToolsInstallDir)
#            file(TO_NATIVE_PATH "$ENV{VCToolsInstallDir}" VCToolsInstallDir)

            string(APPEND VCPKG_CXX_FLAGS " /D__MS_VC_INSTALL_PATH=\"${VCToolsInstallDir}\"")
            string(APPEND VCPKG_C_FLAGS " /D__MS_VC_INSTALL_PATH=\"${VCToolsInstallDir}\"")
        endif()
    endif()
    
    if(VCPKG_FORTRAN_ENABLED AND DEFINED VCPKG_FORTRAN_COMPILER AND VCPKG_FORTRAN_COMPILER STREQUAL Flang)
        # Make sure that CMake uses the correct compilers:
        # while we want to use flang as Fortran compiler we want to keep cl for C and C++
        set(CMAKE_Fortran_COMPILER "flang" CACHE STRING "")
        set(CMAKE_C_COMPILER "cl" CACHE STRING "")
        set(CMAKE_CXX_COMPILER "cl" CACHE STRING "")
    endif()

    # When using GNU gfortran as Fortran compiler CMake requires to use gcc and g++ as C and C++ compilers
    # so we should not set all the other C and C++ compiler flags
    if(VCPKG_FORTRAN_ENABLED AND DEFINED VCPKG_FORTRAN_COMPILER AND VCPKG_FORTRAN_COMPILER STREQUAL GNU)
        set(CMAKE_GNUtoMS "ON" CACHE STRING "")
    else()
#    set(CMAKE_CXX_FLAGS " /guard:cf- /analyze- /nologo /openmp /DWIN32 /D_WINDOWS /WX- /bigobj /GR /EHsc /MP ${VCPKG_CXX_FLAGS}" CACHE STRING "")
#    set(CMAKE_C_FLAGS " /guard:cf- /analyze- /nologo /openmp /DWIN32 /D_WINDOWS /WX- /bigobj /GR- /EHsc /MP ${VCPKG_C_FLAGS}" CACHE STRING "")

#    string(APPEND CMAKE_CXX_STANDARD_LIBRARIES_INIT "DbgHelp.libWSock32.lib MsWSock.lib WinMM.lib Psapi.lib WS2_32.lib Version.lib SetupAPI.lib Wldap32.lib Crypt32.lib iphlpapi.lib dsound.lib strmiids.lib delayimp.lib odbc32.lib odbccp32.lib mscoree.lib libiomp5md.lib ${CMAKE_CXX_STANDARD_LIBRARIES}" CACHE STRING "")
#    string(APPEND CMAKE_C_STANDARD_LIBRARIES_INIT "DbgHelp.libWSock32.lib MsWSock.lib WinMM.lib Psapi.lib WS2_32.lib Version.lib SetupAPI.lib Wldap32.lib Crypt32.lib iphlpapi.lib dsound.lib strmiids.lib delayimp.lib odbc32.lib odbccp32.lib mscoree.lib libiomp5md.lib ${CMAKE_C_STANDARD_LIBRARIES}" CACHE STRING "")


    if((NOT DEFINED VCPKG_CXX_FLAGS AND NOT DEFINED VCPKG_C_FLAGS) OR (DEFINED VCPKG_CXX_FLAGS AND DEFINED VCPKG_C_FLAGS))
        set(CMAKE_STANDARD_LIBRARIES "kernel32.lib user32.lib gdi32.lib winspool.lib shell32.lib ole32.lib oleaut32.lib uuid.lib comdlg32.lib advapi32.lib DbgHelp.lib WSock32.lib MsWSock.lib WinMM.lib Wtsapi32.lib Psapi.lib OpenGL32.Lib WS2_32.lib Version.lib SetupAPI.lib Wldap32.lib Crypt32.lib iphlpapi.lib dsound.lib strmiids.lib delayimp.lib odbc32.lib odbccp32.lib Bcrypt.lib winhttp.lib rpcrt4.lib dxguid.lib mscoree.lib legacy_stdio_definitions.lib libiomp5md.lib pthreadVC3.lib mman.lib popt.lib libpopt.lib getopt.lib bz2.lib")
        set(CMAKE_CXX_STANDARD_LIBRARIES " ${CMAKE_STANDARD_LIBRARIES}" CACHE STRING "")
        set(CMAKE_C_STANDARD_LIBRARIES " ${CMAKE_STANDARD_LIBRARIES}" CACHE STRING "")
		
###        set(CMAKE_EXE_DLL_FLAGS " /DEFAULTLIB:wsock32.lib /DEFAULTLIB:mswsock.lib /DEFAULTLIB:winmm.lib /DEFAULTLIB:psapi.lib /DEFAULTLIB:ws2_32.lib /DEFAULTLIB:version.lib /DEFAULTLIB:setupapi.lib /DEFAULTLIB:wldap32.lib /DEFAULTLIB:crypt32.lib /DEFAULTLIB:iphlpapi.lib /DEFAULTLIB:dsound.lib /DEFAULTLIB:strmiids.lib /DEFAULTLIB:delayimp.lib /DEFAULTLIB:odbc32.lib /DEFAULTLIB:odbccp32.lib /DEFAULTLIB:mscoree.lib")
###        set(CMAKE_DEFAULT_LIB_FLAGS " /DEFAULTLIB:WSOCK32;MSWSOCK;WINMM;PSAPI;WS2_32;VERSION;SETUPAPI;WLDAP32;CRYPT32;IPHLPAPI;DSOUND;STRMIIDS;DELAYIMP;ODBC32;ODBCCP32;MSCOREE ")
	
#    add_compile_options(-FC)
#    if (MSVC_VERSION GREATER 1900)
#        # Visual Studio 2017 or later        add_compile_options(-std:c++17 -permissive-)
#    else()
#        # Visual Studio 2015         add_compile_options(-std:c++latest)
	
    elseif(MSVC)
        set(CMAKE_CXX_STANDARD_LIBRARIES "%(AdditionalDependencies);${CMAKE_STANDARD_LIBRARIES}" CACHE STRING "")
        set(CMAKE_C_STANDARD_LIBRARIES "%(AdditionalDependencies);${CMAKE_STANDARD_LIBRARIES}" CACHE STRING "")
    else()
        message(FATAL_ERROR " ... and ... ")
    endif()
	#/permissive- /Zc:twoPhase- /GR-  /sdl
	#/std:c++17 /permissive- /D_WIN32 /D_WIN32 
	
	# 27 Oct 2017 in C++ / Coroutines / Concurrency / Async / Await / Future / Promise
	#use /await compiler switch to enable coroutines + use /std:c++17
	#/std:c++latest
	
	#/D_SILENCE_ALL_CXX17_DEPRECATION_WARNINGS /std:c++17 /permissive- /await 
	#/D_SILENCE_ALL_CXX17_DEPRECATION_WARNINGS /std:c++17 /permissive- /await
	#-openmp:experimental
# LINUX
#error #elif defined(__x86_64__) || defined(__amd64__)

#x64
#/D_M_IX64 

#x86
#/D_M_IX86 
	#error #elif defined(__x86_64__) || defined(__amd64__) /D_WIN32 #LINUX /D_AMD64_ /D__x86_64__ 
	
    set(CMAKE_CXX_FLAGS " /nologo /EHsc /D_WINDOWS /DWINDOWS /DWIN32 /D_WIN32 /D_M_X64 /D_WIN64 /MP /FS /FC /d2Zi+ /d1scalableinclude- /W4 /guard:cf- /analyze- /WX- /bigobj ${VCPKG_CXX_FLAGS}" CACHE STRING "")
    set(CMAKE_C_FLAGS " /nologo /EHsc /D_WINDOWS /DWINDOWS /DWIN32 /D_WIN32 /D_M_X64 /D_WIN64 /MP /FS /FC /d1scalableinclude- /W4 /guard:cf- /analyze- /WX- /bigobj /openmp ${VCPKG_C_FLAGS}" CACHE STRING "")
	#/MP 
#	disable C++ RTTI /GR-
#	set(CMAKE_C_FLAGS " /guard:cf- /analyze- /nologo /openmp /DWIN32 /WX- /bigobj /GR- /EHsc ${VCPKG_C_FLAGS}" CACHE STRING "")
#    set(CMAKE_RC_FLAGS " /nologo -c65001 /DWIN32 /l0x419 ${CMAKE_RC_FLAGS}" CACHE STRING "")
    set(CMAKE_RC_FLAGS " -c65001 /D_WIN32 /DWIN32 ${CMAKE_RC_FLAGS} " CACHE STRING "")

    set(CMAKE_RC_FLAGS_DEBUG " /D_DEBUG ${CMAKE_RC_FLAGS_DEBUG}" CACHE STRING "")
    set(CMAKE_RC_FLAGS_RELEASE " ${CMAKE_RC_FLAGS_RELEASE}" CACHE STRING "")
#	set(CMAKE_RC_COMPILE_OBJECT " /l0x419 ${CMAKE_RC_COMPILE_OBJECT}" CACHE STRING "")
	
	## CMAKE_RC_COMPILE_OBJECT -- влияет на компиляцию, но ошибка
#    set(CMAKE_RC_COMPILE_OBJECT "<CMAKE_RC_COMPILER> /l0x419 /fo<OBJECT> <SOURCE>")
    set(CMAKE_COMPILE_RESOURCE "rc <FLAGS> /l0x0419 /fo<OBJECT> <SOURCE> ")

    set(CMAKE_CXX_FLAGS_DEBUG " /D_DEBUG ${VCPKG_CRT_LINK_FLAG_PREFIX}d /Zi /Ob0 /Od /RTC1 ${VCPKG_CXX_FLAGS_DEBUG}" CACHE STRING "")
    set(CMAKE_C_FLAGS_DEBUG " /D_DEBUG ${VCPKG_CRT_LINK_FLAG_PREFIX}d /Z7 /Ob0 /Od /RTC1 ${VCPKG_C_FLAGS_DEBUG}" CACHE STRING "")
#    set(CMAKE_CXX_FLAGS_RELEASE "${VCPKG_CRT_LINK_FLAG_PREFIX} /O2 /Oi /Gy /DNDEBUG /Z7 ${VCPKG_CXX_FLAGS_RELEASE}" CACHE STRING "")
#    set(CMAKE_C_FLAGS_RELEASE "${VCPKG_CRT_LINK_FLAG_PREFIX} /O2 /Oi /Gy /DNDEBUG /Z7 ${VCPKG_C_FLAGS_RELEASE}" CACHE STRING "")
    set(CMAKE_CXX_FLAGS_RELEASE " ${VCPKG_CRT_LINK_FLAG_PREFIX} /O1 /Oi /Os /DNDEBUG /Zi ${VCPKG_CXX_FLAGS_RELEASE}" CACHE STRING "")
    set(CMAKE_C_FLAGS_RELEASE " ${VCPKG_CRT_LINK_FLAG_PREFIX} /O1 /Oi /Os /DNDEBUG /Z7 ${VCPKG_C_FLAGS_RELEASE}" CACHE STRING "")
	
	set(CMAKE_LINKER_FLAGS " /DEBUG /INCREMENTAL:NO /VERBOSE ${CMAKE_LINKER_FLAGS} ")
#/Gy- /GL 
#/Gm- /Oy- /Gy- /GL 

#    Можно использовать /INCLUDE возможность переопределения удаления конкретного символа
#    /Bv ##64-bin link force
#    /ORDER	##https://docs.microsoft.com/en-us/cpp/build/reference/order-put-functions-in-order?view=vs-2019
#	"/VERBOSE:INCR,ICF,LIB,REF,UNUSEDLIBS /TIME /INCREMENTAL:NO /OPT:NOREF,NOICF
    set(CMAKE_SHARED_LINKER_FLAGS " /VERBOSE /SAFESEH:NO ${CMAKE_SHARED_LINKER_FLAGS} " CACHE STRING "")
    set(CMAKE_SHARED_LINKER_FLAGS_RELEASE " /NODEFAULTLIB:LIBC;LIBCP;LIBCMT;LIBCPMT;LIBVCRUNTIME;MSVCPRTD;MSVCRTD;VCOMP;VCOMPD ${VCPKG_LINKER_FLAGS}" CACHE STRING "")
	# /LTCG:OFF
    set(CMAKE_SHARED_LINKER_FLAGS_DEBUG " /NODEFAULTLIB:LIBCD;LIBCPD;LIBCMTD;LIBCPMTD;LIBVCRUNTIMED;MSVCPRT;MSVCRT;VCOMP;VCOMPD ${VCPKG_LINKER_FLAGS}" CACHE STRING "")

#    set (CMAKE_SHARED_LIBRARY_LINK_C_FLAGS "-static")
#    set (CMAKE_SHARED_LIBRARY_LINK_CXX_FLAGS "-static")
	
#    set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} /FORCE:MULTIPLE")
# CMAKE_EXE_LINKER_FLAGS "/nologo /DYNAMICBASE /NXCOMPAT /LARGEADDRESSAWARE")
#/NODEFAULTLIB:vcomp.lib /NODEFAULTLIB:vcompd.lib /TIME  /OPT:REF /OPT:NOICF /DEBUG /INCREMENTAL:NO
#
    set(CMAKE_EXE_LINKER_FLAGS " /VERBOSE ${CMAKE_EXE_LINKER_FLAGS} ${VCPKG_LINKER_FLAGS} ${CMAKE_EXE_DLL_FLAGS}" CACHE STRING "")
    set(CMAKE_EXE_LINKER_FLAGS_RELEASE " /nologo /DISALLOWLIB:vcomp.lib ${VCPKG_LINKER_FLAGS}" CACHE STRING "")
	#/LTCG:OFF 
    set(CMAKE_EXE_LINKER_FLAGS_DEBUG " /nologo /DISALLOWLIB:vcompd.lib ${VCPKG_LINKER_FLAGS}" CACHE STRING "")

#    set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} /NODEFAULTLIB:MSVCRT;MSVCRTD")
#    set(CMAKE_EXE_LINKER_FLAGS_DEBUG "${CMAKE_EXE_LINKER_FLAGS_DEBUG} /NODEFAULTLIB:LIBC;LIBCP;LIBCMT;LIBCPMT")
#    set(CMAKE_EXE_LINKER_FLAGS_RELEASE "${CMAKE_EXE_LINKER_FLAGS_RELEASE} /NODEFAULTLIB:LIBCD;LIBCPD;LIBCMTD;LIBCPMTD")

#    set(CMAKE_MODULE_LINKER_FLAGS_RELEASE "/LTCG /VERBOSE /TIME /INCREMENTAL:NO /OPT:REF,NOICF ${VCPKG_LINKER_FLAGS}" CACHE STRING "")
#    set(CMAKE_MODULE_LINKER_FLAGS_DEBUG "/VERBOSE /TIME /DEBUG /INCREMENTAL:NO /LTCG:OFF /OPT:REF,NOICF ${VCPKG_LINKER_FLAGS}" CACHE STRING "")
#LINK : warning LNK4044: unrecognized option '/DEBUG'; ignored
#LINK : warning LNK4044: unrecognized option '/INCREMENTAL:NO'; ignored
#LINK : warning LNK4044: unrecognized option '/OPT:REF,NOICF'; ignored
    set(CMAKE_STATIC_LINKER_FLAGS " /NODEFAULTLIB:VCOMP;VCOMPD /VERBOSE ${CMAKE_STATIC_LINKER_FLAGS} " CACHE STRING "")
    set(CMAKE_STATIC_LINKER_FLAGS_RELEASE " /NODEFAULTLIB:MSVCPRT;MSVCRT;VCRUNTIME;UCRT;MVCRT;MVCPRT;UCRTBASE;VCOMP ${VCPKG_LINKER_FLAGS}" CACHE STRING "")
	#/LTCG:OFF 
    set(CMAKE_STATIC_LINKER_FLAGS_DEBUG " /NODEFAULTLIB:MSVCPRTD;MSVCRTD;VCRUNTIMED;UCRTD;MVCRTD;MVCPRTD;UCRTBASED;VCOMPD ${VCPKG_LINKER_FLAGS}" CACHE STRING "")
	
    #Fortran
    list(APPEND CMAKE_Fortran_FLAGS_INIT ${VCPKG_Fortran_FLAGS})
    list(APPEND CMAKE_Fortran_FLAGS_RELEASE_INIT ${VCPKG_Fortran_FLAGS_RELEASE})
    list(APPEND CMAKE_Fortran_FLAGS_DEBUG_INIT ${VCPKG_Fortran_FLAGS_DEBUG})
	
#    list(APPEND CMAKE_CXX_STANDARD_LIBRARIES_INIT ${VCPKG_CXX_STANDARD_LIBRARIES} "WSock32.lib MsWSock.lib WinMM.lib Psapi.lib WS2_32.lib Version.lib SetupAPI.lib Wldap32.lib Crypt32.lib iphlpapi.lib dsound.lib strmiids.lib delayimp.lib odbc32.lib odbccp32.lib mscoree.lib libiomp5md.lib DbgHelp.lib")
#    list(APPEND CMAKE_C_STANDARD_LIBRARIES_INIT ${VCPKG_C_STANDARD_LIBRARIES} "WSock32.lib MsWSock.lib WinMM.lib Psapi.lib WS2_32.lib Version.lib SetupAPI.lib Wldap32.lib Crypt32.lib iphlpapi.lib dsound.lib strmiids.lib delayimp.lib odbc32.lib odbccp32.lib mscoree.lib libiomp5md.lib DbgHelp.lib")
	
###    if(MSYS OR MINGW)
#    if(WIN32)
#        set(CMAKE_EXTRA_LINK_EXTENSIONS ".lib" ".a" ".dll") # MinGW can also link to a MS .lib
#    endif()

#    if(WIN32)
#        set(CMAKE_FIND_LIBRARY_PREFIXES "lib" "")
#		set(EXECUTABLE_SUFFIX ".exe" )
#        set(CMAKE_FIND_LIBRARY_SUFFIXES ".dll" ".dll.a" ".a" ".lib")
###        set(CMAKE_C_STANDARD_LIBRARIES_INIT "WSock32.lib MsWSock.lib WinMM.lib Psapi.lib WS2_32.lib Version.lib SetupAPI.lib Wldap32.lib Crypt32.lib iphlpapi.lib dsound.lib strmiids.lib delayimp.lib odbc32.lib odbccp32.lib mscoree.lib libiomp5md.lib DbgHelp.lib")
###        set(CMAKE_CXX_STANDARD_LIBRARIES_INIT "${CMAKE_C_STANDARD_LIBRARIES_INIT}")
#    endif()

#CMAKE_ASM_MASM_FLAGS:STRING=
#CMAKE_ASM_MASM_FLAGS_DEBUG:STRING=
#CMAKE_ASM_MASM_FLAGS_RELEASE:STRING=
#if(MSVC AND NOT MSVC_VERSION LESS 1310
#  if(${CMAKE_GENERATOR} MATCHES "Visual Studio")
#    if(NOT MSVC60)

# LINUX
#error #elif defined(__x86_64__) || defined(__amd64__)

#x64
#/D_M_IX64 

#x86
#/D_M_IX86 
    if(CMAKE_SIZEOF_VOID_P EQUAL 8)
        set(CMAKE_ASM_MASM_FLAGS " /nologo /D_M_X86 /W4 /Cx /Zi /Zd /safeseh /errorReport:none /Zf")
    else()
        set(CMAKE_ASM_MASM_FLAGS " /nologo /D_WIN64 /D_M_X64 /Dx64 /W4 /Cx /Zi /Zd /errorReport:none /Zf")
    endif()

#    if(BITS EQUAL 32)
#        set(CMAKE_ASM_MASM_FLAGS "/nologo /D_M_X86 /W3 /Cx /Zi /safeseh /errorReport:none /Zf")
#    else()
#        set(CMAKE_ASM_MASM_FLAGS "/nologo /D_WIN64 /D_M_X64 /W3 /Cx /Zi /errorReport:none /Zf")
#    endif()

  endif()
endif()
