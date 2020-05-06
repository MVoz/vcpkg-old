cmake_minimum_required(VERSION 3.8)

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

set(CMAKE_AUTOMOC ON)
set(CMAKE_DEBUG_POSTFIX d)

find_package(Qt5 COMPONENTS Core Widgets REQUIRED)

set(HEADERS src/QMfcApp
            src/qmfcapp.h
            src/QWinHost
            src/qwinhost.h
            src/QWinWidget
            src/qwinwidget.h)
set(SRCS src/qmfcapp.cpp
         src/qwinhost.cpp
         src/qwinwidget.cpp)

include_directories(${Qt5Widgets_PRIVATE_INCLUDE_DIRS} "${_qt5Gui_install_prefix}/include/QtGui/${Qt5Gui_VERSION_STRING}/QtGui")
link_libraries(Qt5::Widgets)

project(Qt5WinMigrate)
add_library(Qt5WinMigrate ${SRCS})
target_compile_definitions(Qt5WinMigrate PRIVATE QT_QTWINMIGRATE_EXPORT)

# project(QtWinMigrateMfc)
# add_library(QtWinMigrateMfc ${SRCS})
# target_compile_definitions(QtWinMigrateMfc PRIVATE QT_QTWINMIGRATE_EXPORT _AFXDLL)

install(TARGETS Qt5WinMigrate
        RUNTIME DESTINATION bin
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        FRAMEWORK DESTINATION ${CMAKE_INSTALL_PREFIX})

install(FILES ${HEADERS} DESTINATION ${CMAKE_INSTALL_PREFIX}/include/QtWinMigrate)