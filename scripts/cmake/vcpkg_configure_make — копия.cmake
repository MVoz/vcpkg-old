## # vcpkg_configure_make
##
## Configure configure for Debug and Release builds of a project.
##
## ## Usage
## ```cmake
## vcpkg_configure_make(
##     SOURCE_PATH <${SOURCE_PATH}>
##     [AUTOCONFIG]
##     [GENERATOR]
##     [PRERUN_SHELL <${SHELL_PATH}>]
##     [OPTIONS <-DUSE_THIS_IN_ALL_BUILDS=1>...]
##     [OPTIONS_RELEASE <-DOPTIMIZE=1>...]
##     [OPTIONS_DEBUG <-DDEBUGGABLE=1>...]
## )
## ```
##
## ## Parameters
## ### SOURCE_PATH
## Specifies the directory containing the `CMakeLists.txt`.
## By convention, this is usually set in the portfile as the variable `SOURCE_PATH`.
##
## ### AUTOCONFIG
## Need to use autoconfig to generate configure.
##
## ### GENERATOR
## Specifies the precise generator to use.
##
## This is useful if some project-specific buildsystem has been wrapped in a cmake script that won't perform an actual build.
## If used for this purpose, it should be set to "NMake Makefiles".
##
## ### PRERUN_SHELL
## Script that needs to be called before configuration
##
## ### OPTIONS
## Additional options passed to CMake during the configuration.
##
## ### OPTIONS_RELEASE
## Additional options passed to CMake during the Release configuration. These are in addition to `OPTIONS`.
##
## ### OPTIONS_DEBUG
## Additional options passed to CMake during the Debug configuration. These are in addition to `OPTIONS`.
##
## ## Notes
## This command supplies many common arguments to CMake. To see the full list, examine the source.
function(vcpkg_configure_make)
    cmake_parse_arguments(
        _csc
        "AUTOCONFIG"
        "SOURCE_PATH;GENERATOR;PRERUN_SHELL;PROJECT_SUBPATH;PROJECT_PATH"
        "OPTIONS;OPTIONS_DEBUG;OPTIONS_RELEASE;POSTRUN_SHELL_DEBUG;POSTRUN_SHELL_RELEASE"
        ${ARGN}
    )

    if(NOT VCPKG_PLATFORM_TOOLSET)
        message(FATAL_ERROR "Vcpkg has been updated with VS2017 support; "
            "however, vcpkg.exe must be rebuilt by re-running bootstrap-vcpkg.bat\n")
    endif()

    if(CMAKE_HOST_WIN32)
        set(_PATHSEP ";")
        if(DEFINED ENV{PROCESSOR_ARCHITEW6432})
            set(_csc_HOST_ARCHITECTURE $ENV{PROCESSOR_ARCHITEW6432})
        else()
            set(_csc_HOST_ARCHITECTURE $ENV{PROCESSOR_ARCHITECTURE})
        endif()
    else()
        set(_PATHSEP ":")
    endif()

    if(_csc_GENERATOR MATCHES "NMake")
        if(CMAKE_HOST_WIN32)
        find_program(NMAKE nmake REQUIRED)
        set(ENV{CL} " /MP /utf-8 ")
        set(GENERATOR "NMake")
#    elseif(_VCPKG_CMAKE_GENERATOR MATCHES "Visual Studio")
#        set(BUILD_ARGS
#            "/p:VCPkgLocalAppDataDisabled=true"
#            "/p:UseIntelMKL=No"
#        )
#        set(PARALLEL_ARG "/m")
#    elseif(_VCPKG_CMAKE_GENERATOR MATCHES "NMake")
# No options are currently added for nmake builds
        endif()
    else()
        message(FATAL_ERROR "Unrecognized GENERATOR")
    endif()

    if(_csc_AUTOCONFIG AND NOT CMAKE_HOST_WIN32)
        find_program(autoreconf autoreconf)
        if(NOT autoreconf)
            message(FATAL_ERROR "autoreconf must be installed. Install them with \"apt-get dh-autoreconf\".")
        endif()
    endif()

    # If we use Ninja, make sure it's on PATH
    if(GENERATOR STREQUAL "NMake")
        find_program(NMAKE nmake REQUIRED)
        set(ENV{CL} " /MP /utf-8 ")
    endif()

    file(REMOVE_RECURSE ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg)
        sleep(1)

    set(base_cmd )
    if(CMAKE_HOST_WIN32)
        set(base_cmd ${NMAKE} /NOLOGO /G /U /f "${_csc_PROJECT_PATH}")
        set(rel_command
            ${base_cmd} "${_csc_OPTIONS}" "${_csc_OPTIONS_RELEASE}"
        )
        set(dbg_command
            ${base_cmd} "${_csc_OPTIONS}" "${_csc_OPTIONS_DEBUG}"
        )
        set(rel_install
            ${base_cmd} "${_csc_POSTRUN_SHELL_RELEASE}"
        )
        set(dbg_install
            ${base_cmd} "${_csc_POSTRUN_SHELL_DEBUG}"
        )
    elseif()
        set(base_cmd ${BASH} --noprofile --norc )
        set(rel_command
            ${base_cmd} "configure" "${_csc_OPTIONS}" "${_csc_OPTIONS_RELEASE}"
        )
        set(dbg_command
            ${base_cmd} "configure" "${_csc_OPTIONS}" "${_csc_OPTIONS_DEBUG}"
        )
    else()
        set(base_cmd ./)
        set(rel_command
            ${base_cmd}configure "${_csc_OPTIONS}" "${_csc_OPTIONS_RELEASE}"
        )
        set(dbg_command
            ${base_cmd}configure "${_csc_OPTIONS}" "${_csc_OPTIONS_DEBUG}"
        )
    endif()
    
    # Configure debug
    if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "debug")
        set(OBJ_DIR ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg)
        file(MAKE_DIRECTORY ${OBJ_DIR})
        file(GLOB SOURCE_FILES ${_csc_SOURCE_PATH}/*)
        foreach(ONE_SOUCRCE_FILE ${SOURCE_FILES})
            file(COPY ${ONE_SOUCRCE_FILE} DESTINATION ${OBJ_DIR})
        endforeach()
        if(_csc_PRERUN_SHELL)
            message(STATUS "Prerun shell with ${TARGET_TRIPLET}-dbg")
            vcpkg_execute_required_process(
                COMMAND ${base_cmd}${_csc_PRERUN_SHELL}
                WORKING_DIRECTORY ${OBJ_DIR}${_csc_PROJECT_SUBPATH}
                LOGNAME prerun-${TARGET_TRIPLET}-dbg
            )
        endif()
        
        if(_csc_AUTOCONFIG)
            message(STATUS "Generating configure with ${TARGET_TRIPLET}-dbg")
            vcpkg_execute_required_process(
                COMMAND autoreconf -v --install
                WORKING_DIRECTORY ${OBJ_DIR}${_csc_PROJECT_SUBPATH}
                LOGNAME prerun-${TARGET_TRIPLET}-dbg
            )
        endif()
        
        message(STATUS "Configuring ${TARGET_TRIPLET}-dbg")
        vcpkg_execute_required_process(
            COMMAND ${dbg_command}
            WORKING_DIRECTORY ${OBJ_DIR}${_csc_PROJECT_SUBPATH}
            LOGNAME config-${TARGET_TRIPLET}-dbg
        )

        if(_csc_POSTRUN_SHELL_DEBUG)
            message(STATUS "Prerun shell with ${TARGET_TRIPLET}-dbg")
            vcpkg_execute_required_process(
                COMMAND ${dbg_install}
                WORKING_DIRECTORY ${OBJ_DIR}${_csc_PROJECT_SUBPATH}
                LOGNAME prerun-${TARGET_TRIPLET}-dbg
            )
        endif()

    endif()

    # Configure release
    if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "release")
        set(OBJ_DIR ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel)
        file(MAKE_DIRECTORY ${OBJ_DIR})
        file(GLOB SOURCE_FILES ${_csc_SOURCE_PATH}/*)
        foreach(ONE_SOUCRCE_FILE ${SOURCE_FILES})
            file(COPY ${ONE_SOUCRCE_FILE} DESTINATION ${OBJ_DIR})
        endforeach()
        if(_csc_PRERUN_SHELL)
            message(STATUS "Prerun shell with ${TARGET_TRIPLET}-rel")
            vcpkg_execute_required_process(
                COMMAND ${base_cmd}${_csc_PRERUN_SHELL}
                WORKING_DIRECTORY ${OBJ_DIR}${_csc_PROJECT_SUBPATH}
                LOGNAME prerun-${TARGET_TRIPLET}_rel
            )
        endif()
        
        if(_csc_AUTOCONFIG)
            message(STATUS "Generating configure with ${TARGET_TRIPLET}-rel")
            vcpkg_execute_required_process(
                COMMAND autoreconf -v --install
                WORKING_DIRECTORY ${OBJ_DIR}${_csc_PROJECT_SUBPATH}
                LOGNAME prerun-${TARGET_TRIPLET}-dbg
            )
        endif()
        
        message(STATUS "Configuring ${TARGET_TRIPLET}-rel")
        vcpkg_execute_required_process(
            COMMAND ${rel_command}
            WORKING_DIRECTORY ${OBJ_DIR}${_csc_PROJECT_SUBPATH}
            LOGNAME config-${TARGET_TRIPLET}-rel
        )

        if(_csc_POSTRUN_SHELL_RELEASE)
            message(STATUS "Prerun shell with ${TARGET_TRIPLET}-rel")
            vcpkg_execute_required_process(
                COMMAND ${rel_install}
                WORKING_DIRECTORY ${OBJ_DIR}${_csc_PROJECT_SUBPATH}
                LOGNAME prerun-${TARGET_TRIPLET}_rel
            )
        endif()
    endif()

    set(_VCPKG_MAKE_GENERATOR "${GENERATOR}" PARENT_SCOPE)
endfunction()
