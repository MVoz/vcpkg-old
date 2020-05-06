# Common Ambient Variables:
#   CURRENT_BUILDTREES_DIR    = ${VCPKG_ROOT_DIR}\buildtrees\${PORT}
#   CURRENT_PACKAGES_DIR      = ${VCPKG_ROOT_DIR}\packages\${PORT}_${TARGET_TRIPLET}
#   CURRENT_PORT_DIR          = ${VCPKG_ROOT_DIR}\ports\${PORT}
#   PORT                      = current port name (zlib, etc)
#   TARGET_TRIPLET            = current triplet (x86-windows, x64-windows-static, etc)
#   VCPKG_CRT_LINKAGE         = C runtime linkage type (static, dynamic)
#   VCPKG_LIBRARY_LINKAGE     = target library linkage type (static, dynamic)
#   VCPKG_ROOT_DIR            = <C:\path\to\current\vcpkg>
#   VCPKG_TARGET_ARCHITECTURE = target architecture (x64, x86, arm)
#

include(vcpkg_common_functions)

set(CMAKE_COLOR_MAKEFILE ON)

if(NOT EXISTS)
#	message(STATUS "Submodule update")
execute_process(COMMAND
    ${CMAKE_COMMAND} -E cmake_echo_color --cyan "Tested only Windows x64 Static"
)
endif()

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

include(colors)

message("")
#include(printInfo)
message("")

find_program(CMAKE_CXX_CPPCHECK NAMES cppcheck)
if(CPPCHECK_ROOT_DIR)
	find_program(CPPCHECK_EXECUTABLE
		NAMES
		cppcheck
		cli
		PATHS
		"${CPPCHECK_ROOT_DIR}"
		PATH_SUFFIXES
		cli
		NO_DEFAULT_PATH)
endif()

file(GLOB_RECURSE ALL_SOURCE_FILES *.cpp *.h)

if (CMAKE_CXX_CPPCHECK)
    list(
        APPEND CMAKE_CXX_CPPCHECK 
            "--enable=warning,performance,portability,information,missingInclude"
			"--std=c++11"
			"--library=std.cfg,windows.cfg"
			"--template="[{severity}][{id}] {message} {callstack} \(On {file}:{line}\)""
            "--inconclusive"
            "--force" 
            "--inline-suppr"
#			"--suppress=*:*3rdparty\*"
			"--suppress=*:*src\*"
			"--language=c++"
#			"--enable=all"
			"--verbose"
#			"--suppressions-list=${CMAKE_SOURCE_DIR}/CppCheckSuppressions.txt"
#			${ALL_SOURCE_FILES}
#			${CMAKE_SOURCE_DIR}
			"--error-exitcode=1"
	)
endif()

# additional target to perform cppcheck run, requires cppcheck

# get all project files
# HACK this workaround is required to avoid qml files checking ^_^
#file(GLOB_RECURSE ALL_SOURCE_FILES *.cpp *.h)


#add_custom_target(
#       cppcheck
#        COMMAND cppcheck
#        --enable=warning,performance,portability,information,missingInclude
#        --std=c++11
#        --library=std.cfg,windows.cfg
#        --template="[{severity}][{id}] {message} {callstack} \(On {file}:{line}\)"
#        --verbose
#        --quiet
#        ${ALL_SOURCE_FILES}
#)



find_package(Git QUIET)

set(GIT_URL "https://github.com/ampl/mp.git")
set(GIT_REV "3.1.0")
set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/ampl)

if(NOT EXISTS "${SOURCE_PATH}/.git")
	message(STATUS "Cloning")
	set(error_code 1)
	set(number_of_tries 0)
	while(error_code AND number_of_tries LESS 3)
		execute_process(
		COMMAND ${GIT} clone --progress ${GIT_URL} ${SOURCE_PATH}
		WORKING_DIRECTORY ${SOURCE_PATH}
		RESULT_VARIABLE error_code
	)
	math(EXPR number_of_tries "${number_of_tries} + 1")
	endwhile()
	if(number_of_tries GREATER 1)
		message(STATUS "Had to git clone more than once:	${number_of_tries} times.")
	endif()
	if(error_code)
		message(FATAL_ERROR "Failed to clone repository: '${GIT_URL}'")
	endif()
	
	message(STATUS "Checkout revision ${GIT_REV}")
		execute_process(
		COMMAND ${GIT} checkout -b ${GIT_REV}
		WORKING_DIRECTORY ${SOURCE_PATH}
		RESULT_VARIABLE error_code
	)
	# Update submodules as needed
    option(GIT_SUBMODULE "Check submodules during build" ON)
    if(GIT_SUBMODULE)
        message(STATUS "Submodule update")
        execute_process(COMMAND ${GIT} submodule update --init --recursive ${SOURCE_PATH}
                        WORKING_DIRECTORY ${SOURCE_PATH}
                        RESULT_VARIABLE GIT_SUBMOD_RESULT)
        if(NOT GIT_SUBMOD_RESULT EQUAL "0")
            message(FATAL_ERROR "git submodule update --init failed with ${GIT_SUBMOD_RESULT}, please checkout submodules")
        endif()
    endif()

endif()

SET(CMAKE_INCLUDE_CURRENT_DIR ON)
set(WINDOWS_EXPORT_ALL_SYMBOLS TRUE)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
	
#    PREFER_NINJA # Disable this option if project cannot be built with Ninja
#	GENERATOR "MinGW Makefiles"
	OPTIONS
		-DBUILD=all
#		-DCMAKE_SYSTEM_VERSION=10.0.15063.0 -DWINDOWS_TARGET_PLATFORM_VERSION=10.0.15063.0 -DTARGET_PLATFORM_VERSION=10.0.15063.0
#	-DCMAKE_SYSTEM_PROCESSOR=x86_64 MP_CXX11_FLAG
#		-DTARGET_PLATFORM_VERSION=10.0.17134.0 -DCMAKE_HOST_SYSTEM_VERSION=10.0.17134 -DCMAKE_VS_WINDOWS_TARGET_PLATFORM_VERSION=10.0.17134.0 
	#-DCMAKE_SYSTEM_VERSION=10.0.17134.0
	#-DRUN_HAVE_STD_REGEX=0 -DRUN_HAVE_STEADY_CLOCK=0
	#-DHAVE_STD_CPP11_FLAG_EXITCODE=0 -DHAVE_UNIQUE_PTR_EXITCODE=0 -DHAVE_ATOMIC_EXITCODE=0 -DHAVE_HASH_EXITCODE=0 -DMP_VARIADIC_TEMPLATES_EXITCODE=0
	-DGTEST_HAS_TR1_TUPLE=0 -DGTEST_USE_OWN_TR1_TUPLE=1 -DGSL_DISABLE_WARNINGS=ON -DHAVE_ACCESS_DRIVER_EXITCODE=0 -DHAVE_EXCEL_DRIVER_EXITCODE=0 -DHAVE_ODBC_TEXT_DRIVER_EXITCODE=0 -DHAVE_EXT_HASH_MAP_EXITCODE=0 -DHAVE_HASH_EXITCODE=0 -DHAVE_ALWAYS_INLINE_EXITCODE=0 -DHAVE_EXT_HASH_MAP_EXITCODE=0 -DMP_HAVE_MKSTEMPS_EXITCODE=0
	-DCMAKE_CXX_FLAGS=/D_SILENCE_TR1_NAMESPACE_DEPRECATION_WARNING 
)


#if()
#    add_definitions( /D_STL_DISABLED_WARNINGS /D_CRT_SECURE_NO_WARNINGS /D_CRT_NONSTDC_NO_DEPRECATE /D_SCL_SECURE_NO_WARNINGS /D_CRT_NONSTDC_NO_WARNINGS /D_CRT_SECURE_NO_WARNINGS_GLOBALS /D_CRT_SECURE_NO_WARNINGS /D_TR1_NAMESPACE_DEPRECATION_WARNING /D_SILENCE_TR1_NAMESPACE_DEPRECATION_WARNING )
#endif()

if()
	add_definitions( /DGSL_DISABLE_WARNINGS /D_SILENCE_TR1_NAMESPACE_DEPRECATION_NO_WARNING)
endif()

vcpkg_install_cmake()

SET(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CURRENT_PACKAGES_DIR}/bin)

# Handle copyright
# file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/ampl RENAME copyright)

# Post-build test for cmake libraries
# ## ### vcpkg_test_cmake(PACKAGE_NAME ampl)
