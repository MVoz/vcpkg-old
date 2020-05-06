#.rst:
# .. command:: vcpkg_configure_waf
#
#  Configure a waf-based project. Note that if waf acquisition is required,
#  it must be done in the port file. Only the portfile maintainer can decide
#  whether to make use of the generic waf version acquired in vcpkg.
#  Overview: 1. MSVC-version (2015, 2017) supported, 2. Target architechture
#  (x86, x64, arm) supported, 3. debug/release supported 4. crt-linkage
#  supported, 5. static/shared supported via post install, and implib hack
#  NOT covered: windows/uwp, win-sdk version
#
#  ::
#  vcpkg_configure_waf(SOURCE_PATH <waf_file_path = source root>
#                        [OPTIONS arg1 [arg2 ...]]
#                        [OPTIONS_DEBUG arg1 [arg2 ...]]
#                        [OPTIONS_RELEASE arg1 [arg2 ...]]
#                        [OPTIONS_BUILD arg1 [arg2 ...]]
#                        [OPTIONS_BUILD_DEBUG arg1 [arg2 ...]]
#                        [OPTIONS_BUILD_RELEASE arg1 [arg2 ...]]
#                        [TARGETS arg1 [arg2 ...]]
#                        )
#
#  ``SOURCE_PATH``
#    The path to the waf executable directory
#  ``OPTIONS``
#    The options passed to waf that are used in release- and debug-build.
#  ``OPTIONS_RELEASE``
#    The options passed to waf that are used in the release-build only.
#  ``OPTIONS_DEBUG``
#    The options passed to waf that are used in the debug-build only.
#  ``OPTIONS_BUILD``
#    The options passed through to the build step and used in both release- and debug-build.
#  ``OPTIONS_BUILD_DEBUG``
#    The options passed through to the build step and used only in the debug-build.
#  ``OPTIONS_BUILD_RELEASE``
#    The options passed through to the build step and used only in the release build.
#  ``TARGETS``
#    Chose among individual build targets
# Example: aubio

include(vcpkg_acquire_waf)

function(vcpkg_configure_waf)
    cmake_parse_arguments(_csc "" "SOURCE_PATH" "OPTIONS;OPTIONS_DEBUG;OPTIONS_RELEASE;OPTIONS_BUILD;OPTIONS_BUILD_DEBUG;OPTIONS_BUILD_RELEASE;TARGETS" ${ARGN})
    
    # Find waf exectuable
    find_program(WAF_COMMAND NAMES waf PATHS ${SOURCE_PATH})
    if(NOT WAF_COMMAND)
        message(FATAL_ERROR "Unable to find waf executable in current project. Please make sure the file and the waflib folder are available in ${SOURCE_PATH}")
    endif()
	
#    set(ENV{PYTHONIOENCODING} ...)
    set(ENV{PYTHONUTF8} 1)
    set(ENV{PYTHONIOENCODING} UTF-8)
    set(ENV{PYTHONLEGACYWINDOWSSTDIO} 1)
	
	## https://waf.io/apidocs/tools/msvc.html
    # Handle target architecture
    if(${VCPKG_TARGET_ARCHITECTURE} MATCHES "x86")
      set(MSVC_TARGETS "x86")
    elseif(${VCPKG_TARGET_ARCHITECTURE} MATCHES "x64")
      set(MSVC_TARGETS "x64")
    elseif(${VCPKG_TARGET_ARCHITECTURE} MATCHES "arm64")
      set(MSVC_TARGETS "amd64_arm")
    elseif(${VCPKG_TARGET_ARCHITECTURE} MATCHES "arm")
      set(MSVC_TARGETS "x86_arm")
    else()
      message(FATAL_ERROR "Unsupported target architecture")
    endif()

    # MSVC-version not works automatically (vcpkg set the environment such that waf detects the expected msvc version)
    # Handle target PLATFORM
    if(${VCPKG_PLATFORM_TOOLSET} MATCHES "v141")
      set(MSVC_VERSION "msvc 15.0,wsdk 10.0")
    elseif(${VCPKG_PLATFORM_TOOLSET} MATCHES "v140")
      set(MSVC_VERSION "msvc 14.0,wsdk 10.0")
    elseif(${VCPKG_PLATFORM_TOOLSET} MATCHES "arm")
      set(MSVC_VERSION "arm")
    else()
      message(FATAL_ERROR "Unsupported target PLATFORM")
    endif()
	
    # Handle target LIBRARY_LINKAGE
    if(${VCPKG_LIBRARY_LINKAGE} MATCHES "dynamic")
      set(LIBRARY_LINKAGE "dynamic")
    elseif(${VCPKG_LIBRARY_LINKAGE} MATCHES "static")
      set(LIBRARY_LINKAGE "static")
    else()
      message(FATAL_ERROR "Unsupported target LIBRARY")
    endif()

    # Handle target CRT_LINKAGE
    if(${VCPKG_CRT_LINKAGE} MATCHES "dynamic")
      set(CRT_LINKAGE "dynamic")
    elseif(${VCPKG_CRT_LINKAGE} MATCHES "static")
      set(CRT_LINKAGE "static")
    else()
      message(FATAL_ERROR "Unsupported target CRT")
    endif()
	
#    set(CONFIGURE_COMMON_ARGS ${CONFIGURE_COMMON_ARGS} --abi-bits=32)
#elseif(VCPKG_TARGET_ARCHITECTURE STREQUAL "x64")
#    set(CONFIGURE_COMMON_ARGS ${CONFIGURE_COMMON_ARGS} --abi-bits=64)
#	'ARM64' conflicts with target machine type 'x86' but also the parameter address-model=32 and architecture=x86

    # Remove build directories and configuration of previous build
    file(REMOVE_RECURSE "${SOURCE_PATH}/build")
    file(REMOVE "${SOURCE_PATH}/.lock-waf_win32_build")

    # Release configuration
    message(STATUS "Configuring ${TARGET_TRIPLET}-rel...")
	
	set(ENV{PKG_CONFIG_PATH} "${CURRENT_INSTALLED_DIR}/lib/pkgconfig")
	set(ENV{PKG_CONFIG_DIR} "${CURRENT_INSTALLED_DIR}/lib/pkgconfig")
#	set(PYTHON_EXECUTABLE ${CURRENT_INSTALLED_DIR}/python3/python.exe)

	set(ENV{PKG_CONFIG} ${CURRENT_INSTALLED_DIR}/bin/pkg-config)
	set(ENV{PKGCONFIG_EXECUTABLE} ${CURRENT_INSTALLED_DIR}/bin/pkg-config)
	set(ENV{PKG_CONFIG_EXECUTABLE} ${CURRENT_INSTALLED_DIR}/bin/pkg-config)
		
	set(ENV{PATH} ";$ENV{PATH};${CURRENT_INSTALLED_DIR}/bin")
	
    vcpkg_execute_required_process(
        COMMAND ${WAF} configure
#            --build-type=release
            --msvc_targets=${MSVC_TARGETS}
			--msvc_version=${MSVC_VERSION}
#			--crt-linkage=${CRT_LINKAGE}
#			--library-linkage=${LIBRARY_LINKAGE}
            --prefix=${CURRENT_PACKAGES_DIR}
            ${_csc_OPTIONS}
            ${_csc_OPTIONS_RELEASE}
        WORKING_DIRECTORY ${SOURCE_PATH}
        LOGNAME config-${TARGET_TRIPLET}-rel
    )
    message(STATUS "Configuring ${TARGET_TRIPLET}-rel... Done!")
    
    vcpkg_package_waf(
        BUILD_CONFIGURATION release
        OPTIONS_BUILD ${_csc_OPTIONS_BUILD} -vvv
        OPTIONS_BUILD_RELEASE ${_csc_OPTIONS_BUILD_RELEASE}
        TARGETS ${_csc_TARGETS}
    )

    # Debug configuration
    message(STATUS "Configuring ${TARGET_TRIPLET}-dbg...")
	
#	set(ENV{PATH} ";$ENV{PATH};${CURRENT_INSTALLED_DIR}/debug/bin")
	set(ENV{PKG_CONFIG_PATH} "${CURRENT_INSTALLED_DIR}/debug/lib/pkgconfig")
	set(ENV{PKG_CONFIG_DIR} "${CURRENT_INSTALLED_DIR}/debug/lib/pkgconfig")
#	set(PYTHON_EXECUTABLE ${CURRENT_INSTALLED_DIR}/debug/python3/python_d.exe)

	set(ENV{PKG_CONFIG} ${CURRENT_INSTALLED_DIR}/debug/bin/pkg-config)
	set(ENV{PKGCONFIG_EXECUTABLE} ${CURRENT_INSTALLED_DIR}/debug/bin/pkg-config)
	set(ENV{PKG_CONFIG_EXECUTABLE} ${CURRENT_INSTALLED_DIR}/debug/bin/pkg-config)
	
    vcpkg_execute_required_process(
        COMMAND ${WAF} distclean configure
            --build-type=debug
            --msvc_targets=${MSVC_TARGETS}
			--msvc_version=${MSVC_VERSION}
			--crt-linkage=${CRT_LINKAGE}
			--library-linkage=${LIBRARY_LINKAGE}
            --prefix=${CURRENT_PACKAGES_DIR}/debug
            ${_csc_OPTIONS}
            ${_csc_OPTIONS_DEBUG}
        WORKING_DIRECTORY ${SOURCE_PATH}
        LOGNAME config-${TARGET_TRIPLET}-dbg
    )
    message(STATUS "Configuring ${TARGET_TRIPLET}-dbg... Done!")

    vcpkg_package_waf(
        BUILD_CONFIGURATION debug
        OPTIONS_BUILD ${_csc_OPTIONS_BUILD} -vvv
        OPTIONS_BUILD_DEBUG ${_csc_OPTIONS_BUILD_DEBUG}
        TARGETS ${_csc_TARGETS}
    )

endfunction()