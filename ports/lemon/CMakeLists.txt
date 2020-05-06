cmake_minimum_required(VERSION 3.0)
project(lemon)

file(GLOB SRC
	tool/lemon.c
)

include_directories(${CMAKE_CURRENT_SOURCE_DIR})

add_executable(lemon ${SRC})

install(TARGETS lemon DESTINATION tools CONFIGURATIONS Release)
install(FILES tool/lempar.c DESTINATION tools)
