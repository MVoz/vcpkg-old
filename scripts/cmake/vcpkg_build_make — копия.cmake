## # vcpkg_build_cmake
##
## Build a make project.
##
## ## Usage:
## ```cmake
## vcpkg_build_make([TARGET <target>])
## ```
##
## ### TARGET
## The target passed to the cmake build command (`cmake --build . --target <target>`). If not specified, no target will
## be passed.
##
## ### ADD_BIN_TO_PATH
## Adds the appropriate Release and Debug `bin\` directories to the path during the build such that executables can run against the in-tree DLLs.
##
## ## Notes:
## This command should be preceeded by a call to [`vcpkg_configure_make()`](vcpkg_configure_cmake.md).
## You can use the alias [`vcpkg_install_make()`](vcpkg_configure_make.md) function if your CMake script supports the
## "install" target
function(vcpkg_build_make)
    cmake_parse_arguments(_bc "ADD_BIN_TO_PATH;GENERATOR" "LOGFILE_ROOT" "" ${ARGN})

    if(NOT _bc_LOGFILE_ROOT)
        set(_bc_LOGFILE_ROOT "build")
    endif()
	
	find_program(NMAKE nmake)
	
    if(_bc_GENERATOR STREQUAL NMAKE)
        if(CMAKE_HOST_WIN32)
            set(GENERATOR "nmake")
        endif()
    endif()
	
    if(GENERATOR STREQUAL nmake)
		find_program(NMAKE nmake)
		get_filename_component(NMAKE_PATH ${NMAKE} DIRECTORY)
		vcpkg_add_to_path(PREPEND "${NMAKE_PATH}")
        if(NOT NMAKE_FOUND)
            message(FATAL_ERROR "nmake not found.")
        endif()
        set(MAKE_CMD "${NMAKE}")
        set(INSTALL_CMD "${NMAKE} install")

    endif()
    
    set(ENV{INCLUDE} "${CURRENT_INSTALLED_DIR}/include;$ENV{INCLUDE}")

    foreach(BUILDTYPE "debug" "release")
        if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL BUILDTYPE)
            if(BUILDTYPE STREQUAL "debug")
                set(SHORT_BUILDTYPE "dbg")
                set(CONFIG "Debug")
            else()
                set(SHORT_BUILDTYPE "rel")
                set(CONFIG "Release")
            endif()

            message(STATUS "Building ${TARGET_TRIPLET}-${SHORT_BUILDTYPE}")

            if(_bc_ADD_BIN_TO_PATH)
                set(_BACKUP_ENV_PATH "$ENV{PATH}")
                if(CMAKE_HOST_WIN32)
                    set(_PATHSEP ";")
                else()
                    set(_PATHSEP ":")
                endif()
                if(BUILDTYPE STREQUAL "debug")
                    set(ENV{LIB} "${CURRENT_INSTALLED_DIR}/debug/lib;$ENV{LIB}")
                    set(ENV{PATH} "${CURRENT_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/debug/bin${_PATHSEP}$ENV{PATH}")
                else()
                    set(ENV{LIB} "${CURRENT_INSTALLED_DIR}/lib;$ENV{LIB}")
                    set(ENV{PATH} "${CURRENT_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/bin${_PATHSEP}$ENV{PATH}")
                endif()
            endif()

            vcpkg_execute_build_process(
                COMMAND ${MAKE_CMD} #${CONFIG}
                WORKING_DIRECTORY ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-${SHORT_BUILDTYPE}
                LOGNAME "${_bc_LOGFILE_ROOT}-${TARGET_TRIPLET}-${SHORT_BUILDTYPE}"
            )
            
            if(_bc_ENABLE_INSTALL)
                vcpkg_execute_build_process(
                    COMMAND ${INSTALL_CMD} #${CONFIG}
                    WORKING_DIRECTORY ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-${SHORT_BUILDTYPE}${PROJECT_SUBPATH}
                    LOGNAME "${_bc_LOGFILE_ROOT}-${TARGET_TRIPLET}-${SHORT_BUILDTYPE}"
                )
            endif()

            if(_bc_ADD_BIN_TO_PATH)
                set(ENV{PATH} "${_BACKUP_ENV_PATH}")
            endif()
        endif()
    endforeach()
endfunction()
