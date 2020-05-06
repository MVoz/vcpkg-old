cmake_minimum_required(VERSION 3.4)

project(gtkmm)

set(GTKMM_VERSION_MAJOR  3)
set(GTKMM_VERSION_MINOR  22)
set(GTKMM_VERSION_MICRO  2)

set(GDKMM_VERSION_MAJOR  ${GTKMM_VERSION_MAJOR})
set(GDKMM_VERSION_MINOR  ${GTKMM_VERSION_MINOR})
set(GDKMM_VERSION_MICRO  ${GTKMM_VERSION_MICRO})

set(GTKMM_VERSION ${GTKMM_VERSION_MAJOR}.${GTKMM_VERSION_MINOR}.${GTKMM_VERSION_MICRO})

# Be consistent with the library names on other platforms
set(GDKMM_TARGET gdkmm-${GDKMM_VERSION_MAJOR}.0)
set(GTKMM_TARGET gtkmm-${GTKMM_VERSION_MAJOR}.0)

option(BUILD_SHARED_LIBS "Build shared Libraries." ON)

# avoid warning about inheritance and dominance
if(MSVC)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /wd4250")
endif()

message("pkg-config not found, falling back on manual dependency discovery")

# We only really need one include path for vcpkg as there is only one
find_path(GTK_INCLUDE_DIRS glib.h)

set(GDKMM_REQUIRED_INCLUDE_DIRS
    ${GTK_INCLUDE_DIRS}
)

# We don't need the define the whole stack,
# just the libraries we directly reference
find_library(GLIB_LIBRARIES glib-2.0)
find_library(GOBJECT_LIBRARIES gobject-2.0)
find_library(GTHREAD_LIBRARIES gthread-2.0)
find_library(GMODULE_LIBRARIES gmodule-2.0)
find_library(GDK_LIBRARIES gdk-3.0)
find_library(GDK_PIXBUF_LIBRARIES gdk_pixbuf-2.0)
find_library(GTK_LIBRARIES gtk-3.0)
find_library(SIGC_LIBRARIES sigc-2.0)
find_library(GIOMM_LIBRARIES giomm)
find_library(GLIBMM_LIBRARIES glibmm)
find_library(CAIROMM_LIBRARIES cairomm-1.0)
find_library(PANGOMM_LIBRARIES pangomm)
find_library(ATKMM_LIBRARIES atkmm)

set(GDKMM_REQUIRED_LIBRARIES
    ${GLIB_LIBRARIES}
    ${GOBJECT_LIBRARIES}
    ${GTHREAD_LIBRARIES}
    ${GMODULE_LIBRARIES}
    ${GDK_LIBRARIES}
    ${GDK_PIXBUF_LIBRARIES}
    ${GTK_LIBRARIES}
    ${SIGC_LIBRARIES}
    ${GIOMM_LIBRARIES}
    ${GLIBMM_LIBRARIES}
    ${CAIROMM_LIBRARIES}
    ${PANGOMM_LIBRARIES}
)

set(GTKMM_REQUIRED_LIBRARIES
    ${GDKMM_TARGET}
)

configure_file(gdk/gdkmmconfig.h.cmake gdkmmconfig.h)
configure_file(gtk/gtkmmconfig.h.cmake gtkmmconfig.h)

include_directories(${CMAKE_CURRENT_BINARY_DIR})

file(GLOB GDKMM_SOURCES "gdk/gdkmm/*.cc")

file(GLOB GTKMM_SOURCES "gtk/gtkmm/*.cc")

file(GLOB GTKMM_WINDOWS_EXCLUDE_SOURCES
    "gtk/gtkmm/pagesetupunixdialog.cc"
    "gtk/gtkmm/plug.cc"
    "gtk/gtkmm/printer.cc"
    "gtk/gtkmm/printjob.cc"
    "gtk/gtkmm/printunixdialog.cc"
    "gtk/gtkmm/socket.cc"
)

list(REMOVE_ITEM GTKMM_SOURCES ${GTKMM_WINDOWS_EXCLUDE_SOURCES})

file(GLOB GDKMM_HEADERS "gdk/*.h")
file(GLOB GTKMM_HEADERS "gtk/*.h")
file(GLOB GDKMM_SUBHEADERS "gdk/gdkmm/*.h")
file(GLOB GTKMM_SUBHEADERS "gtk/gtkmm/*.h")

# TODO Use include(GnuIncludeDirs) or whatever it is called

set(LIB_SUFFIX "" CACHE STRING "Define suffix of directory name (32/64)")
set(EXEC_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}" CACHE PATH "Base directory for executables and libraries")
set(BIN_INSTALL_DIR "${EXEC_INSTALL_PREFIX}/bin" CACHE PATH "The subdirectory to the binaries prefix (default prefix/bin)")
set(LIB_INSTALL_DIR "${EXEC_INSTALL_PREFIX}/lib${LIB_SUFFIX}" CACHE PATH "The subdirectory relative to the install prefix where libraries will be installed (default is /lib${LIB_SUFFIX})")
set(INCLUDE_INSTALL_DIR "${CMAKE_INSTALL_PREFIX}/include" CACHE PATH "The subdirectory to the header prefix")

add_library(${GDKMM_TARGET} ${GDKMM_SOURCES})

add_library(${GTKMM_TARGET} ${GTKMM_SOURCES})

set_target_properties(${GDKMM_TARGET} PROPERTIES
    CXX_STANDARD 11
    CXX_STANDARD_REQUIRED YES
    CXX_EXTENSIONS NO
)

set_target_properties(${GTKMM_TARGET} PROPERTIES
    CXX_STANDARD 11
    CXX_STANDARD_REQUIRED YES
    CXX_EXTENSIONS NO
)


if(BUILD_SHARED_LIBS)
    # TODO test for platform?
    if (MSVC)
        message("MSVC detected, exporting all symbols from DLL")
        set_target_properties(${GDKMM_TARGET} PROPERTIES WINDOWS_EXPORT_ALL_SYMBOLS true)
        set_target_properties(${GTKMM_TARGET} PROPERTIES WINDOWS_EXPORT_ALL_SYMBOLS true)
        #set_target_properties(${GTKMM_TARGET} PROPERTIES DEBUG_POSTFIX d)
        set(CMAKE_DEBUG_POSTFIX d)
    endif()
    # define anything for gdkmm?
    target_compile_definitions(${GTKMM_TARGET} PRIVATE "GTKMM_DLL" "GTKMM_BUILD" "_WINDLL")
else()
    target_compile_definitions(${GTKMM_TARGET} PRIVATE "GTKMM_STATIC_LIB")
endif()

target_include_directories(${GDKMM_TARGET} PUBLIC gdk ${GDKMM_REQUIRED_INCLUDE_DIRS})
target_include_directories(${GTKMM_TARGET} PUBLIC gtk)

target_link_libraries(${GDKMM_TARGET} PUBLIC ${GDKMM_REQUIRED_LIBRARIES})
target_link_libraries(${GTKMM_TARGET} PUBLIC ${GTKMM_REQUIRED_LIBRARIES})

# TODO examples

install(
    TARGETS ${GDKMM_TARGET} ${GTKMM_TARGET}
    RUNTIME DESTINATION ${BIN_INSTALL_DIR}
    LIBRARY DESTINATION ${LIB_INSTALL_DIR}
    ARCHIVE DESTINATION ${LIB_INSTALL_DIR}
)

install(FILES "${CMAKE_CURRENT_BINARY_DIR}/gdkmmconfig.h" DESTINATION "${INCLUDE_INSTALL_DIR}")
install(FILES "${CMAKE_CURRENT_BINARY_DIR}/gtkmmconfig.h" DESTINATION "${INCLUDE_INSTALL_DIR}")

install(FILES ${GDKMM_HEADERS} DESTINATION ${INCLUDE_INSTALL_DIR})
install(FILES ${GDKMM_SUBHEADERS} DESTINATION ${INCLUDE_INSTALL_DIR}/gdkmm)
install(FILES ${GTKMM_HEADERS} DESTINATION ${INCLUDE_INSTALL_DIR})
install(FILES ${GTKMM_SUBHEADERS} DESTINATION ${INCLUDE_INSTALL_DIR}/gtkmm)
