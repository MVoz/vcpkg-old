include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://oligarchy.co.uk/xapian/1.4.11/xapian-core-1.4.11.tar.xz"
    FILENAME "xapian-core-1.4.11.tar.xz"
    SHA512 72ab7b0c774390f38319d241689b2dc3c2837fbbf933616574f6ad167f14a25c2eff747910022065508dc7c44f806dc2b71dae80a1b4f1f47e1675fb951bc785
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

file(COPY ${CMAKE_CURRENT_LIST_DIR}/compile ${CMAKE_CURRENT_LIST_DIR}/ar-lib DESTINATION ${SOURCE_PATH})

vcpkg_find_acquire_program(TEXLIVE)
vcpkg_find_acquire_program(XGETTEXT)
#vcpkg_find_acquire_program(PYTHON3)
#vcpkg_find_acquire_program(DOXYGEN)

#питон не находит зависимости, пришлось добавить все
get_filename_component(TEXLIVE_DIR "${TEXLIVE}" DIRECTORY)
get_filename_component(XGETTEXT_DIR "${XGETTEXT}" DIRECTORY)
#get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
#get_filename_component(DOXYGEN_DIR "${DOXYGEN}" DIRECTORY)

#vcpkg_add_to_path("${PYTHON3_DIR};${FLEX_DIR};${BISON_DIR};${DOXYGEN_DIR}")
set(ENV{PATH} ";$ENV{PATH};${XGETTEXT_DIR};${TEXLIVE_DIR}")
#set(ENV{PYTHON_INSTALL_DIR} "${PYTHON3_DIR}")



#set(CONFIGURE_OPTIONS "${CONFIGURE_OPTIONS} --host=i686-pc-mingw32")

# Acquire tools
vcpkg_acquire_msys(MSYS_ROOT PACKAGES make automake1.16)

# Insert msys into the path between the compiler toolset and windows system32. This prevents masking of "link.exe" but DOES mask "find.exe".
string(REPLACE ";$ENV{SystemRoot}\\system32;" ";${MSYS_ROOT}/usr/bin;${MSYS_ROOT}/mingw64/bin;$ENV{SystemRoot}\\system32;" NEWPATH "$ENV{PATH}")
string(REPLACE ";$ENV{SystemRoot}\\System32;" ";${MSYS_ROOT}/usr/bin;${MSYS_ROOT}/mingw64/bin;$ENV{SystemRoot}\\System32;" NEWPATH "${NEWPATH}")
#set(ENV{PATH} ";$ENV{PATH};${MSYS_ROOT}/usr/bin;${MSYS_ROOT}/mingw64/bin")
set(ENV{PATH} ";${NEWPATH}")
set(BASH ${MSYS_ROOT}/usr/bin/bash.exe)



#set(_csc_PROJECT_PATH nmap)

#file(REMOVE_RECURSE ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel)

#	set(AUTOMAKE_DIR ${MSYS_ROOT}/usr/share/automake-1.15)
#	file(COPY ${AUTOMAKE_DIR}/config.guess ${AUTOMAKE_DIR}/config.sub DESTINATION ${SOURCE_PATH}/source)

#	if(VCPKG_CRT_LINKAGE STREQUAL static)
#		set(ICU_RUNTIME "-MT")
#	else()
#		set(ICU_RUNTIME "-MD")
#	endif()

#if(VCPKG_CMAKE_SYSTEM_NAME STREQUAL "WindowsStore")
#    set(ENV{LIBPATH} "$ENV{LIBPATH};$ENV{_WKITS10}references\\windows.foundation.foundationcontract\\2.0.0.0\\;$ENV{_WKITS10}references\\windows.foundation.universalapicontract\\3.0.0.0\\")
#    set(OPTIONS "${OPTIONS} --disable-programs --enable-cross-compile --target-os=win32 --arch=${VCPKG_TARGET_ARCHITECTURE}")
#    set(OPTIONS "${OPTIONS} --extra-cflags=-DWINAPI_FAMILY=WINAPI_FAMILY_APP --extra-cflags=-D_WIN32_WINNT=0x0A00")
#


#file(MAKE_DIRECTORY ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel)
#vcpkg_execute_required_process(
#    COMMAND ${BASH} --noprofile --norc "${CMAKE_CURRENT_LIST_DIR}\\build.sh"
#        "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel" # BUILD DIR
#        "${SOURCE_PATH}" # SOURCE DIR
#        "${CURRENT_PACKAGES_DIR}" # PACKAGE DIR
#        "${OPTIONS} ${OPTIONS_RELEASE}"
#    WORKING_DIRECTORY ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel
#    LOGNAME build-${TARGET_TRIPLET}-rel
#)

#message(STATUS "Building ${_csc_PROJECT_PATH} for Debug")
#file(MAKE_DIRECTORY ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg)
#vcpkg_execute_required_process(
#    COMMAND ${BASH} --noprofile --norc "${CMAKE_CURRENT_LIST_DIR}\\build.sh"
#        "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg" # BUILD DIR
#        "${SOURCE_PATH}" # SOURCE DIR
#        "${CURRENT_PACKAGES_DIR}/debug" # PACKAGE DIR
#        "${OPTIONS} ${OPTIONS_DEBUG}"
#    WORKING_DIRECTORY ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg
#    LOGNAME build-${TARGET_TRIPLET}-dbg
#)
#    COMMAND ${BASH} --noprofile --norc ../configure STRIP=":" RANLIB=":" CC="../compile cl" CXX="../compile cl" AR="lib" CFLAGS="-MD -EHsc" CXXFLAGS=" -MD -EHsc " CPPFLAGS=" -D_WIN32_WINNT=_WIN32_WINNT_WIN8 -I${CURRENT_INSTALLED_DIR}/include " LDFLAGS=" -L${CURRENT_INSTALLED_DIR}/lib " LD="link" NM="dumpbin -symbols" --disable-documentation
#		CC="${SOURCE_PATH}/../compile cl -nologo"
#		CXX="${SOURCE_PATH}/../compile cl -nologo"
#		AR="${SOURCE_PATH}/../ar-lib lib"
#		CC="${SOURCE_PATH}/xapian-core/compile cl -nologo"
#		CXX="${SOURCE_PATH}/xapian-core/compile cl -nologo"
#		AR="${SOURCE_PATH}/xapian-core/ar-lib lib"
		
#file(REMOVE_RECURSE ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel)
#file(REMOVE_RECURSE ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg)

#file(MAKE_DIRECTORY ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg)
set(ENV{CFLAGS} "-MD -EHsc -I${CURRENT_INSTALLED_DIR}/include -L${CURRENT_INSTALLED_DIR}/lib")
set(ENV{CXXFLAGS} "-MD -EHsc -I${CURRENT_INSTALLED_DIR}/include -L${CURRENT_INSTALLED_DIR}/lib")
set(ENV{CONFIGURE_OPTIONS} "-L${CURRENT_INSTALLED_DIR}/lib")
set(ENV{LDFLAGS} "-D_WIN32_WINNT=_WIN32_WINNT_WIN8 -I${CURRENT_INSTALLED_DIR}/include -LIBPATH${CURRENT_INSTALLED_DIR}/lib")
set(ENV{CONFIGURE_OPTIONS_RELEASE} "--prefix=${CURRENT_PACKAGES_DIR} --arch=${VCPKG_TARGET_ARCHITECTURE}")
set(ENV{CPPFLAGS} "-D_WIN32_WINNT=_WIN32_WINNT_WIN8 -I${CURRENT_INSTALLED_DIR}/include -L${CURRENT_INSTALLED_DIR}/lib")
#set(ENV{LD} "link")
#set(ENV{AR} "lib")
set(ENV{NM} "dumpbin -symbols")
#set(ENV{STRIP ":")
#set(ENV{RANLIB ":")
#set(ENV{CC "cl -nologo")
#set(ENV{CXX "cl -nologo")
#"CC=cl 
set(ENV{INCLUDE} "${CURRENT_INSTALLED_DIR}/include;$ENV{INCLUDE}")
set(ENV{LIB} "${CURRENT_INSTALLED_DIR}/lib;$ENV{LIB}")
message(STATUS "Generating makefile ${TARGET_TRIPLET}-dbg")
#set(CFLAGS "${VCPKG_C_FLAGS} ${VCPKG_C_FLAGS_DEBUG} -fPIC -O0 -g -I${SOURCE_PATH}/include")
#set(LDFLAGS "${VCPKG_LINKER_FLAGS}")
vcpkg_execute_required_process(
#	SOURCE_PATH ${SOURCE_PATH}
    COMMAND ${BASH} --noprofile --norc
		${SOURCE_PATH}/configure CC=cl CXX=cl AR=lib LD=link STRIP=: RANLIB=: --disable-documentation ${CONFIGURE_OPTIONS} ${CONFIGURE_OPTIONS_RELEASE}
    WORKING_DIRECTORY ${SOURCE_PATH}
    LOGNAME configure-${TARGET_TRIPLET}-dbg
)

message(STATUS "Building makefile ${TARGET_TRIPLET}-dbg")
vcpkg_execute_required_process(
#    COMMAND make -j install "CFLAGS=${CFLAGS}" "LDFLAGS=${LDFLAGS}"
	COMMAND ${BASH} --noprofile --norc
		make -j install
    WORKING_DIRECTORY ${SOURCE_PATH}
    LOGNAME install-${TARGET_TRIPLET}-dbg
)


# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/xapian RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME xapian)
