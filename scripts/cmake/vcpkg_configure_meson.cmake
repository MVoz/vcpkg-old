function(vcpkg_configure_meson)
    cmake_parse_arguments(_vcm "" "SOURCE_PATH" "OPTIONS;OPTIONS_DEBUG;OPTIONS_RELEASE" ${ARGN})
    
    file(REMOVE_RECURSE ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel)
    file(REMOVE_RECURSE ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg)
    
    # use the same compiler options as in vcpkg_configure_cmake
    set(MESON_COMMON_CFLAGS "${MESON_COMMON_CFLAGS} /DWIN32 /D_WINDOWS /W3 /utf-8")
    set(MESON_COMMON_CXXFLAGS "${MESON_COMMON_CXXFLAGS} /DWIN32 /D_WINDOWS /W3 /utf-8 /GR /EHsc")
    
    if(DEFINED VCPKG_CRT_LINKAGE AND VCPKG_CRT_LINKAGE STREQUAL dynamic)
        set(MESON_DEBUG_CFLAGS "${MESON_DEBUG_CFLAGS} /D_DEBUG /MDd /Z7 /Ob0 /Od /RTC1")
        set(MESON_DEBUG_CXXFLAGS "${MESON_DEBUG_CXXFLAGS} /D_DEBUG /MDd /Z7 /Ob0 /Od /RTC1")
        
        set(MESON_RELEASE_CFLAGS "${MESON_RELEASE_CFLAGS} /MD /O2 /Oi /Gy /DNDEBUG /Z7")
        set(MESON_RELEASE_CXXFLAGS "${MESON_RELEASE_CXXFLAGS} /MD /O2 /Oi /Gy /DNDEBUG /Z7")
    elseif(DEFINED VCPKG_CRT_LINKAGE AND VCPKG_CRT_LINKAGE STREQUAL static)
        set(MESON_DEBUG_CFLAGS "${MESON_DEBUG_CFLAGS} /D_DEBUG /MTd /Z7 /Ob0 /Od /RTC1")
        set(MESON_DEBUG_CXXFLAGS "${MESON_DEBUG_CXXFLAGS} /D_DEBUG /MTd /Z7 /Ob0 /Od /RTC1")
        
        set(MESON_RELEASE_CFLAGS "${MESON_RELEASE_CFLAGS} /MT /O2 /Oi /Gy /DNDEBUG /Z7")
        set(MESON_RELEASE_CXXFLAGS "${MESON_RELEASE_CXXFLAGS} /MT /O2 /Oi /Gy /DNDEBUG /Z7")
    endif()
    
    set(MESON_COMMON_LDFLAGS "${MESON_COMMON_LDFLAGS} /DEBUG")
    set(MESON_RELEASE_LDFLAGS "${MESON_RELEASE_LDFLAGS} /INCREMENTAL:NO /OPT:REF /OPT:ICF")
    
    # select meson cmd-line options
    #  --backend ninja  --backend vs2017  --backend vs
    list(APPEND _vcm_OPTIONS --buildtype plain)
    if(VCPKG_LIBRARY_LINKAGE STREQUAL dynamic)
        list(APPEND _vcm_OPTIONS --default-library shared)
    else()
        list(APPEND _vcm_OPTIONS --default-library static)
    endif()
    
    list(APPEND _vcm_OPTIONS_DEBUG --prefix ${CURRENT_PACKAGES_DIR}/debug --includedir ../include)
    list(APPEND _vcm_OPTIONS_RELEASE --prefix  ${CURRENT_PACKAGES_DIR})
    
    vcpkg_find_acquire_program(MESON)
    vcpkg_find_acquire_program(NINJA)
    vcpkg_find_acquire_program(CMAKE)
	
    find_program(GIT NAMES git git.cmd)
    get_filename_component(NINJA_PATH ${NINJA} DIRECTORY)
    get_filename_component(GIT_PATH ${GIT} DIRECTORY)
    get_filename_component(CMAKE_PATH ${CMAKE} DIRECTORY)
	
    if(CMAKE_HOST_WIN32)
        set(_PATHSEP ";")
    else()
        set(_PATHSEP ":")
    endif()
    set(ENV{PATH} "${_PATHSEP}$ENV{PATH}${_PATHSEP}${NINJA_PATH}${_PATHSEP}${GIT_PATH}${_PATHSEP}${CMAKE_PATH}")

    set(PYTHON_RELEASE_EXECUTABLE ${CURRENT_INSTALLED_DIR}/python3/python.exe)
    set(PYTHON_DEBUG_EXECUTABLE ${CURRENT_INSTALLED_DIR}/debug/python3/python_d.exe)

    set(ENV{PYTHONIOENCODING} UTF-8)
	
    set(CMAKE_FIND_LIBRARY_SUFFIXES .lib .dll.lib .dll .a)
    set(CMAKE_FIND_LIBRARY_PREFIXES bin lib)

    # wrap subprojects
    if(NOT DEFINED VCPKG_BUILD_TYPE)
        message(STATUS "Downloading subprojects ...")
        vcpkg_execute_required_process(
            COMMAND ${MESON} subprojects download
            WORKING_DIRECTORY ${SOURCE_PATH}
            LOGNAME subprojects-${TARGET_TRIPLET}
        )
        message(STATUS "Download subprojects ${TARGET_TRIPLET} done")
    endif()
	
    # PYTHONUTF8=1 python 3.6+ ## enables the interpreter’s UTF-8 mode
    ## pkg-config --variable pc_path pkg-config
    # configure release
    if(NOT DEFINED VCPKG_BUILD_TYPE STREQUAL "release")
        message(STATUS "Configuring ${TARGET_TRIPLET}-rel")
        file(MAKE_DIRECTORY ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel)
        set(ENV{CFLAGS} "${MESON_COMMON_CFLAGS} ${MESON_RELEASE_CFLAGS}")
        set(ENV{CXXFLAGS} "${MESON_COMMON_CXXFLAGS} ${MESON_RELEASE_CXXFLAGS}")
        set(ENV{LDFLAGS} "${MESON_COMMON_LDFLAGS} ${MESON_RELEASE_LDFLAGS}")
        set(ENV{CPPFLAGS} "${MESON_COMMON_CPPFLAGS} ${MESON_RELEASE_CPPFLAGS}")
        set(ENV{PKG_CONFIG_PATH} "${CURRENT_INSTALLED_DIR}/lib/pkgconfig")
        set(ENV{PKG_CONFIG_DIR} "${CURRENT_INSTALLED_DIR}/lib/pkgconfig")
#        set(PYTHON_EXECUTABLE ${CURRENT_INSTALLED_DIR}/python3/python.exe)
        set(ENV{PYTHON_CMD} ${PYTHON3})

        set(ENV{PKG_CONFIG} ${CURRENT_INSTALLED_DIR}/bin/pkg-config)
        set(ENV{PKGCONFIG_EXECUTABLE} ${CURRENT_INSTALLED_DIR}/bin/pkg-config)
        set(ENV{PKG_CONFIG_EXECUTABLE} ${CURRENT_INSTALLED_DIR}/bin/pkg-config)
		
        set(ENV{PATH} ";$ENV{PATH};${CURRENT_INSTALLED_DIR}/bin")
				
        vcpkg_execute_required_process(
            COMMAND ${CMAKE_COMMAND} -E env PYTHONUTF8=1
            ${PYTHON_EXECUTABLE} ${MESON} ${_vcm_OPTIONS} ${_vcm_OPTIONS_RELEASE} ${_vcm_SOURCE_PATH}
            WORKING_DIRECTORY ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel
            LOGNAME config-${TARGET_TRIPLET}-rel
        )
        message(STATUS "Configuring ${TARGET_TRIPLET}-rel done")
    endif()

    if(NOT DEFINED VCPKG_BUILD_TYPE STREQUAL "debug")
        # configure debug
        message(STATUS "Configuring ${TARGET_TRIPLET}-dbg")
        file(MAKE_DIRECTORY ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg)
        set(ENV{CFLAGS} "${MESON_COMMON_CFLAGS} ${MESON_DEBUG_CFLAGS}")
        set(ENV{CXXFLAGS} "${MESON_COMMON_CXXFLAGS} ${MESON_DEBUG_CXXFLAGS}")
        set(ENV{LDFLAGS} "${MESON_COMMON_LDFLAGS} ${MESON_DEBUG_LDFLAGS}")
        set(ENV{CPPFLAGS} "${MESON_COMMON_CPPFLAGS} ${MESON_DEBUG_CPPFLAGS}")
#        set(ENV{PATH} ";$ENV{PATH};${CURRENT_INSTALLED_DIR}/debug/bin")
        set(ENV{PKG_CONFIG_PATH} "${CURRENT_INSTALLED_DIR}/debug/lib/pkgconfig")
        set(ENV{PKG_CONFIG_DIR} "${CURRENT_INSTALLED_DIR}/debug/lib/pkgconfig")
#        set(PYTHON_EXECUTABLE ${CURRENT_INSTALLED_DIR}/debug/python3/python_d.exe)
        set(ENV{PYTHON_CMD} ${PYTHON3})

        set(ENV{PKG_CONFIG} ${CURRENT_INSTALLED_DIR}/debug/bin/pkg-config)
        set(ENV{PKGCONFIG_EXECUTABLE} ${CURRENT_INSTALLED_DIR}/debug/bin/pkg-config)
        set(ENV{PKG_CONFIG_EXECUTABLE} ${CURRENT_INSTALLED_DIR}/debug/bin/pkg-config)
		
        vcpkg_execute_required_process(
            COMMAND ${CMAKE_COMMAND} -E env PYTHONUTF8=1
            ${PYTHON_EXECUTABLE} ${MESON} ${_vcm_OPTIONS} ${_vcm_OPTIONS_DEBUG} ${_vcm_SOURCE_PATH}
            WORKING_DIRECTORY ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg
            LOGNAME config-${TARGET_TRIPLET}-dbg
        )
        message(STATUS "Configuring ${TARGET_TRIPLET}-dbg done")
    endif()
	
    include(FindPkgConfig)
	
endfunction()
