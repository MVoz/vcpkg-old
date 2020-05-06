include(vcpkg_common_functions)

if(VCPKG_LIBRARY_LINKAGE STREQUAL dynamic AND VCPKG_CRT_LINKAGE STREQUAL static)
    message(STATUS "Warning: Dynamic library with static CRT is not supported. Building static library.")
    set(VCPKG_LIBRARY_LINKAGE static)
endif()

set(PYTHON_VERSION_MAJOR  3)
set(PYTHON_VERSION_MINOR  7)
set(PYTHON_VERSION_PATCH  3)
set(PYTHON_VERSION        ${PYTHON_VERSION_MAJOR}.${PYTHON_VERSION_MINOR}.${PYTHON_VERSION_PATCH})

vcpkg_from_github(
    OUT_SOURCE_PATH TEMP_SOURCE_PATH
    REPO python/cpython
    REF v${PYTHON_VERSION}
    SHA512 023960a2f570fe7178d3901df0c3c33346466906b6d55c73ef7947c19619dbab62efc42c7262a0539bc5e31543b1113eb7a088d4615ad7557a0707bdaca27940
    HEAD_REF master
    PATCHES
        win-openssl-cpython.patch
		add-include.patch
)

find_program(GIT NAMES git git.cmd)
find_program(NMAKE NAMES nmake)

# Currently it's not trivial to use external libraries building python on windows
# Use in-source building temporarily
if("_ssl" IN_LIST FEATURES)
    if(NOT EXISTS ${TEMP_SOURCE_PATH}/externals/openssl-1.1.0j)
        vcpkg_from_github(
            OUT_SOURCE_PATH OPENSSL_SOURCE_PATH
            REPO python/cpython-source-deps
            REF openssl-1.1.0j
            SHA512 60cb0e8ae417622237cce29215ef0889f4f02aea476a603ffe27d68ff87d0b5721fbd27d2fcf073553a400793d282c118ef7f349752f1ec3692b6f13b2ae61c4 
            HEAD_REF openssl
        )
        file(COPY ${OPENSSL_SOURCE_PATH} DESTINATION ${TEMP_SOURCE_PATH}/externals)
        file(RENAME ${TEMP_SOURCE_PATH}/externals/ssl-1.1.0j-5dc4d25b00 ${TEMP_SOURCE_PATH}/externals/openssl-1.1.0j)
		file(MAKE_DIRECTORY ${TEMP_SOURCE_PATH}/externals/openssl-1.1.0j/build)
    endif()
    vcpkg_find_acquire_program(NASM)
	vcpkg_find_acquire_program(PERL)
    get_filename_component(NASM_EXE_PATH ${NASM} DIRECTORY)
	get_filename_component(PERL_EXE_PATH ${PERL} DIRECTORY)
    set(ENV{PATH} ";$ENV{PATH};${NASM_EXE_PATH};${PERL_EXE_PATH}")
	
##	MSVC masm ml64.exe static
#	${PERL} ../Configure VC-WIN64A-masm no-shared enable-capieng --prefix=/../../openssl-bin-1.1.0j --openssldir=/../../openssl-bin-1.1.0j

##	MSVC masm ml.exe shared enable deps DLL for PYTHON and applink
#	${PERL} ../Configure VC-WIN64A-masm enable-capieng --prefix=/../../openssl-bin-1.1.0j --openssldir=/../../openssl-bin-1.1.0j

##	NASM static
#	perl ../Configure VC-WIN64A no-shared enable-capieng --prefix=/../../openssl-bin-1.1.0j --openssldir=/../../openssl-bin-1.1.0j
	
## install_sw no EXE & INSTALL \externals\openssl-bin-1.1.0j\ ..\lib ..\include\openssl
#	${NMAKE} install_sw DESTDIR=../../${ARCH_NAME}
	
	if(VCPKG_TARGET_ARCHITECTURE STREQUAL "x86")
		set(OPENSSL_ARCH VC-WIN32)
		set(ARCH_NAME x86)
	elseif(VCPKG_TARGET_ARCHITECTURE STREQUAL "x64")
		set(OPENSSL_ARCH VC-WIN64A-masm)
		set(ARCH_NAME amd64)
	else()
		message(FATAL_ERROR "Unsupported target architecture: ${VCPKG_TARGET_ARCHITECTURE}")
	endif()

	vcpkg_execute_required_process(
		SOURCE_PATH ${TEMP_SOURCE_PATH}/externals/openssl-1.1.0j
		COMMAND
			${PERL} ../Configure ${OPENSSL_ARCH} enable-capieng --prefix=/../../openssl-bin-1.1.0j/${ARCH_NAME} --openssldir=/../../openssl-bin-1.1.0j/${ARCH_NAME}
		WORKING_DIRECTORY ${TEMP_SOURCE_PATH}/externals/openssl-1.1.0j/build
		LOGNAME openssl-${TARGET_TRIPLET}
	)
	vcpkg_execute_required_process(
		SOURCE_PATH ${TEMP_SOURCE_PATH}/externals/openssl-1.1.0j
		COMMAND
			${NMAKE} install_sw DESTDIR=../..
		WORKING_DIRECTORY ${TEMP_SOURCE_PATH}/externals/openssl-1.1.0j/build
		LOGNAME install_openssl-${TARGET_TRIPLET}
	)
endif()

# Currently it's not trivial to use external libraries building python on windows
# Use in-source building temporarily
if("_sqlite3" IN_LIST FEATURES)
    if(NOT EXISTS ${TEMP_SOURCE_PATH}/externals/sqlite-3.21.0.0)
        vcpkg_from_github(
            OUT_SOURCE_PATH SQLITE_SOURCE_PATH
            REPO python/cpython-source-deps
            REF sqlite-3.21.0.0
            SHA512 39272b9c94c60e4867bc2e247f699debc52b6f32114f1e717d6dfec2047befff725ad85f2a69db53e8f5b17da3658662698cbc7891a50a058a5522bb81cf0380 
            HEAD_REF sqlite
        )
        file(COPY ${SQLITE_SOURCE_PATH} DESTINATION ${TEMP_SOURCE_PATH}/externals)
        file(RENAME ${TEMP_SOURCE_PATH}/externals/e-3.21.0.0-fdec1f747d ${TEMP_SOURCE_PATH}/externals/sqlite-3.21.0.0)
    endif()
endif ()

# Currently it's not trivial to use external libraries building python on windows
# Use in-source building temporarily
if("_bz2" IN_LIST FEATURES)
    if(NOT EXISTS ${TEMP_SOURCE_PATH}/externals/bzip2-1.0.6)
        vcpkg_from_github(
            OUT_SOURCE_PATH BZIP2_SOURCE_PATH
            REPO python/cpython-source-deps
            REF bzip2-1.0.6
            SHA512 16edd262321900c85ae4396a3e718bbe81409e7e85978870c20d7a71c6ef4fb61e063141501caf2f52ff7a0f2312f79198a37addf39ca9bfa373b5ed8407780a 
            HEAD_REF bzip2
        )
        file(COPY ${BZIP2_SOURCE_PATH} DESTINATION ${TEMP_SOURCE_PATH}/externals)
        file(RENAME ${TEMP_SOURCE_PATH}/externals/zip2-1.0.6-e6e7c978fa ${TEMP_SOURCE_PATH}/externals/bzip2-1.0.6)
    endif()
endif ()

# Currently it's not trivial to use external libraries building python on windows
# Use in-source building temporarily
if("_lzma" IN_LIST FEATURES)
    if(NOT EXISTS ${TEMP_SOURCE_PATH}/externals/xz-5.2.2)
        vcpkg_from_github(
            OUT_SOURCE_PATH XZ_SOURCE_PATH
            REPO python/cpython-source-deps
            REF xz-5.2.2
            SHA512 9547ee6b8c0320bde4b8b61eb4b84f1972280a9efde9f076b11d354d579e8097be3275ad25987d16d489c631864069d48543c7e5273e5c9e600474154b88b957 
            HEAD_REF xz
        )
        file(COPY ${XZ_SOURCE_PATH} DESTINATION ${TEMP_SOURCE_PATH}/externals)
        file(RENAME ${TEMP_SOURCE_PATH}/externals/xz-5.2.2-78cbd900d4 ${TEMP_SOURCE_PATH}/externals/xz-5.2.2)
    endif()
endif ()

# Currently it's not trivial to use external libraries building python on windows
# Use in-source building temporarily
if("executable" IN_LIST FEATURES)
    if(NOT EXISTS ${TEMP_SOURCE_PATH}/externals/zlib-1.2.11)
        vcpkg_from_github(
            OUT_SOURCE_PATH ZLIB_SOURCE_PATH
            REPO python/cpython-source-deps
            REF zlib-1.2.11
            SHA512 e1d0182e267cbbd4f899af470a61890623d07a62cec4938fa935a15f3bb0da1f9852a9c39a515b81779a29ad3c3ce87a8b1e9d9a67cadf94262f23c45a418bfa 
            HEAD_REF zlib
        )
        file(COPY ${ZLIB_SOURCE_PATH} DESTINATION ${TEMP_SOURCE_PATH}/externals)
        file(RENAME ${TEMP_SOURCE_PATH}/externals/lib-1.2.11-804985905d ${TEMP_SOURCE_PATH}/externals/zlib-1.2.11)
    endif()
endif ()

# We need per-triplet directories because we need to patch the project files differently based on the linkage
# Because the patches patch the same file, they have to be applied in the correct order
set(SOURCE_PATH "${TEMP_SOURCE_PATH}-Lib-${VCPKG_LIBRARY_LINKAGE}-crt-${VCPKG_CRT_LINKAGE}")
file(REMOVE_RECURSE ${SOURCE_PATH})
file(RENAME "${TEMP_SOURCE_PATH}" ${SOURCE_PATH})

# надо объединить два\три патча для статик, в планах не забыть
if (VCPKG_LIBRARY_LINKAGE STREQUAL static)
    vcpkg_apply_patches(
        SOURCE_PATH ${SOURCE_PATH}
        PATCHES
            static-link.patch
    )
endif()
if (VCPKG_CRT_LINKAGE STREQUAL static)
    vcpkg_apply_patches(
        SOURCE_PATH ${SOURCE_PATH}
        PATCHES
			static-crt-add-lib.patch
			header-for-static-linkage.patch
    )
endif()

if (VCPKG_TARGET_ARCHITECTURE MATCHES "x86")
    set(BUILD_ARCH "Win32")
    set(OUT_DIR "win32")
elseif (VCPKG_TARGET_ARCHITECTURE MATCHES "x64")
    set(BUILD_ARCH "x64")
    set(OUT_DIR "amd64")
else()
    message(FATAL_ERROR "Unsupported architecture: ${VCPKG_TARGET_ARCHITECTURE}")
endif()

vcpkg_build_msbuild(
    PROJECT_PATH ${SOURCE_PATH}/PCBuild/pythoncore.vcxproj
    PLATFORM ${BUILD_ARCH}
)

if("executable" IN_LIST FEATURES)
    vcpkg_build_msbuild(
        PROJECT_PATH ${SOURCE_PATH}/PCBuild/pythonw.vcxproj
        PLATFORM ${BUILD_ARCH})
    vcpkg_build_msbuild(
        PROJECT_PATH ${SOURCE_PATH}/PCBuild/python.vcxproj
        PLATFORM ${BUILD_ARCH})
endif()

set(BUILD_MODULE OFF)
macro(add_python_module MNAME)
    if("${MNAME}" IN_LIST FEATURES)
    # AND NOT EXISTS ${SOURCE_PATH}/PCBuild/${OUT_DIR}/${MNAME}.pyd)
        set(BUILD_MODULE ON)
        vcpkg_build_msbuild(
            PROJECT_PATH ${SOURCE_PATH}/PCBuild/${MNAME}.vcxproj
            PLATFORM ${BUILD_ARCH}
            )
    endif()
endmacro()

## ExternalModules 
# _bz2;_lzma;_sqlite3;_ssl;_hashlib;_tkinter

## ExtensionModules
# _asyncio;_ctypes;_decimal;_elementtree;_msi;_multiprocessing;_overlapped;pyexpat;_queue;select;unicodedata;winsound;_socket;_ssl;_hashlib;_tkinter
add_python_module(_bz2)
add_python_module(_lzma)
add_python_module(_sqlite3)
add_python_module(_ssl)
add_python_module(_socket)
add_python_module(_hashlib)
add_python_module(_queue)
add_python_module(_overlapped)
add_python_module(_multiprocessing)
add_python_module(_ctypes)
add_python_module(_asyncio)
add_python_module(_decimal)
add_python_module(_elementtree)
add_python_module(pyexpat)
add_python_module(select)
add_python_module(unicodedata)
add_python_module(winsound)
add_python_module(xxlimited)


file(GLOB HEADERS ${SOURCE_PATH}/Include/*.h)
file(COPY ${HEADERS} ${SOURCE_PATH}/PC/pyconfig.h DESTINATION ${CURRENT_PACKAGES_DIR}/include/python${PYTHON_VERSION_MAJOR}.${PYTHON_VERSION_MINOR})

file(GLOB LIBS ${SOURCE_PATH}/PCBuild/${OUT_DIR}/*.lib)
file(GLOB DEBUG_LIBS ${SOURCE_PATH}/PCBuild/${OUT_DIR}/*_d.lib)
list(REMOVE_ITEM LIBS ${DEBUG_LIBS})
file(COPY ${LIBS} DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
file(COPY ${DEBUG_LIBS} DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)

# only python3 is supported in vcpkg right now, so the directory doesn't split python2 and python3
# setup python directories
file(COPY ${SOURCE_PATH}/Lib DESTINATION ${CURRENT_PACKAGES_DIR}/python3) # use original libs without __pycache__
file(COPY ${SOURCE_PATH}/Lib DESTINATION ${CURRENT_PACKAGES_DIR}/debug/python3)
file(COPY ${HEADERS} ${SOURCE_PATH}/PC/pyconfig.h DESTINATION ${CURRENT_PACKAGES_DIR}/python3/include)
file(COPY ${LIBS} DESTINATION ${CURRENT_PACKAGES_DIR}/python3/libs)
file(COPY ${DEBUG_LIBS} DESTINATION ${CURRENT_PACKAGES_DIR}/debug/python3/libs)

if (VCPKG_LIBRARY_LINKAGE STREQUAL dynamic)
    file(COPY ${SOURCE_PATH}/PCBuild/${OUT_DIR}/python${PYTHON_VERSION_MAJOR}${PYTHON_VERSION_MINOR}.dll DESTINATION ${CURRENT_PACKAGES_DIR}/bin)
    file(COPY ${SOURCE_PATH}/PCBuild/${OUT_DIR}/python${PYTHON_VERSION_MAJOR}${PYTHON_VERSION_MINOR}_d.dll DESTINATION ${CURRENT_PACKAGES_DIR}/debug/bin)
endif()

if("executable" IN_LIST FEATURES)
    file(COPY ${SOURCE_PATH}/PCBuild/${OUT_DIR}/python.exe DESTINATION ${CURRENT_PACKAGES_DIR}/python3)
    file(COPY ${SOURCE_PATH}/PCBuild/${OUT_DIR}/pythonw.exe DESTINATION ${CURRENT_PACKAGES_DIR}/python3)
    file(COPY ${SOURCE_PATH}/PCBuild/${OUT_DIR}/python_d.exe DESTINATION ${CURRENT_PACKAGES_DIR}/debug/python3)
    file(COPY ${SOURCE_PATH}/PCBuild/${OUT_DIR}/pythonw_d.exe DESTINATION ${CURRENT_PACKAGES_DIR}/debug/python3)
	if (VCPKG_LIBRARY_LINKAGE STREQUAL dynamic)
		file(COPY ${SOURCE_PATH}/PCBuild/${OUT_DIR}/python${PYTHON_VERSION_MAJOR}${PYTHON_VERSION_MINOR}.dll
			DESTINATION ${CURRENT_PACKAGES_DIR}/python3)
		file(COPY ${SOURCE_PATH}/PCBuild/${OUT_DIR}/python${PYTHON_VERSION_MAJOR}${PYTHON_VERSION_MINOR}_d.dll
			DESTINATION ${CURRENT_PACKAGES_DIR}/debug/python3)
	endif()
endif()

if (BUILD_MODULE)
    file(GLOB PYDS ${SOURCE_PATH}/PCBuild/${OUT_DIR}/*.pyd)
    file(GLOB DEBUG_PYDS ${SOURCE_PATH}/PCBuild/${OUT_DIR}/*_d.pyd)
    list(REMOVE_ITEM PYDS ${DEBUG_PYDS})
    file(COPY ${PYDS} DESTINATION ${CURRENT_PACKAGES_DIR}/python3/DLLs)
    file(COPY ${DEBUG_PYDS} DESTINATION ${CURRENT_PACKAGES_DIR}/debug/python3/DLLs)
endif()

# Handle copyright
file(COPY ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/python${PYTHON_VERSION_MAJOR})
file(RENAME ${CURRENT_PACKAGES_DIR}/share/python${PYTHON_VERSION_MAJOR}/LICENSE ${CURRENT_PACKAGES_DIR}/share/python${PYTHON_VERSION_MAJOR}/copyright)

# INSTALL *.PC Files
file(INSTALL ${CMAKE_CURRENT_LIST_DIR}/debug/pkgconfig DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)
file(INSTALL ${CMAKE_CURRENT_LIST_DIR}/pkgconfig DESTINATION ${CURRENT_PACKAGES_DIR}/lib)

vcpkg_copy_pdbs()
