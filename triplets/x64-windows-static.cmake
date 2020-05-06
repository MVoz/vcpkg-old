#set(CMAKE_CROSSCOMPILING "FALSE")
#set(CMAKE_SYSTEM_LOADED 1)
#set(NINJA_CAN_BE_USED OFF)
#set(ENABLE_PARALLEL OFF)
#set(NINJA_HOST OFF)
#set(VCPKG_CXX_FLAGS -D_WIN32_WINNT=0x0603)
#set(VCPKG_C_FLAGS -D_WIN32_WINNT=0x0603)
set(VCPKG_TARGET_ARCHITECTURE x64)
set(VCPKG_CRT_LINKAGE static)
# set(VCPKG_CRT_LINKAGE dynamic)
#set(TRIPLET_SYSTEM_ARCH x64)
set(VCPKG_LIBRARY_LINKAGE static)
#"-DVCPKG_CXX_FLAGS=" "-DVCPKG_CXX_FLAGS_RELEASE=" "-DVCPKG_CXX_FLAGS_DEBUG=" "-DVCPKG_C_FLAGS=" "-DVCPKG_C_FLAGS_RELEASE=" "-DVCPKG_C_FLAGS_DEBUG=" "-DVCPKG_CRT_LINKAGE=static" "-DVCPKG_LINKER_FLAGS="
#set(VS_PLATFORM_TOOLSET_OVERRIDE "Intel C++ Compiler 19.0")
#set(VS_PLATFORM_TOOLSET "Intel C++ Compiler 19.0")
set(VCPKG_SYSTEM_VERSION "10.0.17134")
set(VCPKG_PLATFORM_TOOLSET v141)
#set(PLATFORM_TOOLSET v141)
#set(TARGET_CPU x64)
#set(CMAKE_HOST_SYSTEM_VERSION "10.0.17134")
set(CMAKE_HOST_SYSTEM_PROCESSOR "AMD64")
set(CMAKE_SYSTEM_VERSION "10.0.17134")
set(CMAKE_SYSTEM_PROCESSOR "AMD64")
set(VCPKG_CMAKE_SYSTEM_VERSION "10.0.17134")
#set(CMAKE_HOST_SYSTEM_NAME "Windows")
#set(CMAKE_SYSTEM_NAME "Windows")

set(VCPKG_CMAKE_SYSTEM_PROCESSOR AMD64)
#set(VCPKG_TARGET_TRIPLET_ARCH x64)
#set(VCPKG_TARGET_TRIPLET_PLAT "Windows")
#set(CMAKE_SYSTEM_VERSION 10.0.15063)

# set(VCPKG_FORTRAN_COMPILER Intel) # Flang, GNU, Intel, PGI
#set(VCPKG_FORTRAN_ENABLED OFF)
# set(VCPKG_FORTRAN_COMPILER PGI)
#set(VCPKG_FORTRAN_COMPILER Intel)
#set(VCPKG_FORTRAN_TOOLSET_VERSION 19)
#set(VCPKG_CMAKE_SYSTEM_NAME Windows)

#set(CMAKE_C_COMPILER_ID MSVC)
#set(CMAKE_CXX_COMPILER_ID MSVC)
#set(CMAKE_PLATFORM_TOOLSET v141)
#set(PLATFORM_TOOLSET v141)
#set(CMAKE_GENERATOR_TOOLSET v120)
#set(VCPKG_TARGET_TRIPLET x64-windows-static)
#set(CMAKE_TARGET_TRIPLET x64-windows-static)
#set(TARGET_TRIPLET x64-windows-static)
## set(ENV{VS150COMNTOOLS} "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\Common7\\Tools\\")
#set(VCPKG_BUILD_TYPE release)
#set(VCPKG_POLICY_EMPTY_PACKAGE enabled) ## Unknown setting for policy 'PolicyEmptyPackage': ON
#set(VCPKG_CMAKE_SYSTEM_NAME Linux)
#set(CMAKE_HOST_SYSTEM_NAME Linux)
#set(VCPKG_CMAKE_SYSTEM_NAME Android)
#set(VCPKG_APPLOCAL_DEPS ON)
#set(VCPKG_APPLOCAL_DEPS OFF)

#set(VCPKG_CXX_FLAGS_DEBUG )
#set(VCPKG_CXX_FLAGS_RELEASE )
#set(VCPKG_C_FLAGS )
#set(VCPKG_C_FLAGS_DEBUG )
#set(VCPKG_C_FLAGS_RELEASE )
#set(CMAKE_C_COMPILER_VERSION )
#set(CMAKE_CXX_COMPILER_VERSION )

#set(CMAKE_SYSTEM_VERSION 10.0.17134)
#set(VCPKG_SYSTEM_VERSION 10.0.17134.0)
#set(VCPKG_TARGET_PLATFORM_VERSION 10.0.17134)
#set(CMAKE_TARGET_PLATFORM_VERSION 10.0.17134)
#set(WINDOWS_TARGET_PLATFORM_VERSION 10.0.17134)
#set(CMAKE_VS_WINDOWS_TARGET_PLATFORM_VERSION 10.0.17134)

#set(CMAKE_SYSTEM_VERSION 10.0.15063)
#set(CMAKE_SYSTEM_VERSION 10.0.16299)
#[PLATFORM_TOOLSET <" ${VCPKG_PLATFORM_TOOLSET}>]
#set(TARGET_PLATFORM_VERSION 10.0.17134.0)

#set(VCPKG_TARGET_PLATFORM_VERSION 10.0.15063)
#set(TARGET_PLATFORM_VERSION 10.0.17134)
#set(TARGET_PLATFORM_VERSION 10.0.15063.0)
#[TARGET_PLATFORM_VERSION <10.0.15063.0>]
#set(WINDOWS_TARGET_PLATFORM_VERSION 10.0.15063.0)
#set(CMAKE_VS_WINDOWS_TARGET_PLATFORM_VERSION 10.0.15063.0)
#set(VCPKG_CMAKE_SYSTEM_VERSION 10.0.15063)
#set(VCPKG_SYSTEM_VERSION 10.0.15063)

##//ASM compiler
#set(CMAKE_ASM_COMPILER C:/Program Files (x86)/Microsoft Visual Studio 14.0/VC/bin/x86_amd64/cl.exe
#set(CMAKE_ASM_COMPILER "C:/Program Files (x86)/Microsoft Visual Studio 14.0/VC/bin/x86_amd64/ml64.exe")

#message("VCPKG_TARGET_ARCHITECTURE=${VCPKG_TARGET_ARCHITECTURE}")
#message("VCPKG_CMAKE_SYSTEM_NAME=${VCPKG_CMAKE_SYSTEM_NAME}")
#message("VCPKG_CMAKE_SYSTEM_VERSION=${VCPKG_CMAKE_SYSTEM_VERSION}")
#message("VCPKG_PLATFORM_TOOLSET=${VCPKG_PLATFORM_TOOLSET}")
#message("VCPKG_VISUAL_STUDIO_PATH=${VCPKG_VISUAL_STUDIO_PATH}")
#message("VCPKG_CHAINLOAD_TOOLCHAIN_FILE=${VCPKG_CHAINLOAD_TOOLCHAIN_FILE}")
#message("VCPKG_BUILD_TYPE=${VCPKG_BUILD_TYPE}")
#message(STATUS "CMAKE_SYSTEM_NAME is ${CMAKE_SYSTEM_NAME}")
#message(STATUS "CMAKE_SYSTEM_VERSION is ${CMAKE_SYSTEM_VERSION}")

#set(VCPKG_USE_HEAD_VERSION 1)

#set(COLOR_MSG_SUPPORTED TRUE)

#if(COLOR_CMAKE_MESSAGES)
#    message("If you can't see the following build report, then you need to turn off COLOR_CMAKE_MESSAGES")
#endif()

#set(CMAKE_CXX_FLAGS=" -D_SCL_SECURE_NO_WARNINGS -DHAVE_ROUND ")

## работает
#set(VCPKG_CXX_FLAGS " -D_SCL_SECURE_NO_WARNINGS -DHAVE_ROUND ${VCPKG_CXX_FLAGS}")

#set(VCPKG_CXX_FLAGS " -D_SCL_SECURE_NO_WARNINGS -DHAVE_ROUND ${VCPKG_CXX_FLAGS}")
#set(VCPKG_C_FLAGS " -D_SCL_SECURE_NO_WARNINGS -DHAVE_ROUND ${VCPKG_CXX_FLAGS}")
#set(FFLAGS " /names:lowercase /assume:underscore" ${FFLAGS})
#set(FFLAGS " /names:lowercase /assume:underscore" ${FFLAGS})
#set(CMAKE_Fortran_FLAGS " /names:lowercase /assume:underscore" ${CMAKE_Fortran_FLAGS})

#set(VCPKG_CXX_FLAGS_RELEASE " ${VCPKG_CXX_FLAGS_RELEASE}")
#set(VCPKG_CXX_FLAGS_DEBUG " ${VCPKG_CXX_FLAGS_DEBUG}")
#set(VCPKG_C_FLAGS " ${VCPKG_C_FLAGS}")
#set(VCPKG_C_FLAGS_RELEASE " ${VCPKG_C_FLAGS_RELEASE}")
#set(VCPKG_C_FLAGS_DEBUG " ${VCPKG_C_FLAGS_DEBUG}")

#set(VCPKG_CXX_FLAGS " /DWIN32 /D_WINDOWS /W3 /utf-8 /GR /EHsc /MP ${VCPKG_CXX_FLAGS}")
#set(VCPKG_C_FLAGS " /DWIN32 /D_WINDOWS /W3 /utf-8 /MP ${VCPKG_C_FLAGS}")

#set(VCPKG_CMAKE_GENERATOR "")

##  toolset (e.g. via the cmake(1) -T option) toolset[,key=value]*
#set(CMAKE_GENERATOR_TOOLSET "cuda=9.2,host=x64") 

#set(CMAKE_ASM_COMPILER mt)
#set(CMAKE_C_COMPILER_ID MSVC)
#set(CMAKE_CXX_COMPILER_ID MSVC)

#set(CMAKE_C_COMPILER cl)
#set(CMAKE_CXX_COMPILER cl)

#set(VCPKG_CMAKE_C_COMPILER cl)
#set(VCPKG_CMAKE_CXX_COMPILER cl)

#set(VCPKG_C_COMPILER cl)
#set(VCPKG_CXX_COMPILER cl)

#set(CMAKE_Fortran_COMPILER GNU)
#set(CMAKE_FC_COMPILER gfortran)

#set(CMAKE_CXX_COMPILER_ID Clang)
#set(CMAKE_C_COMPILER_ID Clang)
#set(CMAKE_CXX_COMPILER clang++)
#set(CMAKE_C_COMPILER clang)

#set(CMAKE_FC_COMPILER_ID Flang)
#set(CMAKE_Fortran_COMPILER Flang)

#set(CMAKE_CXX_COMPILER_ID Intel)
#set(CMAKE_C_COMPILER_ID Intel)

#ENABLE_LANGUAGE(Fortran)
#set(CMAKE_Fortran_COMPILER /usr/local/openmpi/bin/mpif90)
SET(CMAKE_Fortran_COMPILER_WORKS 1)
set(VCPKG_FORTRAN_ENABLED ON)
set(FORTRAN_ENABLED ON)
set(INTEL_VERSIONS 19)
set(IFORT_COMPILER 19)
set(VCPKG_FORTRAN_TOOLSET_VERSION 19)
set(VCPKG_FORTRAN_COMPILER "Intel")
set(CMAKE_Fortran_COMPILER "C:/Program Files (x86)/IntelSWTools/compilers_and_libraries/windows/bin/intel64/ifort.exe")
#set(CMAKE_Fortran_COMPILER_ID "Intel")
#set(PGI_VERSIONS "18.10")
#set(VCPKG_FORTRAN_TOOLSET_VERSION 18.10)
set(CMAKE_FC_COMPILER "C:/Program Files (x86)/IntelSWTools/compilers_and_libraries/windows/bin/intel64/ifort.exe")
#set(VCPKG_FORTRAN_COMPILER PGI)
#set(CMAKE_Fortran_COMPILER_ID PGI)
#set(VCPKG_FORTRAN_ENABLED ON)
#set(FORTRAN_ENABLED ON)
##"-DCMAKE_GNUtoMS=ON" 
##"-DCMAKE_GNUtoMS_VCVARS=C:/Program Files (x86)/Microsoft Visual Studio/2017/Professional/VC/Auxiliary/Build/vcvars64.bat"
#set(CMAKE_Fortran_LANGUAGE ON)
#set(CMAKE_Fortran_ENABLED ON)
#set(CMAKE_Fortran_COMPILER_WORKS TRUE)

#SET(MPI_Fortran_COMPILER "mpiifort.bat")
## MPI_Fortran_COMPILER="C:/Program Files (x86)/IntelSWTools/compilers_and_libraries_2019/windows/mpi/intel64/bin/mpiifort.bat"

set(MPI_C_WORKS TRUE)
set(MPI_CXX_WORKS TRUE)
set(MPI_Fortran_WORKS TRUE)


#set(CMAKE_Fortran_FLAGS "/libs:static" ${CMAKE_Fortran_FLAGS})

#set(CMAKE_Fortran_COMPILER "C:/Program Files (x86)/IntelSWTools/compilers_and_libraries/windows/bin/intel64/ifort.exe")
#set(CMAKE_FC_COMPILER "C:/Program Files (x86)/IntelSWTools/compilers_and_libraries/windows/bin/intel64/ifort.exe")

#set(CMAKE_FC_COMPILER "C:/Program Files/PGI/win64/18.10/bin/pgfortran.exe")
#set(CMAKE_Fortran_COMPILER "C:/Program Files/PGI/win64/18.10/bin/pgfortran.exe")
#set(VCPKG_FORTRAN_TOOLSET_VERSION 18.10)



#set(CMAKE_FC_COMPILER_ID Absoft)
#set(CMAKE_FC_COMPILER_ID PGI)
#set(VCPKG_FORTRAN_COMPILER PGI)
#set(CMAKE_Fortran_COMPILER PGI)
#set(CMAKE_FC_COMPILER pgf90)
#set(CMAKE_FC_COMPILER pgf95)

## https://blog.iany.me/2017/03/vcpkg-static-linking/
#set(Boost_USE_STATIC_RUNTIME ON)
#set(Boost_USE_STATIC_LIBS ON)
#set(BOOST_ALL_NO_LIB ON)
#set(BOOST_PROGRAM_OPTIONS_DYN_LINK ON)
#set(BOOST_SYSTEM_USE_UTF8 ON)
#set(BOOST_NO_ANSI_APIS OFF)
#set(BOOST_PLAT_WINDOWS_RUNTIME ON)

#defined(BOOST_NO_ANSI_APIS) && !defined(BOOST_SYSTEM_USE_UTF8)

# set(_CRT_SECURE_NO_WARNINGS )
set(BLA_VENDOR OpenBLAS)
set(BLA_STATIC ON)
set(LAPACKE_STATIC 1)

set(LAPACK_lapack_WORKS TRUE)
set(LAPACK_blas_WORKS TRUE)
set(BLAS_lapack_WORKS TRUE)
set(BLAS_blas_WORKS TRUE)

#set(BLAS_VENDOR MKL)
#set(BLAS_VENDOR Intel10_64lp) # (intel mkl v10+ 64 bit, threaded code, lp64 model)
#set(BLAS_VENDOR Intel) # (obsolete versions of mkl 32 and 64 bit)

#set(F9X ifort)
#set(MPIF90_F90 ifort)
#set(CMAKE_F9X_COMPILER ifort)
#set(CMAKE_F90_COMPILER ifort)
#set(CMAKE_FC_COMPILER ifort)
#set(CMAKE_F77_COMPILER ifort)



#set(NINJA_CAN_BE_USED OFF) # Ninja as generator
#set(NINJA_HOST OFF) # Ninja as parallel configurator
#set(ENABLE_PARALLEL OFF)
#set(NINJA_HOST OFF)

#set(CURL_USE_WINSSL ON)

#CMAKE_C_COMPILER= /sw/bin/gcc-fsf-4.8
#CMAKE_CXX_COMPILER= /sw/bin/g++-fsf-4.8
#CMAKE_Fortran_COMPILER= /sw/bin/gfortran-fsf-4.8

#SET(CMAKE_SYSTEM_NAME Windows)
#SET(CMAKE_C_COMPILER x86_64-w64-mingw32-gcc)
#SET(CMAKE_CXX_COMPILER x86_64-w64-mingw32-g++)
#SET(CMAKE_Fortran_COMPILER x86_64-w64-mingw32-gfortran)
#SET(CMAKE_RC_COMPILER x86_64-w64-mingw32-windres)

#IF ( MPI_FOUND )
#   SET (CMAKE_Fortran_COMPILER  mpif90)
#   SET (CMAKE_CC_COMPILER  mpicc)
#   SET (CMAKE_CXX_COMPILER  mpicxx)
#ENDIF()


#set(CMAKE_CXX_COMPILER_ID "MSVC")
#set(CMAKE_CXX_COMPILER_VERSION "19.16.27026.1")
#set(CMAKE_CXX_PLATFORM_ID "Windows")
#set(CMAKE_CXX_COMPILER_ARCHITECTURE_ID x64)
#set(MSVC_CXX_ARCHITECTURE_ID x64)
#set(CMAKE_COMPILER_IS_GNUCXX )
#set(CMAKE_CXX_COMPILER_LOADED 1)
#set(CMAKE_CXX_COMPILER_WORKS TRUE)
#set(CMAKE_CXX_ABI_COMPILED TRUE)


#//ADVANCED property for variable: CMAKE_EXPORT_COMPILE_COMMANDS
#CMAKE_EXPORT_COMPILE_COMMANDS-ADVANCED:INTERNAL=1

#//Name of external makefile project generator.
#CMAKE_EXTRA_GENERATOR:INTERNAL=

#//Name of generator.
#CMAKE_GENERATOR:INTERNAL=Ninja

#//Generator instance identifier.
#CMAKE_GENERATOR_INSTANCE:INTERNAL=

#//Name of generator platform. x64 or x86 or Win32
#CMAKE_GENERATOR_PLATFORM:INTERNAL=

##//Name of generator toolset. 
#Visual Studio: 12 (v120_xp), 14 (v140_xp), 15 (v140_xp)
#"Intel C++ Compiler 19.0"
#CMAKE_GENERATOR_TOOLSET:INTERNAL=
## scripts/toolchains/windows.cmake
#set(CMAKE_GENERATOR_TOOLSET "Intel C++ Compiler 19.0" CACHE STRING "Platform Toolset" FORCE)







