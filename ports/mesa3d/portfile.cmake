include(vcpkg_common_functions)

vcpkg_find_acquire_program(FLEX)
vcpkg_find_acquire_program(BISON)
vcpkg_find_acquire_program(PYTHON2)
vcpkg_find_acquire_program(SCONS)
vcpkg_find_acquire_program(DOXYGEN)

#питон не находит зависимости, пришлось добавить все
get_filename_component(PYTHON2_DIR "${PYTHON2}" DIRECTORY)
get_filename_component(FLEX_DIR "${FLEX}" DIRECTORY)
get_filename_component(BISON_DIR "${BISON}" DIRECTORY)
get_filename_component(DOXYGEN_DIR "${DOXYGEN}" DIRECTORY)
get_filename_component(SCONS_DIR "${SCONS}" DIRECTORY)

#vcpkg_add_to_path("${PYTHON2_DIR};${FLEX_DIR};${BISON_DIR};${DOXYGEN_DIR};${SCONS_DIR}")
set(ENV{PATH} "$ENV{PATH};${PYTHON2_DIR};${FLEX_DIR};${BISON_DIR};${DOXYGEN_DIR};${SCONS_DIR}")

if(NOT EXISTS ${PYTHON2_DIR}/easy_install${EXECUTABLE_SUFFIX})
    if(NOT EXISTS ${PYTHON2_DIR}/Scripts/pip${EXECUTABLE_SUFFIX})
        vcpkg_download_distfile(GET_PIP
            URLS "https://bootstrap.pypa.io/get-pip.py" #постоянная ссылка SHA может постоянно меняться ##SKIP_SHA512
            FILENAME "tools/python/python2/get-pip.py"
#            SHA512 99520d223819708b8f6e4b839d1fa215e4e8adc7fcd0db6c25a0399cf2fa10034b35673cf450609303646d12497f301ef53b7e7cc65c78e7bce4af0c673555ad
			SKIP_SHA512
        )
        execute_process(COMMAND ${PYTHON2_DIR}/python${EXECUTABLE_SUFFIX} ${PYTHON2_DIR}/get-pip.py)
    endif()
    execute_process(COMMAND ${PYTHON2_DIR}/Scripts/pip${EXECUTABLE_SUFFIX} install -U Mako)
else()
    execute_process(COMMAND ${PYTHON2_DIR}/easy_install${EXECUTABLE_SUFFIX} Mako)
endif()


vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/mesa3d/mesa/archive/8d621e8ff72c0439d08450425fbf0cda23232f39.zip"
    FILENAME "8d621e8ff72c0439d08450425fbf0cda23232f39.zip"
    SHA512 97733b1c98cf0c624a8afb6923e1e58be19535cf35420fc6608bff11dad691308e0e2c2828ee2fdf60c3e8df0d732bffe109007450f8d4f5c0f12d030d4ffc9d
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE} 
)

set(machine ${TRIPLET_SYSTEM_ARCH})
if(${TRIPLET_SYSTEM_ARCH} STREQUAL x64)
    set(machine x86_64)
endif()

# This build release
vcpkg_execute_required_process(
	SOURCE_PATH ${SOURCE_PATH}
    COMMAND ${SCONS} 
		platform=windows #platform: target platform (cygwin|darwin|freebsd|haiku|linux|sunos|windows)
		build=release #build type (debug|checked|profile|release)
		verbose=yes #verbose output (yes|no)
		machine=x86_64 #machine-specific assembly code (generic|ppc|x86|x86_64)
		MSVC_VERSION=14.1
#		embedded: embedded build (yes|no)
#		analyze: enable static code analysis where available (yes|no)
#		asan: enable Address Sanitizer (yes|no)
#		toolchain: compiler toolchain
#		llvm: use LLVM (yes|no)
#		openmp: EXPERIMENTAL: compile with openmp (swrast) (yes|no)
#		debug: DEPRECATED: debug build (yes|no)
#		profile: DEPRECATED: profile build (yes|no)
#		quiet: DEPRECATED: profile build (yes|no)
#		swr: Build OpenSWR (yes|no)
#		MSVC_VERSION: Microsoft Visual C/C++ version
#		MSVC_USE_SCRIPT: Microsoft Visual C/C++ vcvarsall script, default: True
		llvm=0
		libgl-gdi
		
#Recognized targets:

#    libgl-gdi
#    check
#    gallium
#    glcpp
#    glsl_compiler
#    graw-gdi
#    graw-progs
#    mesa
#    mesa-sha1_test
#    mesautil
#    nir
#    opengl32
#    osmesa
#    pipe_barrier_test
#    pipe_loader
#    roundeven_test
#    softpipe
#    spirv
#    svga
#    u_atomic_test
#    u_format_compatible_test
#    u_format_test
#    u_half_test
#    ws_gdi
#    ws_null


#		build=debug
#		PREFIX=${CURRENT_PACKAGES_DIR}
#		LIBDIR=${CURRENT_PACKAGES_DIR}/lib

#		MSVC_VERSION=14.1
    WORKING_DIRECTORY ${SOURCE_PATH}
    LOGNAME release-${TARGET_TRIPLET}.log
)



# Handle copyright
# file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/mesa3d RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME mesa3d)
