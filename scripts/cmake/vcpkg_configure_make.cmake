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
## ### NO_DEBUG
## This port doesn't support debug mode.
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
        "AUTOCONFIG;NO_DEBUG"
        "SOURCE_PATH;GENERATOR;PRERUN_SHELL;PROJECT_SUBPATH;PROJECT_PATH"
        "OPTIONS;OPTIONS_DEBUG;OPTIONS_RELEASE;POSTRUN_SHELL_DEBUG;POSTRUN_SHELL_RELEASE"
        ${ARGN}
    )

    if(NOT VCPKG_PLATFORM_TOOLSET)
        message(FATAL_ERROR "Vcpkg has been updated with VS2017 support; "
            "however, vcpkg.exe must be rebuilt by re-running bootstrap-vcpkg.bat\n")
    endif()

	function(sleep delay)
	  execute_process(
	    COMMAND ${CMAKE_COMMAND} -E sleep ${delay}
	    RESULT_VARIABLE result
	    )
	  if(NOT result EQUAL 0)
	    message(FATAL_ERROR "failed to sleep for ${delay} second.") #sleep(1) - 1 sec. #sleep(0.300) - 300 mlsec
	  endif()
	endfunction(sleep)

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

    set(ENV{INCLUDE} "${CURRENT_INSTALLED_DIR}/include${_PATHSEP}$ENV{INCLUDE}")
    if(BUILDTYPE STREQUAL "debug")
        set(ENV{LIB} "${CURRENT_INSTALLED_DIR}/debug/lib${_PATHSEP}$ENV{LIB}")
        set(ENV{PATH} "${CURRENT_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/debug/bin${_PATHSEP}$ENV{PATH}")
    else()
        set(ENV{LIB} "${CURRENT_INSTALLED_DIR}/lib${_PATHSEP}$ENV{LIB}")
        set(ENV{PATH} "${CURRENT_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/bin${_PATHSEP}$ENV{PATH}")
    endif()

    if(_csc_GENERATOR MATCHES NMAKE)
        if(CMAKE_HOST_WIN32)
            set(GENERATOR "NMake")
        else()
            set(GENERATOR "make")
        endif()
    elseif(_csc_GENERATOR MATCHES MAKE OR NOT _csc_GENERATOR)
        if(CMAKE_HOST_WIN32)
            set(GENERATOR "make")
        else()
            set(GENERATOR "make")
        endif()
    else()
        message(FATAL_ERROR "${_csc_GENERATOR} not supported.")
    endif()

    if(_csc_AUTOCONFIG AND NOT CMAKE_HOST_WIN32)
        find_program(autoreconf autoreconf)
        if(NOT autoreconf)
            message(FATAL_ERROR "autoreconf must be installed. Install them with \"apt-get dh-autoreconf\".")
        endif()
    endif()

    # If we use Ninja, make sure it's on PATH
    if(GENERATOR MATCHES "NMake")
        find_program(NMAKE nmake REQUIRED)
        set(ENV{CL} " /nologo /EHsc /DWIN32 /D_WIN32 /MP /W4 /WX- /bigobj /guard:cf- /analyze- /utf-8 /D_CRT_SECURE_NO_WARNINGS /D_SCL_SECURE_NO_WARNINGS ")
		#/D_SILENCE_ALL_CXX17_DEPRECATION_WARNINGS /std:c++17 /permissive- /d1scalableinclude-
		set(ENV{LINK} " /WX:NO ")
    elseif(GENERATOR MATCHES "make")
        if(CMAKE_HOST_WIN32)
            vcpkg_find_acquire_program(YASM)
            vcpkg_find_acquire_program(PERL)
            vcpkg_acquire_msys(MSYS_ROOT PACKAGES make)
            vcpkg_acquire_msys(MSYS_ROOT PACKAGES diffutils)
            get_filename_component(YASM_EXE_PATH ${YASM} DIRECTORY)
            get_filename_component(PERL_EXE_PATH ${PERL} DIRECTORY)
            
            message(STATUS "PERL_EXE_PATH ; ${PERL_EXE_PATH}")
            set(ENV{PATH} "${YASM_EXE_PATH};${MSYS_ROOT}/usr/bin;$ENV{PATH};${PERL_EXE_PATH}")
            set(BASH ${MSYS_ROOT}/usr/bin/bash.exe)
        else()
            find_program(MAKE make)
            if (NOT MAKE)
                message(FATAL_ERROR "MAKE not found.")
            endif()
        endif()
    else()
        message(FATAL_ERROR "${GENERATOR} not supported.")
    endif()
	
    file(REMOVE_RECURSE ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg)
        sleep(1)

#    set(_csc_OPTIONS_RELEASE ${_csc_OPTIONS_RELEASE} --bindir=${CURRENT_PACKAGES_DIR}/bin --sbindir=${CURRENT_PACKAGES_DIR}/bin --libdir=${CURRENT_PACKAGES_DIR}/lib --includedir=${CURRENT_PACKAGES_DIR}/include)
#    set(_csc_OPTIONS_DEBUG ${_csc_OPTIONS_DEBUG} --bindir=${CURRENT_PACKAGES_DIR}/debug/bin --sbindir=${CURRENT_PACKAGES_DIR}/debug/bin --libdir=${CURRENT_PACKAGES_DIR}/debug/lib --includedir=${CURRENT_PACKAGES_DIR}/debug/include)

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
    if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "debug" AND NOT _csc_NO_DEBUG)
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
                COMMAND autoreconf -vif
                WORKING_DIRECTORY ${OBJ_DIR}${_csc_PROJECT_SUBPATH}
                LOGNAME prerun-${TARGET_TRIPLET}-dbg
            )
        endif()
        
        message(STATUS "Configuring ${PORT} for ${TARGET_TRIPLET}-dbg")
        vcpkg_execute_required_process(
            COMMAND ${dbg_command}
            WORKING_DIRECTORY ${OBJ_DIR}${_csc_PROJECT_SUBPATH}
            LOGNAME config-${TARGET_TRIPLET}-dbg
        )

        if(_csc_POSTRUN_SHELL_DEBUG)
            message(STATUS "Install ${PORT} for ${TARGET_TRIPLET}-dbg")
            vcpkg_execute_required_process(
                COMMAND ${dbg_install}
                WORKING_DIRECTORY ${OBJ_DIR}${_csc_PROJECT_SUBPATH}
                LOGNAME prerun-${TARGET_TRIPLET}-dbg
            )
        endif()

    endif()

    # Configure release
    if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "release")
        if(_csc_NO_DEBUG)
            set(TAR_TRIPLET_DIR ${TARGET_TRIPLET})
            set(OBJ_DIR ${CURRENT_BUILDTREES_DIR}/${TAR_TRIPLET_DIR})
        else()
            set(TAR_TRIPLET_DIR ${TARGET_TRIPLET}-rel)
            set(OBJ_DIR ${CURRENT_BUILDTREES_DIR}/${TAR_TRIPLET_DIR})
        endif()
        file(MAKE_DIRECTORY ${OBJ_DIR})
        file(GLOB SOURCE_FILES ${_csc_SOURCE_PATH}/*)
        foreach(ONE_SOUCRCE_FILE ${SOURCE_FILES})
            file(COPY ${ONE_SOUCRCE_FILE} DESTINATION ${OBJ_DIR})
        endforeach()
        if(_csc_PRERUN_SHELL)
            message(STATUS "Prerun shell with ${TAR_TRIPLET_DIR}")
            vcpkg_execute_required_process(
                COMMAND ${base_cmd}${_csc_PRERUN_SHELL}
                WORKING_DIRECTORY ${OBJ_DIR}${_csc_PROJECT_SUBPATH}
                LOGNAME prerun-${TAR_TRIPLET_DIR}
            )
        endif()
        
        if(_csc_AUTOCONFIG)
            message(STATUS "Generating configure with ${TAR_TRIPLET_DIR}")
            vcpkg_execute_required_process(
                COMMAND autoreconf -vif
                WORKING_DIRECTORY ${OBJ_DIR}${_csc_PROJECT_SUBPATH}
                LOGNAME prerun-${TAR_TRIPLET_DIR}
            )
        endif()
        
        message(STATUS "Configuring ${PORT} for ${TAR_TRIPLET_DIR}")
        vcpkg_execute_required_process(
            COMMAND ${rel_command}
            WORKING_DIRECTORY ${OBJ_DIR}${_csc_PROJECT_SUBPATH}
            LOGNAME config-${TAR_TRIPLET_DIR}
        )

        if(_csc_POSTRUN_SHELL_RELEASE)
            message(STATUS "Install ${PORT} for ${TARGET_TRIPLET}-rel")
            vcpkg_execute_required_process(
                COMMAND ${rel_install}
                WORKING_DIRECTORY ${OBJ_DIR}${_csc_PROJECT_SUBPATH}
                LOGNAME prerun-${TARGET_TRIPLET}_rel
            )
        endif()
    endif()

    set(_VCPKG_MAKE_GENERATOR "${GENERATOR}" PARENT_SCOPE)
    set(_VCPKG_NO_DEBUG ${_csc_NO_DEBUG} PARENT_SCOPE)
endfunction()
