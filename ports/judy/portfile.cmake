include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/wanderlustzoe/hashOrJudy/archive/bc6a3e1f1552b0cc2eaf5513469eef3980db4e65.zip"
    FILENAME "bc6a3e1f1552b0cc2eaf5513469eef3980db4e65.zip"
    SHA512 b986d26bf6602bd1c2e3c5255492d7462e607b7060998ca9a3aeeadd517bbde7a1214a0acbf23c52fbb2d32d941e672de1d0854645b9b8f9e6b544014bc1b6b6
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

#get_filename_component(GIT_EXE_PATH ${GIT} DIRECTORY)
#set(SH_EXE_PATH "${GIT_EXE_PATH}/../usr/bin")
#set(ENV{PATH} "$ENV{PATH};${VALAC_DIR};${BISON_DIR};${FLEX_DIR};${SH_EXE_PATH}")

#file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH})

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH} #/JudyL
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
#    OPTIONS 
#      -D =OFF # automatic templates
)

vcpkg_install_cmake()

### https://mesonbuild.com/Configuring-a-build-directory.html
#vcpkg_configure_meson(
#    SOURCE_PATH ${SOURCE_PATH}
#    OPTIONS
#      --backend=ninja
#)

#vcpkg_install_meson()

###
#msbuild build-package.proj /t:Clean;BeforeBuild
#msbuild build.proj /t:Build
#msbuild build-package.proj /t:PreparePackage;Package

#vcpkg_install_msbuild(
#    SOURCE_PATH ${SOURCE_PATH}
#    PROJECT_SUBPATH "ide/vs2017/mimalloc.vcxproj"
#    TARGET restore
#    SKIP_CLEAN
#    RELEASE_CONFIGURATION Release_x86${MPG123_CONFIGURATION_SUFFIX}
#    DEBUG_CONFIGURATION Debug_x86${MPG123_CONFIGURATION_SUFFIX}
#    LICENSE_SUBPATH LICENSE
#    ALLOW_ROOT_INCLUDES ON
#    USE_VCPKG_INTEGRATION
#)

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
#file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/judy RENAME copyright)

#file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/lib ${CURRENT_PACKAGES_DIR}/debug)
#file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin ${CURRENT_PACKAGES_DIR}/debug/bin ${CURRENT_PACKAGES_DIR}/debug/share ${CURRENT_PACKAGES_DIR}/debug/include)

#file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/tools)
#file(RENAME ${CURRENT_PACKAGES_DIR}/debug/bin ${CURRENT_PACKAGES_DIR}/tools/${PORT})

#vcpkg_copy_tool_dependencies(${CURRENT_PACKAGES_DIR}/tools/openexr)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME judy)

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
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
