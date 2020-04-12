include(vcpkg_common_functions)

string(LENGTH "${CURRENT_BUILDTREES_DIR}" BUILDTREES_PATH_LENGTH)
if(BUILDTREES_PATH_LENGTH GREATER 37 AND CMAKE_HOST_WIN32)
    message(WARNING "Qt5's buildsystem uses very long paths and may fail on your system.\n"
        "We recommend moving vcpkg to a short path such as 'C:\\src\\vcpkg' or using the subst command."
    )
endif()

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR})
include(configure_qt)
include(install_qt)

set(MAJOR_MINOR 5.12)
set(FULL_VERSION ${MAJOR_MINOR}.3)
set(ARCHIVE_NAME "qtbase-everywhere-src-${FULL_VERSION}.tar.xz")

vcpkg_download_distfile(ARCHIVE_FILE
    URLS "http://download.qt.io/official_releases/qt/${MAJOR_MINOR}/${FULL_VERSION}/submodules/${ARCHIVE_NAME}"
    FILENAME ${ARCHIVE_NAME}
    SHA512 1dab927573eb22b1ae772de3a418f7d3999ea78d6e667a7f2494390dd1f0981ea93f4f892cb6e124ac18812c780ee71da3021b485c61eaf1ef2234a5c12b7fe2
)
vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE "${ARCHIVE_FILE}"
    REF ${FULL_VERSION}
)

# Remove vendored dependencies to ensure they are not picked up by the build
foreach(DEPENDENCY freetype zlib harfbuzzng libjpeg libpng double-conversion sqlite)
    if(EXISTS ${SOURCE_PATH}/src/3rdparty/${DEPENDENCY})
        file(REMOVE_RECURSE ${SOURCE_PATH}/src/3rdparty/${DEPENDENCY})
    endif()
endforeach()

file(REMOVE_RECURSE ${SOURCE_PATH}/include/QtZlib)

# This fixes issues on machines with default codepages that are not ASCII compatible, such as some CJK encodings
set(ENV{_CL_} "/utf-8")

set(CORE_OPTIONS
    -confirm-license
    -opensource
    -system-zlib
    -system-libjpeg
    -system-libpng
    -system-freetype
    -system-pcre
    -system-doubleconversion
    -system-sqlite
    -system-harfbuzz
    -no-fontconfig
    -nomake examples
    -nomake tests
)

if(VCPKG_LIBRARY_LINKAGE STREQUAL "static")
    list(APPEND CORE_OPTIONS
        -static
    )
endif()

if(NOT VCPKG_CMAKE_SYSTEM_NAME OR VCPKG_CMAKE_SYSTEM_NAME STREQUAL "WindowsStore")
    set(PLATFORM "win32-msvc")

    configure_qt(
        SOURCE_PATH ${SOURCE_PATH}
        PLATFORM ${PLATFORM}
        OPTIONS
            ${CORE_OPTIONS}
            -mp
            -opengl desktop # other options are "-no-opengl", "-opengl angle", and "-opengl desktop"
        OPTIONS_RELEASE
            LIBJPEG_LIBS="-ljpeg"
            ZLIB_LIBS="-lzlib"
            LIBPNG_LIBS="-llibpng16"
            PSQL_LIBS="-llibpq"
            PCRE2_LIBS="-lpcre2-16"
            FREETYPE_LIBS="-lfreetype"
        OPTIONS_DEBUG
            LIBJPEG_LIBS="-ljpegd"
            ZLIB_LIBS="-lzlibd"
            LIBPNG_LIBS="-llibpng16d"
            PSQL_LIBS="-llibpq"
            PCRE2_LIBS="-lpcre2-16d"
            FREETYPE_LIBS="-lfreetyped"
    )

elseif(VCPKG_CMAKE_SYSTEM_NAME STREQUAL "Linux")
    configure_qt(
        SOURCE_PATH ${SOURCE_PATH}
        PLATFORM "linux-g++"
        OPTIONS
            ${CORE_OPTIONS}
        OPTIONS_RELEASE
            "LIBJPEG_LIBS=${CURRENT_INSTALLED_DIR}/lib/libjpeg.a"
            "QMAKE_LIBS_PRIVATE+=${CURRENT_INSTALLED_DIR}/lib/libpng16.a"
            "QMAKE_LIBS_PRIVATE+=${CURRENT_INSTALLED_DIR}/lib/libz.a"
            "ZLIB_LIBS=${CURRENT_INSTALLED_DIR}/lib/libz.a"
            "LIBPNG_LIBS=${CURRENT_INSTALLED_DIR}/lib/libpng16.a"
            "FREETYPE_LIBS=${CURRENT_INSTALLED_DIR}/lib/libfreetype.a"
            "PSQL_LIBS=${CURRENT_INSTALLED_DIR}/lib/libpq.a ${CURRENT_INSTALLED_DIR}/lib/libssl.a ${CURRENT_INSTALLED_DIR}/lib/libcrypto.a -ldl -lpthread"
            "SQLITE_LIBS=${CURRENT_INSTALLED_DIR}/lib/libsqlite3.a -ldl -lpthread"
        OPTIONS_DEBUG
            "LIBJPEG_LIBS=${CURRENT_INSTALLED_DIR}/debug/lib/libjpeg.a"
            "QMAKE_LIBS_PRIVATE+=${CURRENT_INSTALLED_DIR}/debug/lib/libpng16d.a"
            "QMAKE_LIBS_PRIVATE+=${CURRENT_INSTALLED_DIR}/debug/lib/libz.a"
            "ZLIB_LIBS=${CURRENT_INSTALLED_DIR}/debug/lib/libz.a"
            "LIBPNG_LIBS=${CURRENT_INSTALLED_DIR}/debug/lib/libpng16d.a"
            "FREETYPE_LIBS=${CURRENT_INSTALLED_DIR}/debug/lib/libfreetyped.a"
            "PSQL_LIBS=${CURRENT_INSTALLED_DIR}/debug/lib/libpqd.a ${CURRENT_INSTALLED_DIR}/debug/lib/libssl.a ${CURRENT_INSTALLED_DIR}/debug/lib/libcrypto.a -ldl -lpthread"
            "SQLITE_LIBS=${CURRENT_INSTALLED_DIR}/debug/lib/libsqlite3.a -ldl -lpthread"
    )

elseif(VCPKG_CMAKE_SYSTEM_NAME STREQUAL "Darwin")
configure_qt(
    SOURCE_PATH ${SOURCE_PATH}
    PLATFORM "macx-clang"
    OPTIONS
        ${CORE_OPTIONS}
    OPTIONS_RELEASE
        "LIBJPEG_LIBS=${CURRENT_INSTALLED_DIR}/lib/libjpeg.a"
        "QMAKE_LIBS_PRIVATE+=${CURRENT_INSTALLED_DIR}/lib/libpng16.a"
        "QMAKE_LIBS_PRIVATE+=${CURRENT_INSTALLED_DIR}/lib/libz.a"
        "ZLIB_LIBS=${CURRENT_INSTALLED_DIR}/lib/libz.a"
        "LIBPNG_LIBS=${CURRENT_INSTALLED_DIR}/lib/libpng16.a"
        "FREETYPE_LIBS=${CURRENT_INSTALLED_DIR}/lib/libfreetype.a"
        "PSQL_LIBS=${CURRENT_INSTALLED_DIR}/lib/libpq.a ${CURRENT_INSTALLED_DIR}/lib/libssl.a ${CURRENT_INSTALLED_DIR}/lib/libcrypto.a -ldl -lpthread"
        "SQLITE_LIBS=${CURRENT_INSTALLED_DIR}/lib/libsqlite3.a -ldl -lpthread"
        "HARFBUZZ_LIBS=${CURRENT_INSTALLED_DIR}/lib/libharfbuzz.a -framework ApplicationServices"
    OPTIONS_DEBUG
        "LIBJPEG_LIBS=${CURRENT_INSTALLED_DIR}/debug/lib/libjpeg.a"
        "QMAKE_LIBS_PRIVATE+=${CURRENT_INSTALLED_DIR}/debug/lib/libpng16d.a"
        "QMAKE_LIBS_PRIVATE+=${CURRENT_INSTALLED_DIR}/debug/lib/libz.a"
        "ZLIB_LIBS=${CURRENT_INSTALLED_DIR}/debug/lib/libz.a"
        "LIBPNG_LIBS=${CURRENT_INSTALLED_DIR}/debug/lib/libpng16d.a"
        "FREETYPE_LIBS=${CURRENT_INSTALLED_DIR}/debug/lib/libfreetyped.a"
        "PSQL_LIBS=${CURRENT_INSTALLED_DIR}/debug/lib/libpqd.a ${CURRENT_INSTALLED_DIR}/debug/lib/libssl.a ${CURRENT_INSTALLED_DIR}/debug/lib/libcrypto.a -ldl -lpthread"
        "SQLITE_LIBS=${CURRENT_INSTALLED_DIR}/debug/lib/libsqlite3.a -ldl -lpthread"
        "HARFBUZZ_LIBS=${CURRENT_INSTALLED_DIR}/debug/lib/libharfbuzz.a -framework ApplicationServices"
)
endif()

if(VCPKG_CMAKE_SYSTEM_NAME STREQUAL "Darwin")
    install_qt(DISABLE_PARALLEL) # prevent race condition on Mac
else()
    install_qt()
endif()

file(RENAME ${CURRENT_PACKAGES_DIR}/lib/cmake ${CURRENT_PACKAGES_DIR}/share/cmake)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/lib/cmake)

if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "release")
    file(GLOB BINARY_TOOLS "${CURRENT_PACKAGES_DIR}/bin/*")
    list(FILTER BINARY_TOOLS EXCLUDE REGEX "\\.dll\$")
    file(INSTALL ${BINARY_TOOLS} DESTINATION ${CURRENT_PACKAGES_DIR}/tools/qt5)
    file(REMOVE ${BINARY_TOOLS})

    file(COPY ${CMAKE_CURRENT_LIST_DIR}/qt_release.conf DESTINATION ${CURRENT_PACKAGES_DIR}/tools/qt5)
endif()
if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "debug")
    file(GLOB BINARY_TOOLS "${CURRENT_PACKAGES_DIR}/debug/bin/*")
    list(FILTER BINARY_TOOLS EXCLUDE REGEX "\\.dll\$")
    file(REMOVE ${BINARY_TOOLS})
    if(VCPKG_LIBRARY_LINKAGE STREQUAL "static")
        file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/bin" "${CURRENT_PACKAGES_DIR}/debug/bin")
    endif()

    file(COPY ${CMAKE_CURRENT_LIST_DIR}/qt_debug.conf DESTINATION ${CURRENT_PACKAGES_DIR}/tools/qt5)
endif()

vcpkg_execute_required_process(
    COMMAND ${PYTHON3} ${CMAKE_CURRENT_LIST_DIR}/fixcmake.py
    WORKING_DIRECTORY ${CURRENT_PACKAGES_DIR}/share/cmake
    LOGNAME fix-cmake
)

vcpkg_copy_tool_dependencies(${CURRENT_PACKAGES_DIR}/tools/${PORT})
vcpkg_copy_tool_dependencies(${CURRENT_PACKAGES_DIR}/tools/qt5)

if(EXISTS ${CURRENT_PACKAGES_DIR}/lib/qtmain.lib)
    #---------------------------------------------------------------------------
    # qtmain(d) vs. Qt5AxServer(d)
    #---------------------------------------------------------------------------
    # Qt applications have to either link to qtmain(d) or to Qt5AxServer(d),
    # never both. See http://doc.qt.io/qt-5/activeqt-server.html for more info.
    #
    # Create manual-link folders:
    if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "release")
        file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/lib/manual-link)
    endif()
    if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "debug")
        file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/debug/lib/manual-link)
    endif()
    #
    # Either have users explicitly link against qtmain.lib, qtmaind.lib:
    if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "release")
        file(COPY ${CURRENT_PACKAGES_DIR}/lib/qtmain.lib DESTINATION ${CURRENT_PACKAGES_DIR}/lib/manual-link)
        file(COPY ${CURRENT_PACKAGES_DIR}/lib/qtmain.prl DESTINATION ${CURRENT_PACKAGES_DIR}/lib/manual-link)
        file(REMOVE ${CURRENT_PACKAGES_DIR}/lib/qtmain.lib)
        file(REMOVE ${CURRENT_PACKAGES_DIR}/lib/qtmain.prl)
    endif()
    if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "debug")
        file(COPY ${CURRENT_PACKAGES_DIR}/debug/lib/qtmaind.lib DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib/manual-link)
        file(COPY ${CURRENT_PACKAGES_DIR}/debug/lib/qtmaind.prl DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib/manual-link)
        file(REMOVE ${CURRENT_PACKAGES_DIR}/debug/lib/qtmaind.lib)
        file(REMOVE ${CURRENT_PACKAGES_DIR}/debug/lib/qtmaind.prl)
    endif()

    #---------------------------------------------------------------------------
    # Qt5Bootstrap: only used to bootstrap qmake dependencies
    #---------------------------------------------------------------------------
    if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "debug")
        file(REMOVE ${CURRENT_PACKAGES_DIR}/debug/lib/Qt5Bootstrap.lib)
        file(REMOVE ${CURRENT_PACKAGES_DIR}/debug/lib/Qt5Bootstrap.prl)
    endif()
    if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "release")
        file(RENAME ${CURRENT_PACKAGES_DIR}/lib/Qt5Bootstrap.lib ${CURRENT_PACKAGES_DIR}/tools/qt5/Qt5Bootstrap.lib)
        file(RENAME ${CURRENT_PACKAGES_DIR}/lib/Qt5Bootstrap.prl ${CURRENT_PACKAGES_DIR}/tools/qt5/Qt5Bootstrap.prl)
    endif()
    #---------------------------------------------------------------------------
endif()

file(GLOB_RECURSE PRL_FILES "${CURRENT_PACKAGES_DIR}/lib/*.prl" "${CURRENT_PACKAGES_DIR}/debug/lib/*.prl")
if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "release")
    file(TO_CMAKE_PATH "${CURRENT_INSTALLED_DIR}/lib" CMAKE_RELEASE_LIB_PATH)
endif()
if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "debug")
    file(TO_CMAKE_PATH "${CURRENT_INSTALLED_DIR}/debug/lib" CMAKE_DEBUG_LIB_PATH)
endif()
foreach(PRL_FILE IN LISTS PRL_FILES)
    file(READ "${PRL_FILE}" _contents)
    if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "release")
        string(REPLACE "${CMAKE_RELEASE_LIB_PATH}" "\$\$[QT_INSTALL_LIBS]" _contents "${_contents}")
    endif()
    if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "debug")
        string(REPLACE "${CMAKE_DEBUG_LIB_PATH}" "\$\$[QT_INSTALL_LIBS]" _contents "${_contents}")
    endif()
    file(WRITE "${PRL_FILE}" "${_contents}")
endforeach()

if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "release")
    file(COPY ${CMAKE_CURRENT_LIST_DIR}/qtdeploy.ps1 DESTINATION ${CURRENT_PACKAGES_DIR}/plugins)
endif()
if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "debug")
    file(COPY ${CMAKE_CURRENT_LIST_DIR}/qtdeploy.ps1 DESTINATION ${CURRENT_PACKAGES_DIR}/debug/plugins)
endif()

file(COPY ${CMAKE_CURRENT_LIST_DIR}/vcpkg-cmake-wrapper.cmake DESTINATION ${CURRENT_PACKAGES_DIR}/share/qt5core)

file(INSTALL ${SOURCE_PATH}/LICENSE.LGPLv3 DESTINATION  ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
<<<<<<< HEAD
#
=======
>>>>>>> remove extra d from libpq
