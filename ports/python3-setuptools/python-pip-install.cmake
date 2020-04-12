function(python_pip_install)
    cmake_parse_arguments(_ppi "" "SOURCE_PATH" "" ${ARGN})
	
    if(CMAKE_HOST_WIN32)
        set(_SEP ";")
    else()
        set(_SEP ":")
    endif()

    set(PYTHON_EXECUTABLE ${CURRENT_INSTALLED_DIR}/python3/python.exe)
    set(PYTHON_DEBUG_EXECUTABLE ${CURRENT_INSTALLED_DIR}/debug/python3/python_d.exe)

    if(NOT DEFINED _ppi_SOURCE_PATH)
        message(FATAL_ERROR "SOURCE_PATH is a required argument to python3-pip-install.")
    endif()
    
    # prepend semicolon
    if(DEFINED VCPKG_PYTHON_INCLUDE_DIRS)
        set(VCPKG_PYTHON_INCLUDE_DIRS "\;" ${VCPKG_PYTHON_INCLUDE_DIRS})
    endif()
    if(DEFINED VCPKG_PYTHON_DEBUG_LIBS)
        set(VCPKG_PYTHON_DEBUG_LIBS "\;" ${VCPKG_PYTHON_DEBUG_LIBS})
    endif()
    if(DEFINED VCPKG_PYTHON_LIBS)
        set(VCPKG_PYTHON_LIBS "\;" ${VCPKG_PYTHON_LIBS})
    endif()
	
    set(GLIB_RELEASE ${CURRENT_INSTALLED_DIR}/bin)
    set(GLIB_DEBUG ${CURRENT_INSTALLED_DIR}/debug/bin)

  if(NOT DEFINED VCPKG_BUILD_TYPE STREQUAL "Debug" OR DEFINED VCPKG_BUILD_TYPE STREQUAL "Release")

#    message(STATUS "Installing python module for Debug..")
#    configure_file(${CURRENT_INSTALLED_DIR}/share/python3-setuptools/distutils-dbg.cfg.in
#        ${CURRENT_INSTALLED_DIR}/debug/python3/Lib/distutils/distutils.cfg)
#    file(REMOVE ${CURRENT_BUILDTREES_DIR}/pip-install-${TARGET_TRIPLET}-dbg-detailed.log)
#    vcpkg_execute_required_process(
#        COMMAND ${PYTHON_DEBUG_EXECUTABLE} -m pip install .
#            --prefix ${CURRENT_PACKAGES_DIR}/debug/python3
#            --log "${CURRENT_BUILDTREES_DIR}/pip-install-${TARGET_TRIPLET}-dbg-detailed.log"
#            --no-warn-script-location
#            --no-warn-conflicts
#            --force-reinstall
#            --ignore-installed --compile --no-deps #-e
#        WORKING_DIRECTORY ${_ppi_SOURCE_PATH}
#        LOGNAME pip-install-${TARGET_TRIPLET}-dbg
#    )
#    file(REMOVE ${CURRENT_INSTALLED_DIR}/debug/python3/Lib/distutils/distutils.cfg)
#    message(STATUS "Installing python module for Debug.. OK")

  endif()

  if(NOT DEFINED VCPKG_BUILD_TYPE STREQUAL "Release" OR DEFINED VCPKG_BUILD_TYPE STREQUAL "Debug")
  
    set(GTK_DIR ${CURRENT_INSTALLED_DIR})
    set(ENV{PATH} "${GLIB_RELEASE}${_SEP}$ENV{PATH}")

    set(ENV{PKG_CONFIG} "${CURRENT_INSTALLED_DIR}/bin/pkg-config")
    set(ENV{PKGCONFIG_EXECUTABLE} "${PKG_CONFIG}")
    set(ENV{PKG_CONFIG_EXECUTABLE} "${PKG_CONFIG}")
    find_package(PkgConfig REQUIRED)
    include(FindPkgConfig)
	
    set(ENV{PKG_CONFIG_PATH} "${CURRENT_INSTALLED_DIR}/lib/pkgconfig/${_SEP}${PKG_CONFIG_PATH}")
	
    message(STATUS "Installing python module for Release..")
    configure_file(${CURRENT_INSTALLED_DIR}/share/python3-setuptools/distutils-rel.cfg.in
        ${CURRENT_INSTALLED_DIR}/python3/Lib/distutils/distutils.cfg)
    file(REMOVE ${CURRENT_BUILDTREES_DIR}/pip-install-${TARGET_TRIPLET}-rel-detailed.log)

    vcpkg_execute_required_process(
        COMMAND ${PYTHON_EXECUTABLE} -m pip install .
            --prefix ${CURRENT_PACKAGES_DIR}/python3
            --log "${CURRENT_BUILDTREES_DIR}/pip-install-${TARGET_TRIPLET}-rel-detailed.log"
            --no-warn-script-location
            --no-warn-conflicts
            --force-reinstall
            --ignore-installed --compile --no-deps
        WORKING_DIRECTORY ${_ppi_SOURCE_PATH}
        LOGNAME pip-install-${TARGET_TRIPLET}-rel
    )
    message(STATUS "Installing python module for Release.. OK")
	
    file(REMOVE ${CURRENT_INSTALLED_DIR}/python3/Lib/distutils/distutils.cfg)

  endif()

    set(VCPKG_POLICY_EMPTY_PACKAGE enabled PARENT_SCOPE)
endfunction()
