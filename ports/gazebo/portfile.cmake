include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "http://osrf-distributions.s3.amazonaws.com/gazebo/releases/gazebo-8.2.0.tar.bz2"
    FILENAME "gazebo-8.2.0.tar.bz2"
    SHA512 d2561a6e5460ea068d9c84945e5955d986bc1f6f0d1ba16100aae53015c6e11da3a152ac6ecb906147d37261d4c680025bcc5f5587c6c09f127319dc184cf843
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
#    PATCHES
#      001_gazebo_fixes.patch
#      001_gazebo_patch.patch
)

set(VCPKG_FORTRAN_ENABLED ON)
vcpkg_enable_fortran(intel)

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

#get_filename_component(GIT_EXE_PATH ${GIT} DIRECTORY)
#set(SH_EXE_PATH "${GIT_EXE_PATH}/../usr/bin")
#set(ENV{PATH} "$ENV{PATH};${VALAC_DIR};${BISON_DIR};${FLEX_DIR};${SH_EXE_PATH}")

#file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH})

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates

    OPTIONS 
      -DHAVE_GDAL:BOOL=OFF
      -DHAVE_GRAPHVIZ:BOOL=OFF
      -DHAVE_OCULUS:BOOL=OFF
      -DHAVE_OPENAL:BOOL=OFF
      -DHAVE_USB:BOOL=OFF
#      -DHDF5_DIR:PATH=E:/tools/vcpkg/installed/x64-windows/cmake
      -DINCLUDE_PLAYER:BOOL=OFF
      -DINCLUDE_RTSHADER:BOOL=OFF
#      -DOSVR_CLIENTKIT_HEADER:FILEPATH=OSVR_CLIENTKIT_HEADER-NOTFOUND
#      -DOSVR_CLIENTKIT_LIBRARY:FILEPATH=OSVR_CLIENTKIT_LIBRARY-NOTFOUND
#      -DPROFILER:FILEPATH=PROFILER-NOTFOUND
#      -DProtobuf_SRC_ROOT_FOLDER:PATH=Protobuf_SRC_ROOT_FOLDER-NOTFOUND
#      -DRONN:FILEPATH=RONN-NOTFOUND
#      -DSDFormat_DIR:PATH=SDFormat_DIR-NOTFOUND
#      -DSPNAV_HEADER:FILEPATH=SPNAV_HEADER-NOTFOUND
#      -DSPNAV_LIBRARY:FILEPATH=SPNAV_LIBRARY-NOTFOUND
#      -DSimbody_DIR:PATH=Simbody_DIR-NOTFOUND
#      -DTCMALLOC:FILEPATH=TCMALLOC-NOTFOUND
#      -DVALGRIND_PROGRAM:FILEPATH=E:/tools/vcpkg/installed/x64-windows/bin/path.exe

#      -DXSLTPROC:FILEPATH=E:/tools/vcpkg/installed/x64-windows/bin/xsltproc.exe

#      -Dignition-math3_DIR:PATH=ignition-math3_DIR-NOTFOUND
#      -Dignition-msgs0_DIR:PATH=ignition-msgs0_DIR-NOTFOUND
#      -Dignition-transport3_DIR:PATH=ignition-transport3_DIR-NOTFOUND

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
#file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/gazebo RENAME copyright)

#file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/lib ${CURRENT_PACKAGES_DIR}/debug)
#file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin ${CURRENT_PACKAGES_DIR}/debug/bin ${CURRENT_PACKAGES_DIR}/debug/share ${CURRENT_PACKAGES_DIR}/debug/include)

#file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/tools)
#file(RENAME ${CURRENT_PACKAGES_DIR}/debug/bin ${CURRENT_PACKAGES_DIR}/tools/${PORT})

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
