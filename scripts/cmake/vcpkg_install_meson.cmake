function(vcpkg_install_meson)

# MESON_SOURCE_ROOT, MESON_BUILD_ROOT, MESON_INSTALL_PREFIX, MESON_INSTALL_DESTDIR_PREFIX, and MESONINTROSPECT

    if(CMAKE_HOST_WIN32)
        set(_SEP ";")
    else()
        set(_SEP ":")
    endif()
	
#    set(ENV{VCPKG_FORCE_SYSTEM_BINARIES} 1)
    unset(ENV{DESTDIR}) # installation directory was already specified with '--prefix' option
    set(ENV{MESON_INSTALL_PREFIX} ${CURRENT_PACKAGES_DIR})
#    set(ENV{MESON_INSTALL_DESTDIR_PREFIX} ${CURRENT_PACKAGES_DIR})
	
    find_program(GIT NAMES git git.cmd)	
    vcpkg_find_acquire_program(PYTHON3)
    vcpkg_find_acquire_program(MESON)
    vcpkg_find_acquire_program(NINJA)
    vcpkg_find_acquire_program(CMAKE)
	
    get_filename_component(NINJA_PATH ${NINJA} DIRECTORY)
    get_filename_component(GIT_PATH ${GIT} DIRECTORY)
    get_filename_component(CMAKE_PATH ${CMAKE} DIRECTORY)
    get_filename_component(PYTHON3_PATH ${PYTHON3} DIRECTORY)

    set(ENV{PATH} "${_SEP}$ENV{PATH}${_SEP}${NINJA_PATH}${_SEP}${GIT_PATH}${_SEP}${CMAKE_PATH}")

    set(ENV{PYTHONIOENCODING} UTF-8)
    set(ENV{PYTHONUTF8} 1)
    set(ENV{PYTHONLEGACYWINDOWSSTDIO} 1)

    set(CMAKE_FIND_LIBRARY_SUFFIXES .lib .dll.lib .dll .a)
    set(CMAKE_FIND_LIBRARY_PREFIXES bin lib)
	
    set(ENV{INCLUDE} "${CURRENT_INSTALLED_DIR}/include${_SEP}$ENV{INCLUDE}")
	
	set(GLIB_RELEASE ${CURRENT_INSTALLED_DIR}/bin)
    set(GLIB_DEBUG ${CURRENT_INSTALLED_DIR}/debug/bin)
	
###if(NOT DEFINED CURRENT_BUILDTREES_DIR OR NOT EXISTS ${CURRENT_BUILDTREES_DIR})

if(NOT DEFINED VCPKG_BUILD_TYPE STREQUAL "Release" OR DEFINED VCPKG_BUILD_TYPE STREQUAL "Debug")
    set(CMAKE_IGNORE_PATH "${_SEP}${GLIB_DEBUG}${_SEP}${CURRENT_INSTALLED_DIR}/debug")
    set(CMAKE_SYSTEM_IGNORE_PATH "${_SEP}${GLIB_DEBUG}${_SEP}${CURRENT_INSTALLED_DIR}/debug/bin")
#	set(GLIB_DIR ${CURRENT_INSTALLED_DIR})
#	set(GTK_DIR ${CURRENT_INSTALLED_DIR})
	set(GTK_RELEASE ${CURRENT_INSTALLED_DIR}/bin)
#	set(ENV{PATH} "$ENV{PATH}${_SEP}${GTK_DIR}/bin${_SEP}${GLIB_DIR}/bin;")
	set(ENV{PATH} "${GTK_RELEASE}${_SEP}$ENV{PATH}")
#	string(REPLACE "${_SEP}$ENV{GLIB_DEBUG}${_SEP}" "${_SEP}${GLIB_RELEASE}${_SEP}$ENV{GLIB_DEBUG}" NEWPATH "$ENV{PATH}")
#	set(ENV{PATH} "${NEWPATH}")
#	vcpkg_add_to_path(PREPEND ${GLIB_RELEASE})

	set(ENV{LIB} "${_SEP}$ENV{LIB}${_SEP}${CURRENT_INSTALLED_DIR}/lib")
	set(ENV{LIBPATH} "${_SEP}$ENV{LIBPATH}${_SEP}${CURRENT_INSTALLED_DIR}/lib")

    message(STATUS "Package ${TARGET_TRIPLET}-rel")

#    if(NOT EXISTS ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel)
    vcpkg_execute_required_process(
#    execute_process(
#        COMMAND ${NINJA} install -v
        COMMAND ${MESON} install
        WORKING_DIRECTORY ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel
        LOGNAME package-${TARGET_TRIPLET}-rel
#        ERROR_FILE ${CURRENT_BUILDTREES_DIR}/error-${TARGET_TRIPLET}-rel.txt
#        RESULT_VARIABLE error_code
    )
#    endif()

#    endif()
endif()

	unset(ENV{GTK_RELEASE})
	
if(NOT DEFINED VCPKG_BUILD_TYPE STREQUAL "Debug" OR DEFINED VCPKG_BUILD_TYPE STREQUAL "Release")
    set(CMAKE_IGNORE_PATH "${_SEP}${GLIB_RELEASE}${_SEP}${CURRENT_INSTALLED_DIR}")
    set(CMAKE_SYSTEM_IGNORE_PATH "${_SEP}${GLIB_RELEASE}${_SEP}${CURRENT_INSTALLED_DIR}/bin")
#	set(GLIB_DIR ${CURRENT_INSTALLED_DIR}/debug)
#	set(GTK_DIR ${CURRENT_INSTALLED_DIR}/debug)
	set(GTK_DEBUG ${CURRENT_INSTALLED_DIR}/debug/bin)
#	set(ENV{PATH} "$ENV{PATH}${_SEP}${GTK_DIR}/debug/bin${_SEP}${GLIB_DIR}/debug/bin;")
	set(ENV{PATH} "${GTK_DEBUG}${_SEP}$ENV{PATH}")
#	string(REPLACE "${_SEP}$ENV{GLIB_RELEASE}${_SEP}" "${_SEP}${GLIB_DEBUG}${_SEP}$ENV{GLIB_RELEASE}" NEWPATH "$ENV{PATH}")
#	set(ENV{PATH} "${NEWPATH}")

	set(ENV{LIB} "${_SEP}${CURRENT_INSTALLED_DIR}/debug/lib${_SEP}$ENV{LIB}")
	set(ENV{LIBPATH} "${CURRENT_INSTALLED_DIR}/debug/lib${_SEP}$ENV{LIBPATH}${_SEP}")

    message(STATUS "Package ${TARGET_TRIPLET}-dbg")
#    if(NOT EXISTS ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg)
    vcpkg_execute_required_process(
#    execute_process(
#        COMMAND ${NINJA} install -v
        COMMAND ${MESON} install
        WORKING_DIRECTORY ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg
        LOGNAME package-${TARGET_TRIPLET}-dbg
#        ERROR_FILE ${CURRENT_BUILDTREES_DIR}/error-${TARGET_TRIPLET}-dbg.txt
#        RESULT_VARIABLE error_code
    )
endif()

	unset(ENV{GTK_RELEASE})
	unset(ENV{GTK_DEBUG})


endfunction()
