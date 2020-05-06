cmake_minimum_required(VERSION 3.12 FATAL_ERROR)

project(wren LANGUAGES C)

# Options to enable/disable features
option(WREN_ENABLE_CLI "Enable building CLI tool" Off)
option(WREN_ENABLE_META "Enable the Meta class in wren, allowing for source code inspection" On)
option(WREN_ENABLE_RANDOM "Enable the Random class in wren, allowing for generation of random numbers" On)

message(STATUS "Wren CLI tool: ${WREN_ENABLE_CLI}")
message(STATUS "Wren Meta class: ${WREN_ENABLE_META}")
message(STATUS "Wren Random tool: ${WREN_ENABLE_RANDOM}")

# Find all sources
file(GLOB_RECURSE VM_SOURCES LIST_DIRECTORIES false CONFIGURE_DEPENDS "src/vm/*.c")
file(GLOB_RECURSE CLI_SOURCES LIST_DIRECTORIES false CONFIGURE_DEPENDS "src/cli/*.c" "src/module/*.c")
if(WREN_ENABLE_META)
	set(META_SOURCES "src/optional/wren_opt_meta.c")
endif()
if(WREN_ENABLE_RANDOM)
	set(RANDOM_SOURCES "src/optional/wren_opt_random.c")
endif()

# Find dependencies
if(WREN_ENABLE_CLI)
	find_package(Threads REQUIRED)
	find_package(unofficial-libuv CONFIG REQUIRED)
endif()

include(GNUInstallDirs)

################
# wren vm core #
################

add_library(wren ${VM_SOURCES} ${META_SOURCES} ${RANDOM_SOURCES})
target_include_directories(wren PUBLIC $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/src/include>)
target_include_directories(wren PUBLIC $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>)
if(WREN_ENABLE_META)
	target_compile_definitions(wren PUBLIC WREN_OPT_META=1)
else()
	target_compile_definitions(wren PUBLIC WREN_OPT_META=0)
endif()
if(WREN_ENABLE_RANDOM)
	target_compile_definitions(wren PUBLIC WREN_OPT_RANDOM=1)
else()
	target_compile_definitions(wren PUBLIC WREN_OPT_RANDOM=0)
endif()

if(WREN_ENABLE_META OR WREN_ENABLE_RANDOM)
	target_include_directories(wren PUBLIC $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/src/optional>)
	target_include_directories(wren PUBLIC $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/src/vm>)
endif()
set_target_properties(wren PROPERTIES WINDOWS_EXPORT_ALL_SYMBOLS True)

install(
    TARGETS wren EXPORT wren-config
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}/
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}/
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}/
)

install(
    DIRECTORY ${CMAKE_SOURCE_DIR}/src/include/
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
    FILES_MATCHING PATTERN "*.h*" PATTERN "*.hpp*"
)

#######
# CLI #
#######

if(WREN_ENABLE_CLI)
	add_executable(wren-cli ${CLI_SOURCES})
	target_include_directories(wren-cli PRIVATE $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/src/cli>)
	target_include_directories(wren-cli PRIVATE $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/src/module>)
	target_link_libraries(wren-cli PRIVATE wren unofficial::libuv::libuv Threads::Threads)
	if(NOT WIN32)
		target_link_libraries(wren-cli PRIVATE m)
	endif()

	install(
	    TARGETS wren-cli EXPORT wren-config
	    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}/
	    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}/
	    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}/
	)
endif()

#################
# CMake exports #
#################

install(
    EXPORT wren-config DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/wren
)
