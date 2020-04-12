<<<<<<< HEAD
# Mark variables as used so cmake doesn't complain about them
mark_as_advanced(CMAKE_TOOLCHAIN_FILE)

# This is a backport of CMAKE_TRY_COMPILE_PLATFORM_VARIABLES to cmake 3.0
get_property( _CMAKE_IN_TRY_COMPILE GLOBAL PROPERTY IN_TRY_COMPILE )
if( _CMAKE_IN_TRY_COMPILE )
    include( "${CMAKE_CURRENT_SOURCE_DIR}/../vcpkg.config.cmake" OPTIONAL )
endif()

if(VCPKG_CHAINLOAD_TOOLCHAIN_FILE)
    include("${VCPKG_CHAINLOAD_TOOLCHAIN_FILE}")
endif()

if(VCPKG_TOOLCHAIN)
    return()
endif()

if(NOT DEFINED CMAKE_BUILD_TYPE) 
#If the build type is not defined we are generating with a multi config generator
#Thus we should map common configurations correctly (If they have not been set)
    message(STATUS "Multi configuration generator detected mapping MinSizeRel and RelWithDebInfo to Release")
    if(NOT DEFINED CMAKE_MAP_IMPORTED_CONFIG_MINSIZEREL)
        set(CMAKE_MAP_IMPORTED_CONFIG_MINSIZEREL Release)
    endif()
    if(NOT DEFINED CMAKE_MAP_IMPORTED_CONFIG_RELWITHDEBINFO)
        set(CMAKE_MAP_IMPORTED_CONFIG_RELWITHDEBINFO Release)
    endif()
endif()

if(VCPKG_TARGET_TRIPLET)
elseif(CMAKE_GENERATOR_PLATFORM MATCHES "^[Ww][Ii][Nn]32$")
    set(_VCPKG_TARGET_TRIPLET_ARCH x86)
elseif(CMAKE_GENERATOR_PLATFORM MATCHES "^[Xx]64$")
    set(_VCPKG_TARGET_TRIPLET_ARCH x64)
elseif(CMAKE_GENERATOR_PLATFORM MATCHES "^[Aa][Rr][Mm]$")
    set(_VCPKG_TARGET_TRIPLET_ARCH arm)
elseif(CMAKE_GENERATOR_PLATFORM MATCHES "^[Aa][Rr][Mm]64$")
    set(_VCPKG_TARGET_TRIPLET_ARCH arm64)
else()
    if(CMAKE_GENERATOR MATCHES "^Visual Studio 14 2015 Win64$")
        set(_VCPKG_TARGET_TRIPLET_ARCH x64)
    elseif(CMAKE_GENERATOR MATCHES "^Visual Studio 14 2015 ARM$")
        set(_VCPKG_TARGET_TRIPLET_ARCH arm)
    elseif(CMAKE_GENERATOR MATCHES "^Visual Studio 14 2015$")
        set(_VCPKG_TARGET_TRIPLET_ARCH x86)
    elseif(CMAKE_GENERATOR MATCHES "^Visual Studio 15 2017 Win64$")
        set(_VCPKG_TARGET_TRIPLET_ARCH x64)
    elseif(CMAKE_GENERATOR MATCHES "^Visual Studio 15 2017 ARM$")
        set(_VCPKG_TARGET_TRIPLET_ARCH arm)
    elseif(CMAKE_GENERATOR MATCHES "^Visual Studio 15 2017$")
        set(_VCPKG_TARGET_TRIPLET_ARCH x86)
    elseif(CMAKE_GENERATOR MATCHES "^Visual Studio 16 2019$")
        if(CMAKE_HOST_SYSTEM_PROCESSOR MATCHES "^[Xx]86$")
            set(_VCPKG_TARGET_TRIPLET_ARCH x86)
        elseif(CMAKE_HOST_SYSTEM_PROCESSOR MATCHES "^[Aa][Mm][Dd]64$")
            set(_VCPKG_TARGET_TRIPLET_ARCH x64)
        elseif(CMAKE_HOST_SYSTEM_PROCESSOR MATCHES "^[Aa][Rr][Mm]$")
            set(_VCPKG_TARGET_TRIPLET_ARCH arm)
        elseif(CMAKE_HOST_SYSTEM_PROCESSOR MATCHES "^[Aa][Rr][Mm]64$")
            set(_VCPKG_TARGET_TRIPLET_ARCH arm64)
        else()

        endif()
    else()
        find_program(_VCPKG_CL cl)
        if(_VCPKG_CL MATCHES "amd64/cl.exe$" OR _VCPKG_CL MATCHES "x64/cl.exe$")
            set(_VCPKG_TARGET_TRIPLET_ARCH x64)
        elseif(_VCPKG_CL MATCHES "arm/cl.exe$")
            set(_VCPKG_TARGET_TRIPLET_ARCH arm)
        elseif(_VCPKG_CL MATCHES "arm64/cl.exe$")
            set(_VCPKG_TARGET_TRIPLET_ARCH arm64)
        elseif(_VCPKG_CL MATCHES "bin/cl.exe$" OR _VCPKG_CL MATCHES "x86/cl.exe$")
            set(_VCPKG_TARGET_TRIPLET_ARCH x86)
        elseif(CMAKE_HOST_SYSTEM_PROCESSOR STREQUAL "x86_64")
            set(_VCPKG_TARGET_TRIPLET_ARCH x64)
        else()
            if( _CMAKE_IN_TRY_COMPILE )
                message(STATUS "Unable to determine target architecture, continuing without vcpkg.")
            else()
                message(WARNING "Unable to determine target architecture, continuing without vcpkg.")
            endif()
            set(VCPKG_TOOLCHAIN ON)
            return()
        endif()
    endif()
endif()

if(CMAKE_SYSTEM_NAME STREQUAL "WindowsStore" OR CMAKE_SYSTEM_NAME STREQUAL "WindowsPhone")
    set(_VCPKG_TARGET_TRIPLET_PLAT uwp)
elseif(CMAKE_SYSTEM_NAME STREQUAL "Linux" OR (NOT CMAKE_SYSTEM_NAME AND CMAKE_HOST_SYSTEM_NAME STREQUAL "Linux"))
    set(_VCPKG_TARGET_TRIPLET_PLAT linux)
elseif(CMAKE_SYSTEM_NAME STREQUAL "Darwin" OR (NOT CMAKE_SYSTEM_NAME AND CMAKE_HOST_SYSTEM_NAME STREQUAL "Darwin"))
    set(_VCPKG_TARGET_TRIPLET_PLAT osx)
elseif(CMAKE_SYSTEM_NAME STREQUAL "Windows" OR (NOT CMAKE_SYSTEM_NAME AND CMAKE_HOST_SYSTEM_NAME STREQUAL "Windows"))
    set(_VCPKG_TARGET_TRIPLET_PLAT windows)
elseif(CMAKE_SYSTEM_NAME STREQUAL "FreeBSD" OR (NOT CMAKE_SYSTEM_NAME AND CMAKE_HOST_SYSTEM_NAME STREQUAL "FreeBSD"))
    set(_VCPKG_TARGET_TRIPLET_PLAT freebsd)
endif()

set(VCPKG_TARGET_TRIPLET ${_VCPKG_TARGET_TRIPLET_ARCH}-${_VCPKG_TARGET_TRIPLET_PLAT} CACHE STRING "Vcpkg target triplet (ex. x86-windows)")
set(_VCPKG_TOOLCHAIN_DIR ${CMAKE_CURRENT_LIST_DIR})

if(NOT DEFINED _VCPKG_ROOT_DIR)
    # Detect .vcpkg-root to figure VCPKG_ROOT_DIR
    set(_VCPKG_ROOT_DIR_CANDIDATE ${CMAKE_CURRENT_LIST_DIR})
    while(IS_DIRECTORY ${_VCPKG_ROOT_DIR_CANDIDATE} AND NOT EXISTS "${_VCPKG_ROOT_DIR_CANDIDATE}/.vcpkg-root")
        get_filename_component(_VCPKG_ROOT_DIR_TEMP ${_VCPKG_ROOT_DIR_CANDIDATE} DIRECTORY)
        if (_VCPKG_ROOT_DIR_TEMP STREQUAL _VCPKG_ROOT_DIR_CANDIDATE) # If unchanged, we have reached the root of the drive
            message(FATAL_ERROR "Could not find .vcpkg-root")
        else()
            SET(_VCPKG_ROOT_DIR_CANDIDATE ${_VCPKG_ROOT_DIR_TEMP})
        endif()
    endwhile()
    set(_VCPKG_ROOT_DIR ${_VCPKG_ROOT_DIR_CANDIDATE} CACHE INTERNAL "Vcpkg root directory")
endif()
set(_VCPKG_INSTALLED_DIR ${_VCPKG_ROOT_DIR}/installed)

if(NOT EXISTS "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}" AND NOT _CMAKE_IN_TRY_COMPILE)
    message(WARNING "There are no libraries installed for the Vcpkg triplet ${VCPKG_TARGET_TRIPLET}.")
endif()

if(CMAKE_BUILD_TYPE MATCHES "^Debug$" OR NOT DEFINED CMAKE_BUILD_TYPE) #Debug build: Put Debug paths before Release paths.
    list(APPEND CMAKE_PREFIX_PATH
        ${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/debug ${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}
    )
    list(APPEND CMAKE_LIBRARY_PATH
        ${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/debug/lib/manual-link ${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/lib/manual-link
    )
    list(APPEND CMAKE_FIND_ROOT_PATH
        ${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/debug ${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}
    )
else() #Release build: Put Release paths before Debug paths. Debug Paths are required so that CMake generates correct info in autogenerated target files.
    list(APPEND CMAKE_PREFIX_PATH
        ${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET} ${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/debug
    )
    list(APPEND CMAKE_LIBRARY_PATH
        ${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/lib/manual-link ${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/debug/lib/manual-link
    )
    list(APPEND CMAKE_FIND_ROOT_PATH
        ${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET} ${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/debug
    )
endif()

file(TO_CMAKE_PATH "$ENV{PROGRAMFILES}" _programfiles)
set(_PROGRAMFILESX86 "PROGRAMFILES(x86)")
file(TO_CMAKE_PATH "$ENV{${_PROGRAMFILESX86}}" _programfiles_x86)
set(CMAKE_SYSTEM_IGNORE_PATH
    "${_programfiles}/OpenSSL"
    "${_programfiles}/OpenSSL-Win32"
    "${_programfiles}/OpenSSL-Win64"
    "${_programfiles}/OpenSSL-Win32/lib/VC"
    "${_programfiles}/OpenSSL-Win64/lib/VC"
    "${_programfiles}/OpenSSL-Win32/lib/VC/static"
    "${_programfiles}/OpenSSL-Win64/lib/VC/static"
#From Neumann-A: Can those absolute paths be removed?
    "${_programfiles_x86}/OpenSSL"
    "${_programfiles_x86}/OpenSSL-Win32"
    "${_programfiles_x86}/OpenSSL-Win64"
    "${_programfiles_x86}/OpenSSL-Win32/lib/VC"
    "${_programfiles_x86}/OpenSSL-Win64/lib/VC"
    "${_programfiles_x86}/OpenSSL-Win32/lib/VC/static"
    "${_programfiles_x86}/OpenSSL-Win64/lib/VC/static"
    "C:/OpenSSL/"
    "C:/OpenSSL-Win32/"
    "C:/OpenSSL-Win64/"
    "C:/OpenSSL-Win32/lib/VC"
    "C:/OpenSSL-Win64/lib/VC"
    "C:/OpenSSL-Win32/lib/VC/static"
    "C:/OpenSSL-Win64/lib/VC/static"
)

list(APPEND CMAKE_PROGRAM_PATH ${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/tools)
file(GLOB _VCPKG_TOOLS_DIRS ${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/tools/*)
foreach(_VCPKG_TOOLS_DIR ${_VCPKG_TOOLS_DIRS})
    if(IS_DIRECTORY ${_VCPKG_TOOLS_DIR})
        list(APPEND CMAKE_PROGRAM_PATH ${_VCPKG_TOOLS_DIR})
    endif()
endforeach()

option(VCPKG_APPLOCAL_DEPS "Automatically copy dependencies into the output directory for executables." ON)
function(add_executable name)
    _add_executable(${ARGV})
    list(FIND ARGV "IMPORTED" IMPORTED_IDX)
    list(FIND ARGV "ALIAS" ALIAS_IDX)
    if(IMPORTED_IDX EQUAL -1 AND ALIAS_IDX EQUAL -1)
        if(VCPKG_APPLOCAL_DEPS AND _VCPKG_TARGET_TRIPLET_PLAT MATCHES "windows|uwp")
            add_custom_command(TARGET ${name} POST_BUILD
                COMMAND powershell -noprofile -executionpolicy Bypass -file ${_VCPKG_TOOLCHAIN_DIR}/msbuild/applocal.ps1
                    -targetBinary $<TARGET_FILE:${name}>
                    -installedDir "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}$<$<CONFIG:Debug>:/debug>/bin"
                    -OutVariable out
            )
        endif()
        set_target_properties(${name} PROPERTIES VS_USER_PROPS do_not_import_user.props)
        set_target_properties(${name} PROPERTIES VS_GLOBAL_VcpkgEnabled false)
    endif()
endfunction()

function(add_library name)
    _add_library(${ARGV})
    list(FIND ARGV "IMPORTED" IMPORTED_IDX)
    list(FIND ARGV "INTERFACE" INTERFACE_IDX)
    list(FIND ARGV "ALIAS" ALIAS_IDX)
    if(IMPORTED_IDX EQUAL -1 AND INTERFACE_IDX EQUAL -1 AND ALIAS_IDX EQUAL -1)
        get_target_property(IS_LIBRARY_SHARED ${name} TYPE)
        if(VCPKG_APPLOCAL_DEPS AND _VCPKG_TARGET_TRIPLET_PLAT MATCHES "windows|uwp" AND (IS_LIBRARY_SHARED STREQUAL "SHARED_LIBRARY" OR IS_LIBRARY_SHARED STREQUAL "MODULE_LIBRARY"))
            add_custom_command(TARGET ${name} POST_BUILD
                COMMAND powershell -noprofile -executionpolicy Bypass -file ${_VCPKG_TOOLCHAIN_DIR}/msbuild/applocal.ps1
                    -targetBinary $<TARGET_FILE:${name}>
                    -installedDir "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}$<$<CONFIG:Debug>:/debug>/bin"
                    -OutVariable out
            )
        endif()
        set_target_properties(${name} PROPERTIES VS_USER_PROPS do_not_import_user.props)
        set_target_properties(${name} PROPERTIES VS_GLOBAL_VcpkgEnabled false)
    endif()
endfunction()

macro(find_package name)
    string(TOLOWER "${name}" _vcpkg_lowercase_name)
    string(TOUPPER "${name}" _vcpkg_uppercase_name)
    if(EXISTS "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/share/${_vcpkg_lowercase_name}/vcpkg-cmake-wrapper.cmake")
        set(ARGS "${ARGV}")
        include(${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/share/${_vcpkg_lowercase_name}/vcpkg-cmake-wrapper.cmake)
    elseif("${name}" STREQUAL "Boost" AND EXISTS "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/include/boost")
        # Checking for the boost headers disables this wrapper unless the user has installed at least one boost library
        set(Boost_USE_STATIC_LIBS OFF)
        set(Boost_USE_MULTITHREADED ON)
        unset(Boost_USE_STATIC_RUNTIME)
        set(Boost_NO_BOOST_CMAKE ON)
        unset(Boost_USE_STATIC_RUNTIME CACHE)
        set(Boost_COMPILER "-vc140")
        _find_package(${ARGV})
    elseif("${name}" STREQUAL "ICU" AND EXISTS "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/include/unicode/utf.h")
        function(_vcpkg_find_in_list)
            list(FIND ARGV "COMPONENTS" COMPONENTS_IDX)
            set(COMPONENTS_IDX ${COMPONENTS_IDX} PARENT_SCOPE)
        endfunction()
        _vcpkg_find_in_list(${ARGV})
        if(NOT COMPONENTS_IDX EQUAL -1)
            _find_package(${ARGV} COMPONENTS data)
        else()
            _find_package(${ARGV})
        endif()
    # elseif("${name}" STREQUAL "GSL" AND EXISTS "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/include/gsl")
        # _find_package(${ARGV})
        # if(GSL_FOUND AND TARGET GSL::gsl)
            # set_property( TARGET GSL::gslcblas APPEND PROPERTY IMPORTED_CONFIGURATIONS Release )
            # set_property( TARGET GSL::gsl APPEND PROPERTY IMPORTED_CONFIGURATIONS Release )
            # if( EXISTS "${GSL_LIBRARY_DEBUG}" AND EXISTS "${GSL_CBLAS_LIBRARY_DEBUG}")
            # set_property( TARGET GSL::gsl APPEND PROPERTY IMPORTED_CONFIGURATIONS Debug )
            # set_target_properties( GSL::gsl PROPERTIES IMPORTED_LOCATION_DEBUG "${GSL_LIBRARY_DEBUG}" )
                # set_property( TARGET GSL::gslcblas APPEND PROPERTY IMPORTED_CONFIGURATIONS Debug )
                # set_target_properties( GSL::gslcblas PROPERTIES IMPORTED_LOCATION_DEBUG "${GSL_CBLAS_LIBRARY_DEBUG}" )
            # endif()
        # endif()
    # elseif("${name}" STREQUAL "CURL" AND EXISTS "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/include/curl")
        # _find_package(${ARGV})
        # if(CURL_FOUND)
            # if(EXISTS "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/lib/nghttp2.lib")
                # list(APPEND CURL_LIBRARIES
                    # "debug" "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/debug/lib/nghttp2.lib"
                    # "optimized" "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/lib/nghttp2.lib")
            # endif()
        # endif()
    elseif("${_vcpkg_lowercase_name}" STREQUAL "grpc" AND EXISTS "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/share/grpc")
        _find_package(gRPC ${ARGN})
    else()
        # If package does not define targets and only uses old school variables we have to fix the paths to the libraries since
        # find_package will only find the debug libraries or only find the release libraries if the name of the library was 
        # changed for debug builds. 
        _find_package(${ARGV})

        cmake_policy(PUSH)
        cmake_policy(SET CMP0054 NEW)

        get_cmake_property(_pkg_all_vars VARIABLES)

        #General find_package debug info. Show all defined package variables to examine if they are set wrong
        set(_pkg_names_rgx "(${name}|${_vcpkg_uppercase_name}|${_vcpkg_lowercase_name})")
        #Need to escape special regex characters
        STRING(REPLACE "+" "\\+" _pkg_names_rgx "${_pkg_names_rgx}")
        STRING(REPLACE "*" "\\*" _pkg_names_rgx "${_pkg_names_rgx}")
        set(_pkg_filter_rgx "^(${_pkg_names_rgx})([^_]*_)+")
        list(FILTER _pkg_all_vars INCLUDE REGEX ${_pkg_filter_rgx})
        message(STATUS "VCPKG-all-package-defined-vars: ${_pkg_all_vars}")
        foreach(_pkg_var ${_pkg_all_vars})
            message(STATUS "VCPKG-find_package value of ${_pkg_var}: ${${_pkg_var}}")
        endforeach()
        
        #Fixing Libraries paths.
        set(_pkg_filter_rgx "^(${_pkg_names_rgx})([^_]*_)+(LIBRAR|LIBS)")

        #Filtering for variables which are probably library variables for the package.
        list(FILTER _pkg_all_vars INCLUDE REGEX ${_pkg_filter_rgx})
        message(STATUS "VCPKG-find_package: all-filtered-library-vars: ${_pkg_all_vars}")
        
        #Check wether DEBUG and RELEASE variables have been correctly set
        if("${_pkg_all_vars}" MATCHES "_DEBUG")
            set(_pkg_tmp_vars "${_pkg_all_vars}")
            list(FILTER _pkg_tmp_vars INCLUDE REGEX "_DEBUG")
            #list(LENGTH _pkg_tmp_vars _pkg_tmp_length)
            foreach(_pkg_var ${_pkg_tmp_vars})
                if(NOT "${${_pkg_var}}" MATCHES "NOTFOUND")
                    if(NOT "${${_pkg_var}}" MATCHES "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/debug/lib" AND "${${_pkg_var}}" MATCHES "/") 
                    # Release path instead of debug Path? (the AND Makes sure that we have to deal with a path an not a single filename.)
                        set(_tmp_var "${${_pkg_var}}")
                        message(WARNING "VCPKG-find_package: Found release paths in debug variable ${_pkg_var}! Trying to fix: ${${_pkg_var}}")
                        string(REGEX REPLACE "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/lib" "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/debug/lib" _tmp_var "${_tmp_var}")
                        foreach(_pkg_maybe_loc ${_tmp_var})
                            if(NOT EXISTS "${_pkg_maybe_loc}")
                                message(WARNING "VCPKG-Warning-find_package: Could not locate debug libraries at: ${_pkg_maybe_loc}. Trying harder")
                                #Trying harder: (unfortunally this does not work in the _RELEASE case. )
                                get_filename_component(_pkg_maybe_name "${${_pkg_var}}" NAME_WLE)
                                file(GLOB _pkg_maybe_loc "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/debug/lib/${_pkg_maybe_name}*" LIST_DIRECTORIES false)
                                list(LENGTH "${_pkg_maybe_loc}" _pkg_maybe_number)
                                if(${_pkg_maybe_number} EQUAL 1)
                                    message(STATUS "VCPKG-find_package: Sucessfully located debug libraries at: ${_pkg_maybe_loc}")
                                    list(APPEND _tmp_var_list ${_pkg_maybe_loc})
                                else()
                                    message(WARNING "VCPKG-Warning-find_package: Could not locate debug libraries at: ${_pkg_maybe_loc}. Too many possibilities")
                                endif()
                            else() #TODO: Actualy set the variable
                                message(STATUS "VCPKG-find_package: Sucessfully located debug libraries at: ${_pkg_maybe_loc}")
                                list(APPEND _tmp_var_list ${_pkg_maybe_loc})
                            endif()
                        endforeach()
                        LIST(LENGTH _tmp_var_list  _tmp_var_list_length)
                        LIST(LENGTH ${${_pkg_var}} _var_length)
                        if(_tmp_var_list_length==_var_length)
                            set(${_pkg_var} "${_tmp_var_list}")
                            set(_pkg_library_debug_found 1)
                        else()
                            set(_pkg_library_debug_found 0)
                        endif()
                    else() #Variable probably correctly set
                        set(_pkg_library_debug_found 1)
                    endif()
                else() #NOT-Found
                    message(WARNING "VCPKG-Warning-find_package: ${_pkg_var} was set to not found.")
                    set(_pkg_library_debug_found 0)
                endif()
            endforeach()
        endif()

        if("${_pkg_all_vars}" MATCHES "_RELEASE")
            set(_pkg_tmp_vars "${_pkg_all_vars}")
            list(FILTER _pkg_tmp_vars INCLUDE REGEX "_RELEASE")
            #list(LENGTH _pkg_tmp_vars _pkg_tmp_length)
            foreach(_pkg_var ${_pkg_tmp_vars})
                if(NOT "${${_pkg_var}}" MATCHES "NOTFOUND") #TODO does not work as expected
                    if(NOT "${${_pkg_var}}" MATCHES "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/lib" AND "${${_pkg_var}}" MATCHES "/") 
                    # Release path instead of debug Path? (the AND Makes sure that we have to deal with a path an not a single filename.)
                        set(_tmp_var "${${_pkg_var}}")
                        message(WARNING "VCPKG-find_package: Found debug paths in release variable ${_pkg_var}! Trying to fix it.")
                        string(REGEX REPLACE "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/debug/lib" "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/lib" _tmp_var "${_tmp_var}")
                        foreach(_pkg_maybe_loc ${_tmp_var})
                            if(NOT EXISTS "${_pkg_maybe_loc}")
                                message(WARNING "VCPKG-Warning-find_package: Could not locate release libraries.")
                            else() #TODO: Actualy set the variable
                                message(STATUS "VCPKG-find_package: Sucessfully located release libraries.")
                                list(APPEND _tmp_var_list ${_pkg_maybe_loc})
                            endif()
                        endforeach()
                        LIST(LENGTH _tmp_var_list  _tmp_var_list_length)
                        LIST(LENGTH ${${_pkg_var}} _var_length)
                        if(_tmp_var_list_length==_var_length)
                            set(${_pkg_var} "${_tmp_var_list}")
                            set(_pkg_library_debug_found 1)
                        else()
                            set(_pkg_library_debug_found 0)
                        endif()
                    else() #Variable probably correctly set
                        set(_pkg_library_release_found 1)
                    endif()
                else() #NOT-Found
                    message(WARNING "VCPKG-Warning-find_package: ${_pkg_var} was set to not found.")
                    set(_pkg_library_release_found 0)
                endif()
            endforeach()
        endif()

        list(FILTER _pkg_all_vars EXCLUDE REGEX "(_RELEASE|_DEBUG)")# Excluding debug and releas libraries from fixing
        if(DEFINED VCPKG_BUILD_TYPE OR "${_pkg_all_vars}" MATCHES "_CONFIG")
            message(STATUS "VCPKG-find_package: VCPKG_BUILD_TYPE or CONFIG found skipping loop to fix package variables. We trust the config that it is correct")
        else()
        foreach(_pkg_var ${_pkg_all_vars})
            message(STATUS "VCPKG-find_package: Value of ${_pkg_var}: ${${_pkg_var}}")
            if(NOT "${${_pkg_var}}" MATCHES "(optimized;|[Cc][Oo][Nn][Ff][Ii][Gg]:[Rr][Ee][Ll][Ee][Aa][Ss][Ee])" AND NOT "${${_pkg_var}}" MATCHES "(debug;|[Cc][Oo][Nn][Ff][Ii][Gg]:[Dd][Ee][Bb][Uu][Gg])" AND "${${_pkg_var}}" MATCHES "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}")
                # optimized and debug or generator expression not found in package library variable. Need to probably fix variable!
                set(_pkg_var_new "${${_pkg_var}}")
                if("${${_pkg_var}}" MATCHES "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/debug") # No need to guard from generator expression; already done above. 
                    # Debug Path found
                    if(CMAKE_BUILD_TYPE MATCHES "^Release$") 
                        message(WARNING "VCPKG-Warning-find_package: Found debug paths in release build in variable ${_pkg_var}! Possible issue: see #5543 and #6014! Path: ${${_pkg_var}}")
                    endif()
                    string(REGEX REPLACE "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/debug/" "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/\$<\$<CONFIG:DEBUG>:debug/>" _pkg_var_new "${_pkg_var_new}")
                else()
                    # Release Path found
                    if(CMAKE_BUILD_TYPE MATCHES "^Debug$")
                        message(WARNING "VCPKG-Warning-find_package: Found release paths in debug build in variable ${_pkg_var}! Possible issue: see #5543 and #6014! Path: ${${_pkg_var}}")
                    endif()
                    set(_pkg_var_new "${${_pkg_var}}")
                    string(REGEX REPLACE "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/" "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/\$<\$<CONFIG:DEBUG>:debug/>" _pkg_var_new "${_pkg_var_new}")
                endif()
                message(STATUS "VCPKG-find_package: Replacing ${_pkg_var}: ${${_pkg_var}}")
                set(${_pkg_var} "${_pkg_var_new}")
                #set(${_pkg_var} "debug;${_pkg_var_debug};optimized;${_pkg_var_release}") this one only works in target_link_libraries; There are also cases were variables were used in set_propertey
                 message(STATUS "VCPKG-find_package: with ${_pkg_var}: ${${_pkg_var}}")
            else()
                if(NOT "${${_pkg_var}}" MATCHES "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/" OR "${${_pkg_var}}" STREQUAL "")
                    message(STATUS "VCPKG-find_package: ${_pkg_var} does not contain absolute path or is empty! Check: ${${_pkg_var}}")
                else()
                    message(STATUS "VCPKG-find_package: ${_pkg_var} contains seperate debug and release libraries. Checking correctness of variables!") 
                    #check the optimized/debug values for correctness.
                    set(_pkg_dbg OFF)
                    set(_pkg_rel OFF)
                    set(_pkg_var_changed OFF)
                    foreach(_pkg_var_elem ${${_pkg_var}})
                        if(${_pkg_var_elem} MATCHES "debug")
                            set(_pkg_dbg ON)
                            list(APPEND _pkg_var_new "${_pkg_var_elem}")
                        elseif(${_pkg_var_elem} MATCHES "optimized")
                            set(_pkg_rel ON)
                            list(APPEND _pkg_var_new "${_pkg_var_elem}")
                        elseif(${_pkg_dbg})
                            if(NOT "${_pkg_var_elem}" MATCHES "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/debug/")
                                message(WARNING "VCPKG-Warning-find_package: Found release path after keyword debug.")
                                set(_pkg_var_changed ON)
                            endif()
                            set(_pkg_dbg OFF)
                            list(APPEND _pkg_var_new "${_pkg_var_elem}")
                        elseif(${_pkg_rel})
                             if("${_pkg_var_elem}" MATCHES "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/debug/")
                                message(WARNING "VCPKG-Warning-find_package: Found debug path after keyword optimized.")
                                set(_pkg_var_changed ON)
                            endif()
                            set(_pkg_rel OFF)
                            list(APPEND _pkg_var_new "${_pkg_var_elem}")
                        else()
                            list(APPEND _pkg_var_new "${_pkg_var_elem}")
                        endif()
                    endforeach()
                    if(${_pkg_var_changed})
                        message(STATUS "VCPKG-find_package: Resetting ${_pkg_var}")
                        message(STATUS "VCPKG-find_package: From ${${_pkg_var}}")
                        #TODO: Do the change!
                        #set(${_pkg_var} "${_pkg_var_new}")
                        message(STATUS "VCPKG-find_package: To ${${_pkg_var_new}}")
                    endif()
                endif()
            endif()
        endforeach()
        endif()
        cmake_policy(POP)
    endif()
endmacro()

#macro(find_library name)
# _find_library(${ARGV})
#endmacro()

set(VCPKG_TOOLCHAIN ON)
set(_UNUSED ${CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION})
set(_UNUSED ${CMAKE_EXPORT_NO_PACKAGE_REGISTRY})
set(_UNUSED ${CMAKE_FIND_PACKAGE_NO_PACKAGE_REGISTRY})
set(_UNUSED ${CMAKE_FIND_PACKAGE_NO_SYSTEM_PACKAGE_REGISTRY})
set(_UNUSED ${CMAKE_INSTALL_SYSTEM_RUNTIME_LIBS_SKIP})

if(NOT _CMAKE_IN_TRY_COMPILE)
    file(TO_CMAKE_PATH "${VCPKG_CHAINLOAD_TOOLCHAIN_FILE}" _chainload_file)
    file(TO_CMAKE_PATH "${_VCPKG_ROOT_DIR}" _root_dir)
    file(WRITE "${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/vcpkg.config.cmake"
        "set(VCPKG_TARGET_TRIPLET \"${VCPKG_TARGET_TRIPLET}\" CACHE STRING \"\")\n"
        "set(VCPKG_APPLOCAL_DEPS \"${VCPKG_APPLOCAL_DEPS}\" CACHE STRING \"\")\n"
        "set(VCPKG_CHAINLOAD_TOOLCHAIN_FILE \"${_chainload_file}\" CACHE STRING \"\")\n"
        "set(_VCPKG_ROOT_DIR \"${_root_dir}\" CACHE STRING \"\")\n"
        )
endif()
=======
# Mark variables as used so cmake doesn't complain about them
mark_as_advanced(CMAKE_TOOLCHAIN_FILE)

# This is a backport of CMAKE_TRY_COMPILE_PLATFORM_VARIABLES to cmake 3.0
get_property( _CMAKE_IN_TRY_COMPILE GLOBAL PROPERTY IN_TRY_COMPILE )
if( _CMAKE_IN_TRY_COMPILE )
    include( "${CMAKE_CURRENT_SOURCE_DIR}/../vcpkg.config.cmake" OPTIONAL )
endif()

if(VCPKG_CHAINLOAD_TOOLCHAIN_FILE)
    include("${VCPKG_CHAINLOAD_TOOLCHAIN_FILE}")
endif()

if(VCPKG_TOOLCHAIN)
    return()
endif()

if(NOT DEFINED CMAKE_BUILD_TYPE) 
#If the build type is not defined we are generating with a multi config generator
#Thus we should map common configurations correctly (If they have not been set)
    message(STATUS "Multi configuration generator detected mapping MinSizeRel and RelWithDebInfo to Release")
    if(NOT DEFINED CMAKE_MAP_IMPORTED_CONFIG_MINSIZEREL)
        set(CMAKE_MAP_IMPORTED_CONFIG_MINSIZEREL Release)
    endif()
    if(NOT DEFINED CMAKE_MAP_IMPORTED_CONFIG_RELWITHDEBINFO)
        set(CMAKE_MAP_IMPORTED_CONFIG_RELWITHDEBINFO Release)
    endif()
endif()

if(VCPKG_TARGET_TRIPLET)
elseif(CMAKE_GENERATOR_PLATFORM MATCHES "^[Ww][Ii][Nn]32$")
    set(_VCPKG_TARGET_TRIPLET_ARCH x86)
elseif(CMAKE_GENERATOR_PLATFORM MATCHES "^[Xx]64$")
    set(_VCPKG_TARGET_TRIPLET_ARCH x64)
elseif(CMAKE_GENERATOR_PLATFORM MATCHES "^[Aa][Rr][Mm]$")
    set(_VCPKG_TARGET_TRIPLET_ARCH arm)
elseif(CMAKE_GENERATOR_PLATFORM MATCHES "^[Aa][Rr][Mm]64$")
    set(_VCPKG_TARGET_TRIPLET_ARCH arm64)
else()
    if(CMAKE_GENERATOR MATCHES "^Visual Studio 14 2015 Win64$")
        set(_VCPKG_TARGET_TRIPLET_ARCH x64)
    elseif(CMAKE_GENERATOR MATCHES "^Visual Studio 14 2015 ARM$")
        set(_VCPKG_TARGET_TRIPLET_ARCH arm)
    elseif(CMAKE_GENERATOR MATCHES "^Visual Studio 14 2015$")
        set(_VCPKG_TARGET_TRIPLET_ARCH x86)
    elseif(CMAKE_GENERATOR MATCHES "^Visual Studio 15 2017 Win64$")
        set(_VCPKG_TARGET_TRIPLET_ARCH x64)
    elseif(CMAKE_GENERATOR MATCHES "^Visual Studio 15 2017 ARM$")
        set(_VCPKG_TARGET_TRIPLET_ARCH arm)
    elseif(CMAKE_GENERATOR MATCHES "^Visual Studio 15 2017$")
        set(_VCPKG_TARGET_TRIPLET_ARCH x86)
    else()
        find_program(_VCPKG_CL cl)
        if(_VCPKG_CL MATCHES "amd64/cl.exe$" OR _VCPKG_CL MATCHES "x64/cl.exe$")
            set(_VCPKG_TARGET_TRIPLET_ARCH x64)
        elseif(_VCPKG_CL MATCHES "arm/cl.exe$")
            set(_VCPKG_TARGET_TRIPLET_ARCH arm)
        elseif(_VCPKG_CL MATCHES "arm64/cl.exe$")
            set(_VCPKG_TARGET_TRIPLET_ARCH arm64)
        elseif(_VCPKG_CL MATCHES "bin/cl.exe$" OR _VCPKG_CL MATCHES "x86/cl.exe$")
            set(_VCPKG_TARGET_TRIPLET_ARCH x86)
        elseif(CMAKE_HOST_SYSTEM_PROCESSOR STREQUAL "x86_64")
            set(_VCPKG_TARGET_TRIPLET_ARCH x64)
        else()
            if( _CMAKE_IN_TRY_COMPILE )
                message(STATUS "Unable to determine target architecture, continuing without vcpkg.")
            else()
                message(WARNING "Unable to determine target architecture, continuing without vcpkg.")
            endif()
            set(VCPKG_TOOLCHAIN ON)
            return()
        endif()
    endif()
endif()

if(CMAKE_SYSTEM_NAME STREQUAL "WindowsStore" OR CMAKE_SYSTEM_NAME STREQUAL "WindowsPhone")
    set(_VCPKG_TARGET_TRIPLET_PLAT uwp)
elseif(CMAKE_SYSTEM_NAME STREQUAL "Linux" OR (NOT CMAKE_SYSTEM_NAME AND CMAKE_HOST_SYSTEM_NAME STREQUAL "Linux"))
    set(_VCPKG_TARGET_TRIPLET_PLAT linux)
elseif(CMAKE_SYSTEM_NAME STREQUAL "Darwin" OR (NOT CMAKE_SYSTEM_NAME AND CMAKE_HOST_SYSTEM_NAME STREQUAL "Darwin"))
    set(_VCPKG_TARGET_TRIPLET_PLAT osx)
elseif(CMAKE_SYSTEM_NAME STREQUAL "Windows" OR (NOT CMAKE_SYSTEM_NAME AND CMAKE_HOST_SYSTEM_NAME STREQUAL "Windows"))
    set(_VCPKG_TARGET_TRIPLET_PLAT windows)
elseif(CMAKE_SYSTEM_NAME STREQUAL "FreeBSD" OR (NOT CMAKE_SYSTEM_NAME AND CMAKE_HOST_SYSTEM_NAME STREQUAL "FreeBSD"))
    set(_VCPKG_TARGET_TRIPLET_PLAT freebsd)
endif()

set(VCPKG_TARGET_TRIPLET ${_VCPKG_TARGET_TRIPLET_ARCH}-${_VCPKG_TARGET_TRIPLET_PLAT} CACHE STRING "Vcpkg target triplet (ex. x86-windows)")
set(_VCPKG_TOOLCHAIN_DIR ${CMAKE_CURRENT_LIST_DIR})

if(NOT DEFINED _VCPKG_ROOT_DIR)
    # Detect .vcpkg-root to figure VCPKG_ROOT_DIR
    set(_VCPKG_ROOT_DIR_CANDIDATE ${CMAKE_CURRENT_LIST_DIR})
    while(IS_DIRECTORY ${_VCPKG_ROOT_DIR_CANDIDATE} AND NOT EXISTS "${_VCPKG_ROOT_DIR_CANDIDATE}/.vcpkg-root")
        get_filename_component(_VCPKG_ROOT_DIR_TEMP ${_VCPKG_ROOT_DIR_CANDIDATE} DIRECTORY)
        if (_VCPKG_ROOT_DIR_TEMP STREQUAL _VCPKG_ROOT_DIR_CANDIDATE) # If unchanged, we have reached the root of the drive
            message(FATAL_ERROR "Could not find .vcpkg-root")
        else()
            SET(_VCPKG_ROOT_DIR_CANDIDATE ${_VCPKG_ROOT_DIR_TEMP})
        endif()
    endwhile()
    set(_VCPKG_ROOT_DIR ${_VCPKG_ROOT_DIR_CANDIDATE} CACHE INTERNAL "Vcpkg root directory")
endif()
set(_VCPKG_INSTALLED_DIR ${_VCPKG_ROOT_DIR}/installed)

if(NOT EXISTS "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}" AND NOT _CMAKE_IN_TRY_COMPILE)
    message(WARNING "There are no libraries installed for the Vcpkg triplet ${VCPKG_TARGET_TRIPLET}.")
endif()

if(CMAKE_BUILD_TYPE MATCHES "^Debug$" OR NOT DEFINED CMAKE_BUILD_TYPE) #Debug build: Put Debug paths before Release paths. 
    list(APPEND CMAKE_PREFIX_PATH
        ${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/debug ${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}
    )
    list(APPEND CMAKE_LIBRARY_PATH
        ${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/debug/lib/manual-link ${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/lib/manual-link
    )
    list(APPEND CMAKE_FIND_ROOT_PATH
        ${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/debug ${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}
    )
else() #Release build: Put Release paths before Debug paths. Debug Paths are required so that CMake generates correct info in autogenerated target files.
    list(APPEND CMAKE_PREFIX_PATH
        ${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET} ${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/debug
    )
    list(APPEND CMAKE_LIBRARY_PATH
        ${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/lib/manual-link ${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/debug/lib/manual-link
    )
    list(APPEND CMAKE_FIND_ROOT_PATH
        ${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET} ${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/debug
    )
endif()

file(TO_CMAKE_PATH "$ENV{PROGRAMFILES}" _programfiles)
set(CMAKE_SYSTEM_IGNORE_PATH
    "${_programfiles}/OpenSSL"
    "${_programfiles}/OpenSSL-Win32"
    "${_programfiles}/OpenSSL-Win64"
    "${_programfiles}/OpenSSL-Win32/lib/VC"
    "${_programfiles}/OpenSSL-Win64/lib/VC"
    "${_programfiles}/OpenSSL-Win32/lib/VC/static"
    "${_programfiles}/OpenSSL-Win64/lib/VC/static"
#From Neumann-A: Can those absolute paths be removed?
    "C:/OpenSSL/"
    "C:/OpenSSL-Win32/"
    "C:/OpenSSL-Win64/"
    "C:/OpenSSL-Win32/lib/VC"
    "C:/OpenSSL-Win64/lib/VC"
    "C:/OpenSSL-Win32/lib/VC/static"
    "C:/OpenSSL-Win64/lib/VC/static"
)

list(APPEND CMAKE_PROGRAM_PATH ${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/tools)
file(GLOB _VCPKG_TOOLS_DIRS ${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/tools/*)
foreach(_VCPKG_TOOLS_DIR ${_VCPKG_TOOLS_DIRS})
    if(IS_DIRECTORY ${_VCPKG_TOOLS_DIR})
        list(APPEND CMAKE_PROGRAM_PATH ${_VCPKG_TOOLS_DIR})
    endif()
endforeach()

option(VCPKG_APPLOCAL_DEPS "Automatically copy dependencies into the output directory for executables." ON)
function(add_executable name)
    _add_executable(${ARGV})
    list(FIND ARGV "IMPORTED" IMPORTED_IDX)
    list(FIND ARGV "ALIAS" ALIAS_IDX)
    if(IMPORTED_IDX EQUAL -1 AND ALIAS_IDX EQUAL -1)
        if(VCPKG_APPLOCAL_DEPS AND _VCPKG_TARGET_TRIPLET_PLAT MATCHES "windows|uwp")
            add_custom_command(TARGET ${name} POST_BUILD
                COMMAND powershell -noprofile -executionpolicy Bypass -file ${_VCPKG_TOOLCHAIN_DIR}/msbuild/applocal.ps1
                    -targetBinary $<TARGET_FILE:${name}>
                    -installedDir "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}$<$<CONFIG:Debug>:/debug>/bin"
                    -OutVariable out
            )
        endif()
        set_target_properties(${name} PROPERTIES VS_USER_PROPS do_not_import_user.props)
        set_target_properties(${name} PROPERTIES VS_GLOBAL_VcpkgEnabled false)
    endif()
endfunction()

function(add_library name)
    _add_library(${ARGV})
    list(FIND ARGV "IMPORTED" IMPORTED_IDX)
    list(FIND ARGV "INTERFACE" INTERFACE_IDX)
    list(FIND ARGV "ALIAS" ALIAS_IDX)
    if(IMPORTED_IDX EQUAL -1 AND INTERFACE_IDX EQUAL -1 AND ALIAS_IDX EQUAL -1)
        get_target_property(IS_LIBRARY_SHARED ${name} TYPE)
        if(VCPKG_APPLOCAL_DEPS AND _VCPKG_TARGET_TRIPLET_PLAT MATCHES "windows|uwp" AND (IS_LIBRARY_SHARED STREQUAL "SHARED_LIBRARY" OR IS_LIBRARY_SHARED STREQUAL "MODULE_LIBRARY"))
            add_custom_command(TARGET ${name} POST_BUILD
                COMMAND powershell -noprofile -executionpolicy Bypass -file ${_VCPKG_TOOLCHAIN_DIR}/msbuild/applocal.ps1
                    -targetBinary $<TARGET_FILE:${name}>
                    -installedDir "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}$<$<CONFIG:Debug>:/debug>/bin"
                    -OutVariable out
            )
        endif()
        set_target_properties(${name} PROPERTIES VS_USER_PROPS do_not_import_user.props)
        set_target_properties(${name} PROPERTIES VS_GLOBAL_VcpkgEnabled false)
    endif()
endfunction()

macro(find_package name)
    string(TOLOWER "${name}" _vcpkg_lowercase_name)
    string(TOUPPER "${name}" _vcpkg_uppercase_name)
    if(EXISTS "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/share/${_vcpkg_lowercase_name}/vcpkg-cmake-wrapper.cmake")
        set(ARGS "${ARGV}")
        include(${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/share/${_vcpkg_lowercase_name}/vcpkg-cmake-wrapper.cmake)
    elseif("${name}" STREQUAL "Boost" AND EXISTS "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/include/boost")
        # Checking for the boost headers disables this wrapper unless the user has installed at least one boost library
        set(Boost_USE_STATIC_LIBS OFF)
        set(Boost_USE_MULTITHREADED ON)
        unset(Boost_USE_STATIC_RUNTIME)
        set(Boost_NO_BOOST_CMAKE ON)
        unset(Boost_USE_STATIC_RUNTIME CACHE)
        set(Boost_COMPILER "-vc140")
        _find_package(${ARGV})
    elseif("${name}" STREQUAL "ICU" AND EXISTS "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/include/unicode/utf.h")
        function(_vcpkg_find_in_list)
            list(FIND ARGV "COMPONENTS" COMPONENTS_IDX)
            set(COMPONENTS_IDX ${COMPONENTS_IDX} PARENT_SCOPE)
        endfunction()
        _vcpkg_find_in_list(${ARGV})
        if(NOT COMPONENTS_IDX EQUAL -1)
            _find_package(${ARGV} COMPONENTS data)
        else()
            _find_package(${ARGV})
        endif()
    # elseif("${name}" STREQUAL "GSL" AND EXISTS "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/include/gsl")
        # _find_package(${ARGV})
        # if(GSL_FOUND AND TARGET GSL::gsl)
            # set_property( TARGET GSL::gslcblas APPEND PROPERTY IMPORTED_CONFIGURATIONS Release )
            # set_property( TARGET GSL::gsl APPEND PROPERTY IMPORTED_CONFIGURATIONS Release )
            # if( EXISTS "${GSL_LIBRARY_DEBUG}" AND EXISTS "${GSL_CBLAS_LIBRARY_DEBUG}")
            # set_property( TARGET GSL::gsl APPEND PROPERTY IMPORTED_CONFIGURATIONS Debug )
            # set_target_properties( GSL::gsl PROPERTIES IMPORTED_LOCATION_DEBUG "${GSL_LIBRARY_DEBUG}" )
                # set_property( TARGET GSL::gslcblas APPEND PROPERTY IMPORTED_CONFIGURATIONS Debug )
                # set_target_properties( GSL::gslcblas PROPERTIES IMPORTED_LOCATION_DEBUG "${GSL_CBLAS_LIBRARY_DEBUG}" )
            # endif()
        # endif()
    # elseif("${name}" STREQUAL "CURL" AND EXISTS "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/include/curl")
        # _find_package(${ARGV})
        # if(CURL_FOUND)
            # if(EXISTS "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/lib/nghttp2.lib")
                # list(APPEND CURL_LIBRARIES
                    # "debug" "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/debug/lib/nghttp2.lib"
                    # "optimized" "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/lib/nghttp2.lib")
            # endif()
        # endif()
    elseif("${_vcpkg_lowercase_name}" STREQUAL "grpc" AND EXISTS "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/share/grpc")
        _find_package(gRPC ${ARGN})
    else()
        # If package does not define targets and only uses old school variables we have to fix the paths to the libraries since
        # find_package will only find the debug libraries or only find the release libraries if the name of the library was 
        # changed for debug builds. 
        _find_package(${ARGV})

        cmake_policy(PUSH)
        cmake_policy(SET CMP0054 NEW)

        get_cmake_property(_pkg_all_vars VARIABLES)

        #General find_package debug info. Show all defined package variables to examine if they are set wrong
        set(_pkg_names_rgx "(${name}|${_vcpkg_uppercase_name}|${_vcpkg_lowercase_name})")
        #Need to escape special regex characters
        STRING(REPLACE "+" "\\+" _pkg_names_rgx "${_pkg_names_rgx}")
        STRING(REPLACE "*" "\\*" _pkg_names_rgx "${_pkg_names_rgx}")
        set(_pkg_filter_rgx "^(${_pkg_names_rgx})([^_]*_)+")
        list(FILTER _pkg_all_vars INCLUDE REGEX ${_pkg_filter_rgx})
        message(STATUS "VCPKG-all-package-defined-vars: ${_pkg_all_vars}")
        foreach(_pkg_var ${_pkg_all_vars})
            message(STATUS "VCPKG-find_package value of ${_pkg_var}: ${${_pkg_var}}")
        endforeach()
        
        #Fixing Libraries paths.
        set(_pkg_filter_rgx "^(${_pkg_names_rgx})([^_]*_)+(LIBRAR|LIBS)")

        #Filtering for variables which are probably library variables for the package.
        list(FILTER _pkg_all_vars INCLUDE REGEX ${_pkg_filter_rgx})
        message(STATUS "VCPKG-find_package: all-filtered-library-vars: ${_pkg_all_vars}")
        
        #Check wether DEBUG and RELEASE variables have been correctly set
        if("${_pkg_all_vars}" MATCHES "_DEBUG")
            set(_pkg_tmp_vars "${_pkg_all_vars}")
            list(FILTER _pkg_tmp_vars INCLUDE REGEX "_DEBUG")
            #list(LENGTH _pkg_tmp_vars _pkg_tmp_length)
            foreach(_pkg_var ${_pkg_tmp_vars})
                if(NOT "${${_pkg_var}}" MATCHES "NOTFOUND")
                    if(NOT "${${_pkg_var}}" MATCHES "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/debug/lib" AND "${${_pkg_var}}" MATCHES "/") 
                    # Release path instead of debug Path? (the AND Makes sure that we have to deal with a path an not a single filename.)
                        set(_tmp_var "${${_pkg_var}}")
                        message(WARNING "VCPKG-find_package: Found release paths in debug variable ${_pkg_var}! Trying to fix: ${${_pkg_var}}")
                        string(REGEX REPLACE "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/lib" "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/debug/lib" _tmp_var "${_tmp_var}")
                        foreach(_pkg_maybe_loc ${_tmp_var})
                            if(NOT EXISTS "${_pkg_maybe_loc}")
                                message(WARNING "VCPKG-Warning-find_package: Could not locate debug libraries at: ${_pkg_maybe_loc}. Trying harder")
                                #Trying harder: (unfortunally this does not work in the _RELEASE case. )
                                get_filename_component(_pkg_maybe_name "${${_pkg_var}}" NAME_WLE)
                                file(GLOB _pkg_maybe_loc "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/debug/lib/${_pkg_maybe_name}*" LIST_DIRECTORIES false)
                                list(LENGTH "${_pkg_maybe_loc}" _pkg_maybe_number)
                                if(${_pkg_maybe_number} EQUAL 1)
                                    message(STATUS "VCPKG-find_package: Sucessfully located debug libraries at: ${_pkg_maybe_loc}")
                                    list(APPEND _tmp_var_list ${_pkg_maybe_loc})
                                else()
                                    message(WARNING "VCPKG-Warning-find_package: Could not locate debug libraries at: ${_pkg_maybe_loc}. Too many possibilities")
                                endif()
                            else() #TODO: Actualy set the variable
                                message(STATUS "VCPKG-find_package: Sucessfully located debug libraries at: ${_pkg_maybe_loc}")
                                list(APPEND _tmp_var_list ${_pkg_maybe_loc})
                            endif()
                        endforeach()
                        LIST(LENGTH _tmp_var_list  _tmp_var_list_length)
                        LIST(LENGTH ${${_pkg_var}} _var_length)
                        if(_tmp_var_list_length==_var_length)
                            set(${_pkg_var} "${_tmp_var_list}")
                            set(_pkg_library_debug_found 1)
                        else()
                            set(_pkg_library_debug_found 0)
                        endif()
                    else() #Variable probably correctly set
                        set(_pkg_library_debug_found 1)
                    endif()
                else() #NOT-Found
                    message(WARNING "VCPKG-Warning-find_package: ${_pkg_var} was set to not found.")
                    set(_pkg_library_debug_found 0)
                endif()
            endforeach()
        endif()

        if("${_pkg_all_vars}" MATCHES "_RELEASE")
            set(_pkg_tmp_vars "${_pkg_all_vars}")
            list(FILTER _pkg_tmp_vars INCLUDE REGEX "_RELEASE")
            #list(LENGTH _pkg_tmp_vars _pkg_tmp_length)
            foreach(_pkg_var ${_pkg_tmp_vars})
                if(NOT "${${_pkg_var}}" MATCHES "NOTFOUND") #TODO does not work as expected
                    if(NOT "${${_pkg_var}}" MATCHES "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/lib" AND "${${_pkg_var}}" MATCHES "/") 
                    # Release path instead of debug Path? (the AND Makes sure that we have to deal with a path an not a single filename.)
                        set(_tmp_var "${${_pkg_var}}")
                        message(WARNING "VCPKG-find_package: Found debug paths in release variable ${_pkg_var}! Trying to fix it.")
                        string(REGEX REPLACE "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/debug/lib" "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/lib" _tmp_var "${_tmp_var}")
                        foreach(_pkg_maybe_loc ${_tmp_var})
                            if(NOT EXISTS "${_pkg_maybe_loc}")
                                message(WARNING "VCPKG-Warning-find_package: Could not locate release libraries.")
                            else() #TODO: Actualy set the variable
                                message(STATUS "VCPKG-find_package: Sucessfully located release libraries.")
                                list(APPEND _tmp_var_list ${_pkg_maybe_loc})
                            endif()
                        endforeach()
                        LIST(LENGTH _tmp_var_list  _tmp_var_list_length)
                        LIST(LENGTH ${${_pkg_var}} _var_length)
                        if(_tmp_var_list_length==_var_length)
                            set(${_pkg_var} "${_tmp_var_list}")
                            set(_pkg_library_debug_found 1)
                        else()
                            set(_pkg_library_debug_found 0)
                        endif()
                    else() #Variable probably correctly set
                        set(_pkg_library_release_found 1)
                    endif()
                else() #NOT-Found
                    message(WARNING "VCPKG-Warning-find_package: ${_pkg_var} was set to not found.")
                    set(_pkg_library_release_found 0)
                endif()
            endforeach()
        endif()

        list(FILTER _pkg_all_vars EXCLUDE REGEX "(_RELEASE|_DEBUG)")# Excluding debug and releas libraries from fixing
        if(DEFINED VCPKG_BUILD_TYPE OR "${_pkg_all_vars}" MATCHES "_CONFIG")
            message(STATUS "VCPKG-find_package: VCPKG_BUILD_TYPE or CONFIG found skipping loop to fix package variables. We trust the config that it is correct")
        else()
        foreach(_pkg_var ${_pkg_all_vars})
            message(STATUS "VCPKG-find_package: Value of ${_pkg_var}: ${${_pkg_var}}")
            if(NOT "${${_pkg_var}}" MATCHES "(optimized;|[Cc][Oo][Nn][Ff][Ii][Gg]:[Rr][Ee][Ll][Ee][Aa][Ss][Ee])" AND NOT "${${_pkg_var}}" MATCHES "(debug;|[Cc][Oo][Nn][Ff][Ii][Gg]:[Dd][Ee][Bb][Uu][Gg])" AND "${${_pkg_var}}" MATCHES "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}")
                # optimized and debug or generator expression not found in package library variable. Need to probably fix variable!
                set(_pkg_var_new "${${_pkg_var}}")
                if("${${_pkg_var}}" MATCHES "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/debug") # No need to guard from generator expression; already done above. 
                    # Debug Path found
                    if(CMAKE_BUILD_TYPE MATCHES "^Release$") 
                        message(WARNING "VCPKG-Warning-find_package: Found debug paths in release build in variable ${_pkg_var}! Possible issue: see #5543 and #6014! Path: ${${_pkg_var}}")
                    endif()
                    string(REGEX REPLACE "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/debug/" "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/\$<\$<CONFIG:DEBUG>:debug/>" _pkg_var_new "${_pkg_var_new}")
                else()
                    # Release Path found
                    if(CMAKE_BUILD_TYPE MATCHES "^Debug$")
                        message(WARNING "VCPKG-Warning-find_package: Found release paths in debug build in variable ${_pkg_var}! Possible issue: see #5543 and #6014! Path: ${${_pkg_var}}")
                    endif()
                    set(_pkg_var_new "${${_pkg_var}}")
                    string(REGEX REPLACE "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/" "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/\$<\$<CONFIG:DEBUG>:debug/>" _pkg_var_new "${_pkg_var_new}")
                endif()
                message(STATUS "VCPKG-find_package: Replacing ${_pkg_var}: ${${_pkg_var}}")
                set(${_pkg_var} "${_pkg_var_new}")
                #set(${_pkg_var} "debug;${_pkg_var_debug};optimized;${_pkg_var_release}") this one only works in target_link_libraries; There are also cases were variables were used in set_propertey
                 message(STATUS "VCPKG-find_package: with ${_pkg_var}: ${${_pkg_var}}")
            else()
                if(NOT "${${_pkg_var}}" MATCHES "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/" OR "${${_pkg_var}}" STREQUAL "")
                    message(STATUS "VCPKG-find_package: ${_pkg_var} does not contain absolute path or is empty! Check: ${${_pkg_var}}")
                else()
                    message(STATUS "VCPKG-find_package: ${_pkg_var} contains seperate debug and release libraries. Checking correctness of variables!") 
                    #check the optimized/debug values for correctness.
                    set(_pkg_dbg OFF)
                    set(_pkg_rel OFF)
                    set(_pkg_var_changed OFF)
                    foreach(_pkg_var_elem ${${_pkg_var}})
                        if(${_pkg_var_elem} MATCHES "debug")
                            set(_pkg_dbg ON)
                            list(APPEND _pkg_var_new "${_pkg_var_elem}")
                        elseif(${_pkg_var_elem} MATCHES "optimized")
                            set(_pkg_rel ON)
                            list(APPEND _pkg_var_new "${_pkg_var_elem}")
                        elseif(${_pkg_dbg})
                            if(NOT "${_pkg_var_elem}" MATCHES "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/debug/")
                                message(WARNING "VCPKG-Warning-find_package: Found release path after keyword debug.")
                                set(_pkg_var_changed ON)
                            endif()
                            set(_pkg_dbg OFF)
                            list(APPEND _pkg_var_new "${_pkg_var_elem}")
                        elseif(${_pkg_rel})
                             if("${_pkg_var_elem}" MATCHES "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/debug/")
                                message(WARNING "VCPKG-Warning-find_package: Found debug path after keyword optimized.")
                                set(_pkg_var_changed ON)
                            endif()
                            set(_pkg_rel OFF)
                            list(APPEND _pkg_var_new "${_pkg_var_elem}")
                        else()
                            list(APPEND _pkg_var_new "${_pkg_var_elem}")
                        endif()
                    endforeach()
                    if(${_pkg_var_changed})
                        message(STATUS "VCPKG-find_package: Resetting ${_pkg_var}")
                        message(STATUS "VCPKG-find_package: From ${${_pkg_var}}")
                        #TODO: Do the change!
                        #set(${_pkg_var} "${_pkg_var_new}")
                        message(STATUS "VCPKG-find_package: To ${${_pkg_var_new}}")
                    endif()
                endif()
            endif()
        endforeach()
        endif()
        cmake_policy(POP)
    endif()
endmacro()

#macro(find_library name)
# _find_library(${ARGV})
#endmacro()

set(VCPKG_TOOLCHAIN ON)
set(_UNUSED ${CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION})
set(_UNUSED ${CMAKE_EXPORT_NO_PACKAGE_REGISTRY})
set(_UNUSED ${CMAKE_FIND_PACKAGE_NO_PACKAGE_REGISTRY})
set(_UNUSED ${CMAKE_FIND_PACKAGE_NO_SYSTEM_PACKAGE_REGISTRY})
set(_UNUSED ${CMAKE_INSTALL_SYSTEM_RUNTIME_LIBS_SKIP})

if(NOT _CMAKE_IN_TRY_COMPILE)
    file(TO_CMAKE_PATH "${VCPKG_CHAINLOAD_TOOLCHAIN_FILE}" _chainload_file)
    file(TO_CMAKE_PATH "${_VCPKG_ROOT_DIR}" _root_dir)
    file(WRITE "${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/vcpkg.config.cmake"
        "set(VCPKG_TARGET_TRIPLET \"${VCPKG_TARGET_TRIPLET}\" CACHE STRING \"\")\n"
        "set(VCPKG_APPLOCAL_DEPS \"${VCPKG_APPLOCAL_DEPS}\" CACHE STRING \"\")\n"
        "set(VCPKG_CHAINLOAD_TOOLCHAIN_FILE \"${_chainload_file}\" CACHE STRING \"\")\n"
        "set(_VCPKG_ROOT_DIR \"${_root_dir}\" CACHE STRING \"\")\n"
        )
endif()
>>>>>>> WIP: Solve #5540 b
