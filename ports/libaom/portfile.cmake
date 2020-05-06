include(vcpkg_common_functions)

find_program(GIT NAMES git git.cmd)
set(GIT_URL "https://aomedia.googlesource.com/aom")
set(GIT_REV 9666276accea505cd14cbcb9e3f7ff5033da9172)
set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/${PORT})
if(NOT EXISTS "${SOURCE_PATH}/.git")
    message(STATUS "Cloning and fetching submodules")
    vcpkg_execute_required_process(
      COMMAND ${GIT} clone --recurse-submodules ${GIT_URL} ${SOURCE_PATH}
      WORKING_DIRECTORY ${SOURCE_PATH}
      LOGNAME clone
    )
    message(STATUS "Checkout revision ${GIT_REV}")
    vcpkg_execute_required_process(
      COMMAND ${GIT} checkout ${GIT_REV}
      WORKING_DIRECTORY ${SOURCE_PATH}
      LOGNAME checkout
    )
endif()

vcpkg_find_acquire_program(PERL)
vcpkg_find_acquire_program(YASM)

get_filename_component(PERL_DIR "${PERL}" DIRECTORY)
get_filename_component(YASM_EXE_PATH ${YASM} DIRECTORY)
set(ENV{PATH} "$ENV{PATH};${YASM_EXE_PATH};${PERL_DIR}")

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates

    OPTIONS 
      -DAS_EXECUTABLE=${YASM} #or -DENABLE_NASM=ON ${NASM}
      -DCONFIG_SHARED:STRING=1
      -DCONFIG_STATIC:STRING=0
#      -DENABLE_AVX=ON
#      -DENABLE_AVX2=ON
      -DENABLE_CCACHE=OFF
      -DENABLE_DECODE_PERF_TESTS=OFF
#      -DENABLE_DISTCC=OFF
      -DENABLE_DOCS=OFF
#      -DENABLE_DSPR2=OFF
#      -DENABLE_ENCODE_PERF_TESTS=OFF
      -DENABLE_EXAMPLES=OFF
#      -DENABLE_GOMA=OFF
#      -DENABLE_IDE_TEST_HOSTING=OFF
#      -DENABLE_MMX=ON
#      -DENABLE_MSA=OFF
      -DENABLE_NASM=OFF
#      -DENABLE_NEON=ON
#      -DENABLE_SSE=ON
#      -DENABLE_SSE2=ON
#      -DENABLE_SSE3=ON
#      -DENABLE_SSE4_1=ON
#      -DENABLE_SSE4_2=ON
#      -DENABLE_SSSE3=ON
      -DENABLE_TESTDATA=OFF
      -DENABLE_TESTS=OFF
      -DENABLE_TOOLS=OFF
      -DENABLE_VSX=ON
      -DENABLE_WERROR=OFF
)

vcpkg_install_cmake()

#install(
#    TARGETS ${PROJECT} 
#    EXPORT ${PROJECT}-export
#    RUNTIME DESTINATION ${BINARY_INSTALL_DIR}
#    LIBRARY DESTINATION ${LIBRARY_INSTALL_DIR}
#    ARCHIVE DESTINATION ${LIBRARY_INSTALL_DIR}
#    BUNDLE DESTINATION .
##    FRAMEWORK DESTINATION ${FRAMEWORK_INSTALL_DIR}
##    PUBLIC_HEADER DESTINATION ${INCLUDE_INSTALL_DIR}/qjson${QJSON_SUFFIX}
#)

#https://packages.debian.org/sid/amd64/libaom-dev/filelist

Список файлов пакета libaom-dev в sid для архитектуры amd64

/usr/include/aom/aom.h
/usr/include/aom/aom_codec.h
/usr/include/aom/aom_decoder.h
/usr/include/aom/aom_encoder.h
/usr/include/aom/aom_frame_buffer.h
/usr/include/aom/aom_image.h
/usr/include/aom/aom_integer.h
/usr/include/aom/aomcx.h
/usr/include/aom/aomdx.h
/usr/lib/x86_64-linux-gnu/libaom.so
/usr/lib/x86_64-linux-gnu/pkgconfig/aom.pc
/usr/share/doc/libaom-dev/changelog.Debian.gz
/usr/share/doc/libaom-dev/changelog.gz
/usr/share/doc/libaom-dev/copyright


set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
