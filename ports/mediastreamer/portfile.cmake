include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://www.linphone.org/releases/sources/mediastreamer/mediastreamer-2.16.1.tar.gz"
    FILENAME "mediastreamer-2.16.1.tar.gz"
    SHA512 44b3a5092aedf65b5503c7843c88e4acc2d0e72093a4f057440355c281135a17c898c1c01438e372bf7c8ae2f30a79ad8a59315f3f3d9b914599a185e90fbe81
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

#vcpkg_find_acquire_program(PYTHON3)
#vcpkg_find_acquire_program(QT5)
#vcpkg_find_acquire_program(TEXLIVE)
#vcpkg_find_acquire_program(XGETTEXT)
#vcpkg_find_acquire_program(DOXYGEN)
#vcpkg_find_acquire_program(DOXYGEN)
#vcpkg_find_acquire_program(PERL)
#vcpkg_find_acquire_program(FLEX)
#vcpkg_find_acquire_program(BISON)
#get_filename_component(FLEX_DIR "${FLEX}" DIRECTORY)
#get_filename_component(BISON_DIR "${BISON}" DIRECTORY)
#get_filename_component(DOXYGEN_DIR "${DOXYGEN}" DIRECTORY)
#get_filename_component(PERL_DIR "${PERL}" DIRECTORY)
#get_filename_component(QT5_DIR "${QT5}" DIRECTORY)
#get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
#get_filename_component(DOXYGEN_DIR "${DOXYGEN}" DIRECTORY)
#get_filename_component(XGETTEXT_DIR "${XGETTEXT}" DIRECTORY)
#get_filename_component(TEXLIVE_DIR "${TEXLIVE}" DIRECTORY)
#set(ENV{PATH} ";$ENV{PATH};${QT5_DIR};${PYTHON3_DIR};${DOXYGEN_DIR};${XGETTEXT_DIR};${TEXLIVE_DIR};${FLEX_DIR};${BISON_DIR};${DOXYGEN_DIR};${PERL_DIR}")
#vcpkg_find_acquire_program(YASM)
#get_filename_component(YASM_EXE_PATH ${YASM} DIRECTORY)
#set(ENV{PATH} "$ENV{PATH};${YASM_EXE_PATH}")

find_program(GIT NAMES git git.cmd)
get_filename_component(GIT_EXE_PATH ${GIT} DIRECTORY)
set(AWK_EXE_PATH "${GIT_EXE_PATH}/../usr/bin")
set(ENV{PATH} "$ENV{PATH};${AWK_EXE_PATH}")


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
	
      -DENABLE_SHARED:BOOL=ON
	
      -DENABLE_BV16:BOOL=OFF
      -DENABLE_DEBUG_LOGS:BOOL=OFF
      -DENABLE_DOC:BOOL=OFF
      -DENABLE_FFMPEG:BOOL=ON
      -DENABLE_FIXED_POINT:BOOL=OFF
      -DENABLE_G726:BOOL=OFF
      -DENABLE_G729:BOOL=OFF
      -DENABLE_G729B_CNG:BOOL=OFF
      -DENABLE_G729_CNG:BOOL=OFF
      -DENABLE_GL:BOOL=OFF
      -DENABLE_GSM:BOOL=OFF
      -DENABLE_JPEG:BOOL=OFF
      -DENABLE_MKV:BOOL=OFF
      -DENABLE_NON_FREE_CODECS:BOOL=OFF
      -DENABLE_OPUS:BOOL=OFF
      -DENABLE_PCAP:BOOL=OFF
      -DENABLE_PORTAUDIO:BOOL=OFF
      -DENABLE_PULSEAUDIO:BOOL=OFF
      -DENABLE_QNX:BOOL=OFF
      -DENABLE_QSA:BOOL=OFF
      -DENABLE_RELATIVE_PREFIX:BOOL=OFF
      -DENABLE_RESAMPLE:BOOL=OFF
      -DENABLE_SDL:BOOL=OFF
      -DENABLE_SOUND:BOOL=OFF
      -DENABLE_SPEEX_CODEC:BOOL=OFF
      -DENABLE_SPEEX_DSP:BOOL=OFF
      -DENABLE_SRTP:BOOL=OFF
      -DENABLE_STATIC:BOOL=OFF
      -DENABLE_STRICT:BOOL=OFF
      -DENABLE_THEORA:BOOL=OFF
      -DENABLE_TOOLS:BOOL=OFF
      -DENABLE_UNIT_TESTS:BOOL=OFF
      -DENABLE_VIDEO:BOOL=OFF
      -DENABLE_VPX:BOOL=OFF
      -DENABLE_VT_H264:BOOL=OFF
      -DENABLE_ZRTP:BOOL=OFF
#      -DLIBGCC:FILEPATH=LIBGCC-NOTFOUND
#      -DLIBM:FILEPATH=LIBM-NOTFOUND
#      -DLIBMINGWEX:FILEPATH=LIBMINGWEX-NOTFOUND
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
#file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/mediastreamer RENAME copyright)

#file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/lib ${CURRENT_PACKAGES_DIR}/debug)
#file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin ${CURRENT_PACKAGES_DIR}/debug/bin ${CURRENT_PACKAGES_DIR}/debug/share ${CURRENT_PACKAGES_DIR}/debug/include)

#file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/tools)
#file(RENAME ${CURRENT_PACKAGES_DIR}/debug/bin ${CURRENT_PACKAGES_DIR}/tools/${PORT})

#vcpkg_copy_tool_dependencies(${CURRENT_PACKAGES_DIR}/tools/openexr)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME mediastreamer)

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

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/COPYING ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
