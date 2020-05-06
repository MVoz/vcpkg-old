include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/csound/csound/archive/1e89283016a31242d19e6e857a4d981ffb813f57.zip"
    FILENAME "1e89283016a31242d19e6e857a4d981ffb813f57.zip"
    SHA512 7b04949a8991f76a8e3b89511327e665f8f9f57e271e532aad014db1914a452f0636f3f82f3e48b17cc29c64dba7878d3087442f85248036d2445144c7682cce
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
#    PATCHES
#      001_csound_fixes.patch
#      001_csound_patch.patch
)

vcpkg_find_acquire_program(PYTHON2)
vcpkg_find_acquire_program(SWIG)
#vcpkg_find_acquire_program(TEXLIVE)
vcpkg_find_acquire_program(XGETTEXT)
#vcpkg_find_acquire_program(DOXYGEN)
#vcpkg_find_acquire_program(DOXYGEN)
#vcpkg_find_acquire_program(PERL)
vcpkg_find_acquire_program(FLEX)
vcpkg_find_acquire_program(BISON)
get_filename_component(FLEX_DIR "${FLEX}" DIRECTORY)
get_filename_component(BISON_DIR "${BISON}" DIRECTORY)
#get_filename_component(DOXYGEN_DIR "${DOXYGEN}" DIRECTORY)
#get_filename_component(PERL_DIR "${PERL}" DIRECTORY)
get_filename_component(SWIG_DIR "${SWIG}" DIRECTORY)
get_filename_component(PYTHON2_DIR "${PYTHON2}" DIRECTORY)
#get_filename_component(DOXYGEN_DIR "${DOXYGEN}" DIRECTORY)
get_filename_component(GETTEXT_DIR "${XGETTEXT}" DIRECTORY)
#get_filename_component(TEXLIVE_DIR "${TEXLIVE}" DIRECTORY)
set(ENV{PATH} ";$ENV{PATH};${PYTHON2_DIR};${GETTEXT_DIR};${FLEX_DIR};${BISON_DIR};${SWIG_DIR};${PERL_DIR}")
#vcpkg_find_acquire_program(YASM)
#get_filename_component(YASM_EXE_PATH ${YASM} DIRECTORY)
#set(ENV{PATH} "$ENV{PATH};${YASM_EXE_PATH}")

#get_filename_component(GIT_EXE_PATH ${GIT} DIRECTORY)
#set(SH_EXE_PATH "${GIT_EXE_PATH}/../usr/bin")
#set(ENV{PATH} "$ENV{PATH};${VALAC_DIR};${BISON_DIR};${FLEX_DIR};${SH_EXE_PATH}")

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates
#    GENERATOR "NMake Makefiles" # automatic templates
#    DISABLE_PARALLEL_CONFIGURE
    OPTIONS_DEBUG # automatic templates
      -DDISABLE_INSTALL_HEADERS=ON # automatic templates
      -DINSTALL_HEADERS_TOOLS=OFF
      -DINSTALL_HEADERS=OFF
    OPTIONS_RELEASE 
      -DINSTALL_HEADERS=ON # automatic templates
#      -D =OFF
    OPTIONS 
      -DUSE_ALSA:BOOL=OFF
      -DUSE_ATOMIC_BUILTIN:BOOL=OFF
      -DUSE_AUDIOUNIT:BOOL=ON
      -DUSE_COMPILER_OPTIMIZATIONS:BOOL=ON
      -DUSE_COREMIDI:BOOL=ON
      -DUSE_CURL:BOOL=ON
      -DUSE_DOUBLE:BOOL=ON
      -DUSE_FLTK:BOOL=ON
      -DUSE_GETTEXT:BOOL=OFF
      -DUSE_GIT_COMMIT:BOOL=OFF
      -DUSE_IPMIDI:BOOL=ON
      -DUSE_JACK:BOOL=ON
      -DUSE_LIB64:BOOL=OFF
      -DUSE_LRINT:BOOL=ON
      -DUSE_PORTAUDIO:BOOL=ON
      -DUSE_PORTMIDI:BOOL=ON
      -DUSE_PULSEAUDIO:BOOL=OFF
      -DBUILD_BELA:BOOL=OFF
      -DBUILD_BUCHLA_OPCODES:BOOL=ON
      -DBUILD_CHUA_OPCODES:BOOL=ON
      -DBUILD_CSBEATS:BOOL=ON
      -DBUILD_CUDA_OPCODES:BOOL=OFF
      -DBUILD_CXX_INTERFACE:BOOL=OFF
      -DBUILD_DSSI_OPCODES:BOOL=ON
      -DBUILD_EMUGENS_OPCODES:BOOL=ON
      -DBUILD_EXCITER_OPCODES:BOOL=ON
      -DBUILD_FAUST_OPCODES:BOOL=ON
      -DBUILD_FLUID_OPCODES:BOOL=ON
      -DBUILD_FRAMEBUFFER_OPCODES:BOOL=ON
      -DBUILD_HDF5_OPCODES:BOOL=ON
      -DBUILD_IMAGE_OPCODES:BOOL=ON
      -DBUILD_INSTALLER:BOOL=OFF
      -DBUILD_JACK_OPCODES:BOOL=ON
      -DBUILD_JAVA_INTERFACE:BOOL=OFF
      -DBUILD_LINEAR_ALGEBRA_OPCODES:BOOL=OFF
      -DBUILD_LUA_INTERFACE:BOOL=OFF
      -DBUILD_MULTI_CORE:BOOL=ON
      -DBUILD_OPENCL_OPCODES:BOOL=ON
      -DBUILD_OSC_OPCODES:BOOL=ON
      -DBUILD_P5GLOVE_OPCODES:BOOL=ON
      -DBUILD_PADSYNTH_OPCODES:BOOL=ON
      -DBUILD_PLATEREV_OPCODES:BOOL=ON
      -DBUILD_PVSGENDY_OPCODE:BOOL=OFF
      -DBUILD_PYTHON_INTERFACE:BOOL=OFF
      -DBUILD_PYTHON_OPCODES:BOOL=OFF
      -DBUILD_RELEASE:BOOL=ON
      -DBUILD_SCANSYN_OPCODES:BOOL=ON
      -DBUILD_SELECT_OPCODE:BOOL=ON
      -DBUILD_SERIAL_OPCODES:BOOL=ON
      -DBUILD_STACK_OPCODES:BOOL=ON
      -DBUILD_STATIC_LIBRARY:BOOL=OFF
      -DBUILD_STK_OPCODES:BOOL=ON
      -DBUILD_TESTS:BOOL=OFF
      -DBUILD_UTILITIES:BOOL=OFF
      -DBUILD_VIRTUAL_KEYBOARD:BOOL=ON
      -DBUILD_VST4CS_OPCODES:BOOL=OFF
      -DBUILD_WEBSOCKET_OPCODE:BOOL=OFF #websocketopcode.c(27): fatal error C1083: Cannot open include file: 'sys/param.h': No such file or directory
      -DBUILD_WIIMOTE_OPCODES:BOOL=ON
      -DBUILD_WINSOUND:BOOL=ON
)

vcpkg_install_cmake()

#file(GLOB_RECURSE TMP_FILES "${SOURCE_PATH}/include/*.hin" "${SOURCE_PATH}/include/*.orig" "${SOURCE_PATH}/include/*.in")
#file(REMOVE_RECURSE ${TMP_FILES})

#remove_srcs_file("${SOURCE_PATH}/include/*.hin" "${SOURCE_PATH}/include/*.orig" "${SOURCE_PATH}/include/*.in")

#file(COPY ${SOURCE_PATH}/include DESTINATION ${CURRENT_PACKAGES_DIR}/include)
#file(RENAME ${CURRENT_PACKAGES_DIR}/include/include ${CURRENT_PACKAGES_DIR}/include/openldap)

#file(TO_NATIVE_PATH "${CURRENT_INSTALLED_DIR}/include" PGSQL_INCLUDE_DIR)
#file(COPY ${CURRENT_PACKAGES_DIR}/wpilib/lib/ DESTINATION ${CURRENT_PACKAGES_DIR}/bin FILES_MATCHING PATTERN "*.dll")
#file(COPY ${SOURCE_PATH}/greatest.h DESTINATION ${CURRENT_PACKAGES_DIR}/include)

#vcpkg_fixup_cmake_targets(CONFIG_PATH "lib/cmake/${PORT}")
#vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/nlohmann_json TARGET_PATH share/nlohmann_json)
#file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/bin)
#file(RENAME ${CURRENT_PACKAGES_DIR}/lib/${LIB_NAME}.dll ${CURRENT_PACKAGES_DIR}/bin/${LIB_NAME}.dll
#file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/csound RENAME copyright)

#file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/lib ${CURRENT_PACKAGES_DIR}/debug)
#file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin ${CURRENT_PACKAGES_DIR}/debug/bin ${CURRENT_PACKAGES_DIR}/debug/share ${CURRENT_PACKAGES_DIR}/debug/include)

#file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/tools)
#file(RENAME ${CURRENT_PACKAGES_DIR}/debug/bin ${CURRENT_PACKAGES_DIR}/tools/${PORT})

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/COPYING ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
