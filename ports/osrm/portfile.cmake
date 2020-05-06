include(vcpkg_common_functions)

#vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/Project-OSRM/osrm-backend/archive/f520379419aa2d5f11b6c0dfa25fb16967f63e04.zip"
    FILENAME "f520379419aa2d5f11b6c0dfa25fb16967f63e04.zip"
    SHA512 1ddcacda6fa0b7726f562f772d62d0f23e8ba844e16a2f9ca4733b2bdd87d824b53507f518388d0de297f6407a6953479f451907180dcb4951a34dedf1df6225
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
#    PATCHES
#      001_osrm_fixes.patch
#      001_osrm_patch.patch
)

#set(VCPKG_FORTRAN_ENABLED ON)
#vcpkg_enable_fortran(intel)

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
      -DBUILD_PACKAGE:BOOL=OFF
      -DBUILD_TOOLS:BOOL=ON
      -DENABLE_ASSERTIONS:BOOL=OFF
#      -DENABLE_CCACHE:BOOL=ON
      -DENABLE_COVERAGE:BOOL=OFF
      -DENABLE_FUZZING:BOOL=OFF
      -DENABLE_GLIBC_WORKAROUND:BOOL=OFF
      -DENABLE_GOLD_LINKER:BOOL=ON
      -DENABLE_LTO:BOOL=OFF
      -DENABLE_MASON:BOOL=OFF
      -DENABLE_NODE_BINDINGS:BOOL=OFF
      -DENABLE_SANITIZER:BOOL=OFF
      -DENABLE_STXXL:BOOL=OFF
      -DFLATBUFFERS_BUILD_FLATC:BOOL=ON
      -DFLATBUFFERS_BUILD_FLATHASH:BOOL=ON
      -DFLATBUFFERS_BUILD_FLATLIB:BOOL=ON
      -DFLATBUFFERS_BUILD_GRPCTEST:BOOL=OFF
      -DFLATBUFFERS_BUILD_SHAREDLIB:BOOL=ON
      -DFLATBUFFERS_BUILD_TESTS:BOOL=OFF
      -DFLATBUFFERS_CODE_COVERAGE:BOOL=OFF
      -DFLATBUFFERS_CODE_SANITIZE:BOOL=OFF
      -DFLATBUFFERS_INSTALL:BOOL=ON
      -DFLATBUFFERS_LIBCXX_WITH_CLANG:BOOL=ON
      -DFLATBUFFERS_PACKAGE_DEBIAN:BOOL=OFF
      -DFLATBUFFERS_PACKAGE_REDHAT:BOOL=OFF
#      -DLUA_INCLUDE_PREFIX:PATH=E:/tools/vcpkg/installed/x64-windows
#      -DOSMIUM_WARNING_OPTIONS:STRING=/W3 /wd4514
#      -Dws2_32_LIBRARY_PATH:FILEPATH=C:/Program Files (x86)/Windows Kits/10/Lib/10.0.17763.0/um/x64/WS2_32.Lib
)

vcpkg_install_cmake(DISABLE_PARALLEL)

#file(GLOB_RECURSE TMP_FILES "${SOURCE_PATH}/include/*.hin" "${SOURCE_PATH}/include/*.orig" "${SOURCE_PATH}/include/*.in")
#file(REMOVE_RECURSE ${TMP_FILES})

#remove_srcs_file("${SOURCE_PATH}/include/*.hin" "${SOURCE_PATH}/include/*.orig" "${SOURCE_PATH}/include/*.in")

#file(COPY "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/Debug*" DESTINATION ${SOURCE_PATH_TCL}/win)
#file(TO_NATIVE_PATH "${CURRENT_INSTALLED_DIR}/include" PGSQL_INCLUDE_DIR)


#file(COPY ${SOURCE_PATH}/include DESTINATION ${CURRENT_PACKAGES_DIR}/include)
#file(RENAME ${CURRENT_PACKAGES_DIR}/include/include ${CURRENT_PACKAGES_DIR}/include/openldap)

#file(COPY ${CURRENT_PACKAGES_DIR}/wpilib/lib/ DESTINATION ${CURRENT_PACKAGES_DIR}/bin FILES_MATCHING PATTERN "*.dll")
#file(COPY ${SOURCE_PATH}/greatest.h DESTINATION ${CURRENT_PACKAGES_DIR}/include)

#vcpkg_fixup_cmake_targets(CONFIG_PATH "lib/cmake/${PORT}")
#vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/nlohmann_json TARGET_PATH share/nlohmann_json)
#file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/bin)
#file(RENAME ${CURRENT_PACKAGES_DIR}/lib/${LIB_NAME}.dll ${CURRENT_PACKAGES_DIR}/bin/${LIB_NAME}.dll
#file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/osrm RENAME copyright)

#file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/lib ${CURRENT_PACKAGES_DIR}/debug)
#file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin ${CURRENT_PACKAGES_DIR}/debug/bin ${CURRENT_PACKAGES_DIR}/debug/share ${CURRENT_PACKAGES_DIR}/debug/include)

#file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/tools)
#file(RENAME ${CURRENT_PACKAGES_DIR}/debug/bin ${CURRENT_PACKAGES_DIR}/tools/${PORT})

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
