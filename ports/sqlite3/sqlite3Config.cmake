get_filename_component(sqlite3_CMAKE_DIR "${CMAKE_CURRENT_LIST_FILE}" PATH)
include(CMakeFindDependencyMacro)

find_dependency(Threads REQUIRED)

if(NOT TARGET sqlite3)
    include("${sqlite3_CMAKE_DIR}/sqlite3Targets.cmake")
endif()

