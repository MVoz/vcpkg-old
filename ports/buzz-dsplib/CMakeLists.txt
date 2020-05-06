cmake_minimum_required(VERSION 3.8)
project(buzz-dsplib CXX)

set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON)

#set(DSPLIB_SOURCES
#    dsplib/dsplib.cpp
#)

file(GLOB DSPLIB_SOURCES
	dsplib/dsplib.cpp
)

include_directories(${CMAKE_CURRENT_SOURCE_DIR})

add_library(dsplib
    ${DSPLIB_SOURCES}
)

install(TARGETS dsplib
    RUNTIME DESTINATION bin
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
)

install(
    FILES dsplib.h
    DESTINATION include
)
