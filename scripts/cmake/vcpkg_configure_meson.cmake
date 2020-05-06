function(vcpkg_configure_meson)
    cmake_parse_arguments(_vcm "" "SOURCE_PATH" "OPTIONS;OPTIONS_DEBUG;OPTIONS_RELEASE" ${ARGN})
    
    file(REMOVE_RECURSE ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg)
	    
    if(CMAKE_HOST_WIN32)
        set(_SEP ";")
    else()
        set(_SEP ":")
    endif()
	
    find_program(GIT NAMES git git.cmd)	
    vcpkg_find_acquire_program(PYTHON3)
    vcpkg_find_acquire_program(MESON)
    vcpkg_find_acquire_program(NINJA)
    vcpkg_find_acquire_program(CMAKE)
	
    get_filename_component(NINJA_PATH ${NINJA} DIRECTORY)
    get_filename_component(GIT_EXE_PATH ${GIT} DIRECTORY)
    get_filename_component(CMAKE_EXE_PATH ${CMAKE} DIRECTORY)
    get_filename_component(PYTHON3_PATH ${PYTHON3} DIRECTORY)

    set(ENV{PATH} "${_SEP}$ENV{PATH}${_SEP}${NINJA_PATH}${_SEP}${GIT_EXE_PATH}${_SEP}${CMAKE_EXE_PATH}")

    set(ENV{PYTHONIOENCODING} UTF-8)
    set(ENV{PYTHONUTF8} 1)
    set(ENV{PYTHONLEGACYWINDOWSSTDIO} 1)

    set(CMAKE_FIND_LIBRARY_SUFFIXES .lib .dll.lib .dll .a)
    set(CMAKE_FIND_LIBRARY_PREFIXES bin lib)
	
	set(ENV{INCLUDE} "${CURRENT_INSTALLED_DIR}/include${_SEP}$ENV{INCLUDE}")
	
	list (APPEND CMAKE_MODULE_PATH ${CURRENT_PACKAGES_DIR}/debug/share/cmake)
	list (APPEND CMAKE_MODULE_PATH ${CURRENT_PACKAGES_DIR}/debug/share)
	
#    ## https://github.com/mesonbuild/meson/blob/master/mesonbuild/compilers/d.py
    # use the same compiler options as in vcpkg_configure_cmake
#    set(MESON_COMMON_CFLAGS "${MESON_COMMON_CFLAGS} /DWIN32 /D_WINDOWS /W3 /utf-8")
#    set(MESON_COMMON_CXXFLAGS "${MESON_COMMON_CXXFLAGS} /DWIN32 /D_WINDOWS /W3 /utf-8 /GR /EHsc")
    set(MESON_COMMON_CFLAGS "/I:${CURRENT_INSTALLED_DIR}/include ${MESON_COMMON_CFLAGS} /DWIN32 /D_WINDOWS /W4 ")
    set(MESON_COMMON_CXXFLAGS "/I:${CURRENT_INSTALLED_DIR}/include ${MESON_COMMON_CXXFLAGS} /DWIN32 /D_WINDOWS /W4 /GR /EHsc")
    set(MESON_COMMON_CPPFLAGS "/I:${CURRENT_INSTALLED_DIR}/include ${MESON_COMMON_CPPFLAGS} /DWIN32 /D_WINDOWS /W4 /GR /EHsc")
	
    if(DEFINED VCPKG_CRT_LINKAGE AND VCPKG_CRT_LINKAGE STREQUAL dynamic)
#        set(MESON_DEBUG_CFLAGS "${MESON_DEBUG_CFLAGS} /D_WINDLL /D_WINDOWS /D_USRDLL /D_DLL /D_DEBUG /MDd /Z7 /Ob0 /Od /RTC1")
		set(MESON_DEBUG_CFLAGS "/D_DEBUG /MDd /Z7 /Ob0 /Od /RTC1")
        set(MESON_DEBUG_CXXFLAGS "/D_DEBUG /MDd /Z7 /Ob0 /Od /RTC1")
		
        set(MESON_RELEASE_CFLAGS "/MD /O2 /Oi /Gy /DNDEBUG /Z7")
        set(MESON_RELEASE_CXXFLAGS "/MD /O2 /Oi /Gy /DNDEBUG /Z7")
        set(MESON_RELEASE_CPPFLAGS "/MD /O2 /Oi /Gy /DNDEBUG /Z7")

#        set(MESON_COMMON_LDFLAGS "${MESON_COMMON_LDFLAGS} /DEBUG")
        set(MESON_COMMON_LDFLAGS "/DEBUG /DEFAULTLIB:legacy_stdio_definitions.lib")
        set(MESON_RELEASE_LDFLAGS "/INCREMENTAL:NO /OPT:REF,NOICF /NODEFAULTLIB:LIBC;LIBCP;LIBCMT;LIBCPMT;LIBVCRUNTIME")
        set(MESON_DEBUG_LDFLAGS "/INCREMENTAL:NO /OPT:REF,NOICF /NODEFAULTLIB:LIBCD;LIBCPD;LIBCMTD;LIBCPMTD;LIBVCRUNTIME")

    elseif(DEFINED VCPKG_CRT_LINKAGE AND VCPKG_CRT_LINKAGE STREQUAL static)
        set(MESON_DEBUG_CFLAGS "${MESON_DEBUG_CFLAGS} /D_DEBUG /MTd /Z7 /Ob0 /Od /RTC1")
        set(MESON_DEBUG_CXXFLAGS "${MESON_DEBUG_CXXFLAGS} /D_DEBUG /MTd /Z7 /Ob0 /Od /RTC1")

        set(MESON_RELEASE_CFLAGS "${MESON_RELEASE_CFLAGS} /MT /O2 /Oi /Gy /DNDEBUG /Z7")
        set(MESON_RELEASE_CXXFLAGS "${MESON_RELEASE_CXXFLAGS} /MT /O2 /Oi /Gy /DNDEBUG /Z7")
        set(MESON_RELEASE_CPPFLAGS "${MESON_RELEASE_CPPFLAGS} /MT /O2 /Oi /Gy /DNDEBUG /Z7")

        set(MESON_COMMON_LDFLAGS /DEBUG)
        set(MESON_RELEASE_LDFLAGS "/INCREMENTAL:NO /OPT:REF,NOICF")
        set(MESON_DEBUG_LDFLAGS "/INCREMENTAL:NO /OPT:REF,NOICF")
    endif()
#--out-implib=
#-mscrtlib=
#        'none': ['-mscrtlib='],
#        'md': ['-mscrtlib=msvcrt'],
#        'mdd': ['-mscrtlib=msvcrtd'],
#        'mt': ['-mscrtlib=libcmt'],
#'mtd': ['-mscrtlib=libcmtd'],

    # select meson cmd-line subprojects
#    list(APPEND _vcm_SUBPROJECTS download)

#    if(VCPKG_LIBRARY_LINKAGE STREQUAL dynamic)
#        list(APPEND _vcm_OPTIONS --default-library=shared -Db_vscrt=from_buildtype -Db_staticpic=false )
#    else(VCPKG_LIBRARY_LINKAGE STREQUAL static)
#        list(APPEND _vcm_OPTIONS --default-library=static -Db_vscrt=from_buildtype -Db_staticpic=true )
#    endif()

# --subprojects=download
# --reconfigure

#    select meson cmd-line options ## --wrap-mode nodownload 
#    list(APPEND _vcm_OPTIONS --buildtype plain --backend ninja --wrap-mode nodownload)
#    -Db_vscrt=from_buildtype  -Db_staticpic=false  -Db_staticpic=true default_library=both
#    b_vscrt     | from_buildtype| none, md, mdd, mt, mtd, from_buildtype | VS runtime library

#-Dname_suffix=lib 
	
#    list(APPEND _vcm_OPTIONS -Dcmake_system_ignore_path="c:/windows")
#    list(APPEND _vcm_OPTIONS -Dcmake_module_path=${CMAKE_MODULE_PATH} ${CMAKE_CURRENT_LIST_DIR} ${CURRENT_INSTALLED_DIR}/share/${PORT} ${CURRENT_INSTALLED_DIR}/share/${NAME})
    # select meson cmd-line options
#    list(APPEND _vcm_OPTIONS -Dcmake_prefix_path=${CURRENT_INSTALLED_DIR} -Dcmake_module_path=${CURRENT_PACKAGES_DIR}/share,${CURRENT_PACKAGES_DIR}/share/cmake)
    list(APPEND _vcm_OPTIONS
        --buildtype=plain
#        -Dcmake_prefix_path=${CURRENT_INSTALLED_DIR}
        --wrap-mode nodownload
#        -Denable-introspection=no
#        -Dintrospection=disabled
#        -Ddisable_introspection=true
    )

    if(VCPKG_LIBRARY_LINKAGE STREQUAL dynamic)
        list(APPEND _vcm_OPTIONS -Ddefault_library=shared -Db_staticpic=false)
    else(VCPKG_LIBRARY_LINKAGE STREQUAL static)
        list(APPEND _vcm_OPTIONS --default-library static -Db_staticpic=true)
    endif()
#    ## --baselibs = -lm ## -- exec_prefix = ${prefix} bindir=${prefix}/bin datadir=${prefix}/share
    #-Db_vscrt=md
    #-Dpkg_config_path=${CURRENT_PACKAGES_DIR}/lib/pkgconfig,${CURRENT_PACKAGES_DIR}/share/pkgconfig
    #-Dcmake_module_path=${CURRENT_PACKAGES_DIR}/share,${CURRENT_PACKAGES_DIR}/share/cmake
    #-Dcmake_prefix_path=list,of,paths

    #
    list(APPEND _vcm_OPTIONS_DEBUG
        --buildtype=debug
        -Derrorlogs=true
        -Ddebug=true
        --prefix=${CURRENT_PACKAGES_DIR}/debug
        -Dcmake_prefix_path=${CURRENT_INSTALLED_DIR}/debug,${CURRENT_INSTALLED_DIR}/debug/share,${CURRENT_INSTALLED_DIR}/debug/share/cmake
        -Dpkg_config_path=${CURRENT_INSTALLED_DIR}/debug/lib/pkgconfig,${CURRENT_INSTALLED_DIR}/debug/share/pkgconfig
        -Dcmake_module_path=${CURRENT_PACKAGES_DIR}/debug/share,${CURRENT_PACKAGES_DIR}/debug/share/cmake
#        -Dlibpath=${CURRENT_INSTALLED_DIR}/debug/lib #Unknown options: "libpath"
#        -Dcpp_link_args=/LIBPATH:${CURRENT_INSTALLED_DIR}/debug/lib
#        -Dc_link_args=/LIBPATH:${CURRENT_INSTALLED_DIR}/debug/lib
#        --libexecdir=${CURRENT_PACKAGES_DIR}/debug/bin
#        --bindir=${CURRENT_PACKAGES_DIR}/debug/bin		
#        -Dc_args=/LIB:${CURRENT_INSTALLED_DIR}/debug/lib
#        -Dcpp_args=/LIB:${CURRENT_INSTALLED_DIR}/debug/lib
        -Denable-introspection=no
#        -Dintrospection=disabled
#        -Dintrospection=false
        -Ddisable_introspection=true
    )

    #-Db_vscrt=mt
    list(APPEND _vcm_OPTIONS_RELEASE
        --buildtype=release
        -Db_ndebug=true
        -Derrorlogs=true
        -Ddebug=true
        --prefix=${CURRENT_PACKAGES_DIR}
		-Dcmake_prefix_path=${CURRENT_INSTALLED_DIR},${CURRENT_INSTALLED_DIR}/share,${CURRENT_INSTALLED_DIR}/share/cmake
        -Dpkg_config_path=${CURRENT_INSTALLED_DIR}/lib/pkgconfig,${CURRENT_INSTALLED_DIR}/share/pkgconfig
		-Dcmake_module_path=${CURRENT_PACKAGES_DIR}/share,${CURRENT_PACKAGES_DIR}/share/cmake
#		-Dlibpath=${CURRENT_INSTALLED_DIR}/lib #Unknown options: "libpath"
#        -Dcpp_link_args=/LIBPATH:${CURRENT_INSTALLED_DIR}/lib
#        -Dc_link_args=/LIBPATH:${CURRENT_INSTALLED_DIR}/lib
#        -Dcmake_prefix_path=${CURRENT_INSTALLED_DIR}		
#        -Dc_args=\"/LIB:${CURRENT_INSTALLED_DIR}/lib\"
#        -Dcpp_args=\"/LIB:${CURRENT_INSTALLED_DIR}/lib\"
        -Denable-introspection=no
#        -Dintrospection=disabled
#        -Dintrospection=false
        -Ddisable_introspection=true
    )

#    set(ENV{PKG_CONFIG_DEBUG_SPEW} 1)
#    set(PKG_CONFIG_DEBUG_SPEW "1")
#    set(PKG_CONFIG_USE_CMAKE_PREFIX_PATH ON)
#    set(ENV{PKG_CONFIG_USE_CMAKE_PREFIX_PATH} ON)

#    set(CMAKE_MODULE_PATH "${_SEP}${CURRENT_INSTALLED_DIR}/share${_SEP}${CURRENT_INSTALLED_DIR}/lib/cmake${_SEP}${CURRENT_INSTALLED_DIR}/share/cmake${_SEP}${CMAKE_MODULE_PATH}")
#    set(ENV{CMAKE_MODULE_PATH} "${_SEP}${CURRENT_INSTALLED_DIR}/share${_SEP}${CURRENT_INSTALLED_DIR}/lib/cmake${_SEP}${CURRENT_INSTALLED_DIR}/share/cmake${_SEP}${CMAKE_MODULE_PATH}")

    set(CMAKE_ARGS
        -DNAME=${PACKAGE_NAME}
        -DCOMPILER_ID=GNU
        -DLANGUAGE=C
        -DMODE=LINK
        -DCMAKE_MODULE_PATH=${CMAKE_MODULE_PATH}
        -DCMAKE_PREFIX_PATH=${CURRENT_INSTALLED_DIR}
        ${${PACKAGE_NAME}_CMAKE_MODULE_PATH}
    )

#	set(ENV{PKG_CONFIG} "${CURRENT_INSTALLED_DIR}/bin/pkg-config")
#	set(ENV{PKGCONFIG_EXECUTABLE} "${CURRENT_INSTALLED_DIR}/bin/pkg-config")
#	set(ENV{PKG_CONFIG_EXECUTABLE} "${CURRENT_INSTALLED_DIR}/bin/pkg-config")

    set(GLIB_RELEASE ${CURRENT_INSTALLED_DIR}/bin)
    set(GLIB_DEBUG ${CURRENT_INSTALLED_DIR}/debug/bin)

#    wrap subprojects
#    if(NOT DEFINED VCPKG_BUILD_TYPE)
#        message(STATUS "Downloading subprojects ...")
#        vcpkg_execute_required_process(
#            COMMAND ${MESON} subprojects download
#            WORKING_DIRECTORY ${SOURCE_PATH}
#            LOGNAME subprojects-${TARGET_TRIPLET}
#        )
#        message(STATUS "Download subprojects for ${PORT} done")
#    endif()

    # PYTHONUTF8=1 python 3.6+ ## enables the interpreter’s UTF-8 mode
    ## pkg-config --variable pc_path pkg-config
    # configure release

#unset(ENV{GLIB_DEBUG})

if(NOT DEFINED VCPKG_BUILD_TYPE STREQUAL "Release" OR DEFINED VCPKG_BUILD_TYPE STREQUAL "Debug")
    
    file(MAKE_DIRECTORY ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel)

    set(CMAKE_IGNORE_PATH "${_SEP}${GLIB_DEBUG}${_SEP}${CURRENT_INSTALLED_DIR}/debug")
    set(CMAKE_SYSTEM_IGNORE_PATH "${_SEP}${GLIB_DEBUG}${_SEP}${CURRENT_INSTALLED_DIR}/debug/bin")

    set(ENV{CFLAGS} "${MESON_COMMON_CFLAGS} ${MESON_RELEASE_CFLAGS}")
    set(ENV{CXXFLAGS} "${MESON_COMMON_CXXFLAGS} ${MESON_RELEASE_CXXFLAGS}")
    set(ENV{LDFLAGS} "${MESON_COMMON_LDFLAGS} ${MESON_RELEASE_LDFLAGS}")
    set(ENV{CPPFLAGS} "${MESON_COMMON_CPPFLAGS} ${MESON_RELEASE_CPPFLAGS}")

#    set(ENV{PKG_CONFIG_PATH} "${CURRENT_INSTALLED_DIR}/lib/pkgconfig/${_SEP}${PKG_CONFIG_PATH}")
#    set(ENV{PKG_CONFIG_DIR} "${CURRENT_INSTALLED_DIR}/lib/pkgconfig/${_SEP}${PKG_CONFIG_PATH}")
#    set(ENV{PKG_CONFIG_PATH} "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig/${_SEP}${PKG_CONFIG_PATH}")

    set(GTK_DIR ${CURRENT_INSTALLED_DIR})
#    LIST(APPEND CMAKE_PROGRAM_PATH "$ENV{PATH}${_SEP}${GTK_DIR}/bin${_SEP}${GLIB_DIR}/bin;")
#    set(ENV{PATH} "${GLIB_RELEASE}${_SEP}$ENV{PATH}")
    set(ENV{PATH} "${GLIB_RELEASE}${_SEP}$ENV{PATH}")
#    string(REPLACE "${_SEP}$ENV{GLIB_DEBUG}${_SEP}" "${_SEP}${GLIB_RELEASE}${_SEP}$ENV{GLIB_DEBUG}" NEWPATH "$ENV{PATH}")
#    set(ENV{PATH} "${NEWPATH}")
#    vcpkg_add_to_path(PREPEND ${GLIB_RELEASE})

    set(ENV{LIB} "$ENV{LIB}${_SEP}${CURRENT_INSTALLED_DIR}/lib")
    set(ENV{LIBPATH} "$ENV{LIBPATH}${_SEP}${CURRENT_INSTALLED_DIR}/lib")

##    COMMAND ${CMAKE_COMMAND} -E env "PATH=C:/Some/Path${_SEP}$ENV{PATH}" <real_command> args...
    set(ENV{PKG_CONFIG} "${CURRENT_INSTALLED_DIR}/bin/pkg-config")
    set(ENV{PKGCONFIG_EXECUTABLE} "${PKG_CONFIG}")
    set(ENV{PKG_CONFIG_EXECUTABLE} "${PKG_CONFIG}")
    find_package(PkgConfig REQUIRED)
    include(FindPkgConfig)
    message(STATUS "Configuring ${TARGET_TRIPLET}-rel")
        vcpkg_execute_required_process(
#            COMMAND ${CMAKE_COMMAND} -E env "PYTHONUTF8=1" "PATH=${PATH} ${CURRENT_INSTALLED_DIR}/bin"
            COMMAND ${CMAKE_COMMAND} -E env "PYTHONUTF8=1"
            ${MESON} ${_vcm_OPTIONS} ${_vcm_OPTIONS_RELEASE} ${_vcm_SOURCE_PATH}
            WORKING_DIRECTORY ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel
            LOGNAME config-${TARGET_TRIPLET}-rel
        )
        message(STATUS "Configuring ${TARGET_TRIPLET}-rel done")
    endif()

    unset(ENV{GTK_DIR})

    if(NOT DEFINED VCPKG_BUILD_TYPE STREQUAL "Debug" OR DEFINED VCPKG_BUILD_TYPE STREQUAL "Release")
    # configure debug

    file(MAKE_DIRECTORY ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg)

    set(CMAKE_IGNORE_PATH "${_SEP}${GLIB_RELEASE}${_SEP}${CURRENT_INSTALLED_DIR}")
    set(CMAKE_SYSTEM_IGNORE_PATH "${_SEP}${GLIB_RELEASE}${_SEP}${CURRENT_INSTALLED_DIR}/bin")

    set(ENV{CFLAGS} "${MESON_COMMON_CFLAGS} ${MESON_DEBUG_CFLAGS}")
    set(ENV{CXXFLAGS} "${MESON_COMMON_CXXFLAGS} ${MESON_DEBUG_CXXFLAGS}")
    set(ENV{LDFLAGS} "${MESON_COMMON_LDFLAGS} ${MESON_DEBUG_LDFLAGS}")
    set(ENV{CPPFLAGS} "${MESON_COMMON_CPPFLAGS} ${MESON_DEBUG_CPPFLAGS}")

#    set(ENV{PATH} "${_SEP}$ENV{PATH}${_SEP}${CURRENT_INSTALLED_DIR}/debug/bin")
#    set(ENV{PKG_CONFIG_PATH} "${CURRENT_INSTALLED_DIR}/debug/lib/pkgconfig")
#    set(ENV{PKG_CONFIG_DIR} "${CURRENT_INSTALLED_DIR}/debug/lib/pkgconfig")

    set(GTK_DIR ${CURRENT_INSTALLED_DIR}/debug)
#    set(ENV{PATH} "$ENV{PATH}${_SEP}${GTK_DIR}/bin${_SEP}${GLIB_DIR}/bin;")
#    set(ENV{PATH} "${GLIB_DEBUG}${_SEP}$ENV{PATH}")
#    file(TO_NATIVE_PATH ENV_PATH "${GLIB_DEBUG}${_SEP}$ENV{PATH}")
    set(ENV{PATH} "${GLIB_DEBUG}${_SEP}$ENV{PATH}")
#    string(REPLACE "${_SEP}$ENV{GLIB_RELEASE}${_SEP}" "${_SEP}${GLIB_DEBUG}${_SEP}$ENV{GLIB_RELEASE}" NEWPATH "$ENV{PATH}")
#    set(ENV{PATH} "${NEWPATH}")
#    vcpkg_add_to_path(${GLIB_DEBUG})

    set(ENV{LIB} "$ENV{LIB}${_SEP}${CURRENT_INSTALLED_DIR}/debug/lib")
    set(ENV{LIBPATH} "$ENV{LIBPATH}${_SEP}${CURRENT_INSTALLED_DIR}/debug/lib")

    set(ENV{PKG_CONFIG} "${CURRENT_INSTALLED_DIR}/debug/bin/pkg-config")
    set(ENV{PKGCONFIG_EXECUTABLE} "${PKG_CONFIG}")
    set(ENV{PKG_CONFIG_EXECUTABLE} "${PKG_CONFIG}")
    find_package(PkgConfig REQUIRED)	
    include(FindPkgConfig)
    message(STATUS "Configuring ${TARGET_TRIPLET}-dbg")
        vcpkg_execute_required_process(
#            COMMAND ${CMAKE_COMMAND} -E env PYTHONUTF8=1 PATH="${CURRENT_INSTALLED_DIR}/debug/bin":"${PATH}"
            COMMAND ${CMAKE_COMMAND} -E env "PYTHONUTF8=1"
            ${MESON} ${_vcm_OPTIONS} ${_vcm_OPTIONS_DEBUG} ${_vcm_SOURCE_PATH}
            WORKING_DIRECTORY ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg
            LOGNAME config-${TARGET_TRIPLET}-dbg
        )
        message(STATUS "Configuring ${TARGET_TRIPLET}-dbg done")
    endif()

    unset(ENV{GLIB_RELEASE})
    unset(ENV{GLIB_DEBUG})
    unset(ENV{GTK_DIR})

#foreach(PATH_ITEM ${ENV_PATH_LIST})
#    set(PATH_SEPARATOR ":")
#    if(WIN32)
#        set(PATH_SEPARATOR ";")
#        string(REPLACE "/" "\\" PATH_ITEM ${PATH_ITEM})
#    endif()
#    set(ENV{PATH} "${PATH_ITEM}bin${PATH_SEPARATOR}$ENV{PATH}")
#endforeach()
#string(REPLACE "C;" "" LIBwithoutC "${LIB}")

endfunction()
