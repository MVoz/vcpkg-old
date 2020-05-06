include(vcpkg_common_functions)

#static
#https://github.com/qtwebkit/qtwebkit/wiki/Building-static-libraries

find_program(GIT git)
set(GIT_URL "https://github.com/qt/qtwebkit.git")
set(GIT_REF "0b48569e2bf9afc1b6ca5e359c3a948dd8c77619")

set(USE_PROXY FALSE)

if (${USE_PROXY})
    set(PROXY_HOST "127.0.0.1")
    set(PROXY_PORT "1080")
    set(ENV{http_proxy} "http://${PROXY_HOST}:${PROXY_PORT}")
    set(ENV{https_proxy} "http://${PROXY_HOST}:${PROXY_PORT}")
endif()

if(NOT EXISTS "${DOWNLOADS}/qtwebkit.git")
    message(STATUS "Cloning")
    vcpkg_execute_required_process(
        COMMAND ${GIT} clone --bare ${GIT_URL} ${DOWNLOADS}/qtwebkit.git
        WORKING_DIRECTORY ${DOWNLOADS}
        LOGNAME clone
    )
endif()
message(STATUS "Cloning done")

if(NOT EXISTS "${CURRENT_BUILDTREES_DIR}/src/.git")
    message(STATUS "Adding worktree and patching")
    file(MAKE_DIRECTORY ${CURRENT_BUILDTREES_DIR})
    vcpkg_execute_required_process(
        COMMAND ${GIT} worktree add -f --detach ${CURRENT_BUILDTREES_DIR}/src ${GIT_REF}
        WORKING_DIRECTORY ${DOWNLOADS}/qtwebkit.git
        LOGNAME worktree
    )
    message(STATUS "Patching")
endif()
message(STATUS "Adding worktree done")
set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/)

message(STATUS "Updating Submodule")
vcpkg_execute_required_process(
    COMMAND ${GIT} submodule update --init --recursive
    WORKING_DIRECTORY ${SOURCE_PATH}
    LOGNAME update-submodule
)

set(SQLITE_VERSION 3210000)
set(SQLITE_HASH 0a272b00825d07528c3842ccd483d81e5e719ab56737eec0972f7f8191dfbe92e35777ab8d1b37c95fde9320bbfa3c365a4b30253af876340f55517ea96bf665)
set(SQLITE3SRCDIR ${CURRENT_BUILDTREES_DIR}/src/sqlite-amalgamation-${SQLITE_VERSION})

vcpkg_download_distfile(ARCHIVE
    URLS "https://sqlite.org/2017/sqlite-amalgamation-${SQLITE_VERSION}.zip"
    FILENAME "sqlite-amalgamation-${SQLITE_VERSION}.zip"
    SHA512 ${SQLITE_HASH})
vcpkg_extract_source_archive(${ARCHIVE})

set(ENV{SQLITE3SRCDIR} ${SQLITE3SRCDIR})

# vcpkg_apply_patches(
#     SOURCE_PATH ${SOURCE_PATH}
#     PATCHES
#     ${CURRENT_PORT_DIR}/qt5-webkit-icu59.patch
# )

# Acquire tools
set(ENV{PATH} "${VCPKG_ROOT_DIR}/installed/${TARGET_TRIPLET}/bin;${VCPKG_ROOT_DIR}/installed/${TARGET_TRIPLET}/tools/qt5;$ENV{PATH}")

file(STRINGS ${VCPKG_ROOT_DIR}/installed/${TARGET_TRIPLET}/include/QtCore/qtcoreversion.h QT_VERSION
REGEX "^#define QTCORE_VERSION_STR[\t ]+\".+\"$")
string(REGEX REPLACE "^#define QTCORE_VERSION_STR[\t ]+\"(.+)\"$" "\\1" QT_VERSION "${QT_VERSION}")
message(STATUS "QT_VERSION=${QT_VERSION}")

set(QMAKE_CONF ${CURRENT_BUILDTREES_DIR}/src/.qmake.conf)
file(READ ${QMAKE_CONF} _contents)
string(REGEX REPLACE "(MODULE_VERSION = )[0-9]+\\.[0-9]+\\.[0-9]+" "\\1${QT_VERSION}" _contents "${_contents}")
file(WRITE ${QMAKE_CONF} "${_contents}")

vcpkg_find_acquire_program(PYTHON2)
vcpkg_find_acquire_program(PERL)
vcpkg_find_acquire_program(BISON)
vcpkg_find_acquire_program(FLEX)
vcpkg_find_acquire_program(RUBY)
vcpkg_find_acquire_program(GPERF)
#vcpkg_find_acquire_program(GREP)
#vcpkg_find_acquire_program(ICONV)

get_filename_component(PYTHON2_DIR ${PYTHON2} DIRECTORY)
get_filename_component(PERL_DIR ${PERL} DIRECTORY)
get_filename_component(PERL_C_DIR ${PERL_DIR} DIRECTORY)
get_filename_component(PERL_C_DIR ${PERL_C_DIR} DIRECTORY)
set(PERL_C_DIR ${PERL_C_DIR}/c/bin)
get_filename_component(BISON_DIR ${BISON} DIRECTORY)
get_filename_component(FLEX_DIR ${FLEX} DIRECTORY)
get_filename_component(RUBY_DIR ${RUBY} DIRECTORY)
get_filename_component(GPERF_DIR ${GPERF} DIRECTORY)
#get_filename_component(GREP_DIR ${GREP} DIRECTORY)
#get_filename_component(ICONV_DIR ${ICONV} DIRECTORY)
get_filename_component(CMAKE_DIR ${CMAKE_COMMAND} DIRECTORY)

if (NOT EXISTS ${BISON_DIR}/bison.exe)
    execute_process(
        COMMAND ${CMAKE_COMMAND} -E copy ${BISON} ${BISON_DIR}/bison.exe
    )
endif()

if (NOT EXISTS ${FLEX_DIR}/flex.exe)
    execute_process(
        COMMAND ${CMAKE_COMMAND} -E copy ${FLEX} ${FLEX_DIR}/flex.exe
    )
endif()

set(ENV{PATH} "${CMAKE_DIR};${PYTHON2_DIR};${PERL_DIR};${PERL_C_DIR};${BISON_DIR};${FLEX_DIR};${RUBY_DIR};${GPERF_DIR};$ENV{PATH}")
#;${GREP_DIR};${ICONV_DIR}

# message(STATUS "Clean")
# vcpkg_execute_required_process(
#     COMMAND ${PERL} Tools/Scripts/build-webkit --qt --clean
#     WORKING_DIRECTORY ${SOURCE_PATH}
#     LOGNAME perl-clean
# )

set(BUILD_OPTIONS --qt
                  "DEFINES+=U_SIZEOF_WCHAR_T=2"
                  "DEFINES+=UCHAR_TYPE=wchar_t"
                  "CONFIG+=system-jpeg"
                  "CONFIG+=system-png"
                  "WEBKIT_CONFIG+=use_libxml2"
                  "WEBKIT_CONFIG+=xslt"
                  "WEBKIT_CONFIG+=use_zlib"
                  "WEBKIT_CONFIG+=use_webp"
                  "LIBS+=-lshell32"
                  "QMAKE_CXXFLAGS+=/utf-8"
                  "QMAKE_CFLAGS+=/utf-8"
	)

if (VCPKG_TARGET_ARCHITECTURE STREQUAL "x86")
    set(CMAKE_ARGS ${CMAKE_ARGS} -DCMAKE_GENERATOR_PLATFORM=Win32)
    set(BUILD_OPTIONS ${BUILD_OPTIONS} --32-bit)
elseif(VCPKG_TARGET_ARCHITECTURE STREQUAL "x64")
    set(CMAKE_ARGS ${CMAKE_ARGS} -DCMAKE_GENERATOR_PLATFORM=x64)
    set(BUILD_OPTIONS ${BUILD_OPTIONS})
else()
    set(CMAKE_ARGS ${CMAKE_ARGS} -DCMAKE_GENERATOR_PLATFORM=ARM)
endif()

set(VCPKG_INSTALLED_DIR ${VCPKG_ROOT_DIR}/installed/${TARGET_TRIPLET})

set(BUILD_OPTIONS_RELEASE --release
                          --install-headers=${CURRENT_PACKAGES_DIR}
                          --install-libs=${CURRENT_PACKAGES_DIR}
                          ${BUILD_OPTIONS}
	)

set(BUILD_OPTIONS_DEBUG --debug
                        --install-headers=${CURRENT_PACKAGES_DIR}/debug
                        --install-libs=${CURRENT_PACKAGES_DIR}/debug
                        ${BUILD_OPTIONS}
	)

set(WEB_CORE_PRI ${SOURCE_PATH}/Source/WebCore/WebCore.pri)
if (NOT EXISTS ${WEB_CORE_PRI}.bak)
    execute_process(COMMAND ${CMAKE_COMMAND} -E copy ${WEB_CORE_PRI} ${WEB_CORE_PRI}.bak)
endif()

file(READ ${WEB_CORE_PRI}.bak _contents)
string(REPLACE "LIBS += libjpeg.lib" "LIBS += jpeg.lib" _contents "${_contents}")
string(REPLACE "LIBS += libpng.lib" "LIBS += libpng16.lib" _contents "${_contents}")
string(REPLACE "LIBS += -lwebp" "LIBS += webp.lib" _contents "${_contents}")
string(REPLACE "LIBS += zdll.lib" "LIBS += zlib.lib" _contents "${_contents}")
string(REPLACE "PKGCONFIG += libxslt libxml-2.0" "LIBS += libxslt.lib libxml2.lib" _contents "${_contents}")
file(WRITE ${WEB_CORE_PRI} "${_contents}")

message(STATUS "Build Release")
set(ENV{LIB} "${VCPKG_INSTALLED_DIR}/lib;${VCPKG_INSTALLED_DIR}/lib/manual-link;$ENV{LIB}")
vcpkg_execute_required_process(
    COMMAND ${PERL} Tools/Scripts/build-webkit  ${BUILD_OPTIONS_RELEASE}
    WORKING_DIRECTORY ${SOURCE_PATH}
    LOGNAME build-release
)

set(TARGET_PATH ${VCPKG_ROOT_DIR}/packages/qt5-base_${TARGET_TRIPLET})
string(REPLACE "/" "\\" TARGET_PATH "${TARGET_PATH}")
string(REPLACE ":\\" ":$(INSTALL_ROOT)\\" TARGET_PATH "${TARGET_PATH}")
set(NEW_TARGET_PATH ${CURRENT_PACKAGES_DIR})
string(REPLACE "/" "\\" NEW_TARGET_PATH "${NEW_TARGET_PATH}")
file(GLOB_RECURSE MAKE_FILES LIST_DIRECTORIES false ${SOURCE_PATH}/WebKitBuild/Release/Makefile*)
foreach(MAKE_FILE ${MAKE_FILES})
    file(READ ${MAKE_FILE} _contents)
    string(REPLACE "${TARGET_PATH}" "${NEW_TARGET_PATH}" _contents "${_contents}")
    file(WRITE ${MAKE_FILE} "${_contents}")
endforeach()

message(STATUS "Install Release")
vcpkg_execute_required_process(
    COMMAND nmake install
    WORKING_DIRECTORY ${SOURCE_PATH}/WebKitBuild/Release
    LOGNAME install-Release
)

file(READ ${WEB_CORE_PRI}.bak _contents)
string(REPLACE "LIBS += libjpeg.lib" "LIBS += jpeg.lib" _contents "${_contents}")
string(REPLACE "LIBS += libpng.lib" "LIBS += libpng16d.lib" _contents "${_contents}")
string(REPLACE "LIBS += -lwebp" "LIBS += webpd.lib" _contents "${_contents}")
string(REPLACE "LIBS += zdll.lib" "LIBS += zlibd.lib" _contents "${_contents}")
string(REPLACE "PKGCONFIG += libxslt libxml-2.0" "LIBS += libxslt.lib libxml2.lib" _contents "${_contents}")
file(WRITE ${WEB_CORE_PRI} "${_contents}")

set(ENV{LIB} "${VCPKG_INSTALLED_DIR}/debug/lib;${VCPKG_INSTALLED_DIR}/debug/lib/manual-link;$ENV{LIB}")
message(STATUS "Build Debug")
vcpkg_execute_required_process(
    COMMAND ${PERL} Tools/Scripts/build-webkit ${BUILD_OPTIONS_DEBUG}
    WORKING_DIRECTORY ${SOURCE_PATH}
    LOGNAME build-debug
)

set(TARGET_PATH ${VCPKG_ROOT_DIR}/packages/qt5-base_${TARGET_TRIPLET})
string(REPLACE "/" "\\" TARGET_PATH "${TARGET_PATH}")
string(REPLACE ":\\" ":$(INSTALL_ROOT)\\" TARGET_PATH "${TARGET_PATH}")
set(NEW_TARGET_PATH ${CURRENT_PACKAGES_DIR}/debug)
string(REPLACE "/" "\\" NEW_TARGET_PATH "${NEW_TARGET_PATH}")
file(GLOB_RECURSE MAKE_FILES LIST_DIRECTORIES false ${SOURCE_PATH}/WebKitBuild/Debug/Makefile*)
foreach(MAKE_FILE ${MAKE_FILES})
    file(READ ${MAKE_FILE} _contents)
    string(REPLACE "${TARGET_PATH}" "${NEW_TARGET_PATH}" _contents "${_contents}")
    file(WRITE ${MAKE_FILE} "${_contents}")
endforeach()

message(STATUS "Install Debug")
vcpkg_execute_required_process(
    COMMAND nmake install
    WORKING_DIRECTORY ${SOURCE_PATH}/WebKitBuild/Debug
    LOGNAME install-debug
)

file(RENAME ${CURRENT_PACKAGES_DIR}/lib/cmake ${CURRENT_PACKAGES_DIR}/share/cmake)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/tests)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/share/qt5/bin)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/lib/cmake)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/tests)

vcpkg_find_acquire_program(PYTHON3)
vcpkg_execute_required_process(
    COMMAND ${PYTHON3} ${CMAKE_CURRENT_LIST_DIR}/../qt5-base/fixcmake.py
    WORKING_DIRECTORY ${CURRENT_PACKAGES_DIR}/share/cmake
    LOGNAME fix-cmake
)

vcpkg_copy_pdbs()

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE.LGPLv3 DESTINATION ${CURRENT_PACKAGES_DIR}/share/qtwebkit RENAME copyright)