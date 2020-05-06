include(vcpkg_common_functions)

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/swig/swig/archive/c48d11ac17f04038b617cc44c2a44c0d09041267.zip"
    FILENAME "c48d11ac17f04038b617cc44c2a44c0d09041267.zip"
    SHA512 73140da253f6ccac57f9ac1e3eba4283b1ceb95bd1605a9f7ec709902f341c491d08164c7512c62ba52f0588fcdb1e70cff80b830bfeaef1e0db6a9a9569f9a1
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

find_program(JAVA NAMES java javac)
vcpkg_find_acquire_program(PYTHON3)
vcpkg_find_acquire_program(PERL)
vcpkg_find_acquire_program(RUBY)
vcpkg_find_acquire_program(BISON)

get_filename_component(BISON_DIR "${BISON}" DIRECTORY)
get_filename_component(PERL_DIR "${PERL}" DIRECTORY)
get_filename_component(RUBY_DIR "${RUBY}" DIRECTORY)
get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
get_filename_component(JAVA_DIR "${JAVA}" DIRECTORY)

set(ENV{PATH} "$ENV{PATH};${PYTHON3_DIR};${PERL_DIR};${BISON_DIR};${RUBY_DIR}")

#get_filename_component(GIT_EXE_PATH ${GIT} DIRECTORY)
#set(SH_EXE_PATH "${GIT_EXE_PATH}/../usr/bin")
#set(ENV{PATH} "$ENV{PATH};${VALAC_DIR};${BISON_DIR};${FLEX_DIR};${SH_EXE_PATH}")

#JAVA_INCLUDE : Set this to the directory containing jni.h #JAVA_INCLUDE: D:\jdk1.3\include
#JAVA_BIN : Set this to the bin directory containing javac.exe #JAVA_BIN: D:\jdk1.3\bin

#PERL5_INCLUDE : Set this to the directory containing perl.h #PERL5_INCLUDE: D:\nsPerl5.004_04\lib\CORE
#PERL5_LIB : Set this to the Perl library including path for linking #PERL5_LIB: D:\nsPerl5.004_04\lib\CORE\perl.lib

#PYTHON_INCLUDE : Set this to the directory that contains Python.h #PYTHON_INCLUDE: D:\python21\include
#PYTHON_LIB : Set this to the Python library including path for linking #PYTHON_LIB: D:\python21\libs\python21.lib

#TCL_INCLUDE : Set this to the directory containing tcl.h #TCL_INCLUDE: D:\tcl\include
#TCL_LIB : Set this to the TCL library including path for linking #TCL_LIB: D:\tcl\lib\tcl83.lib

#R_INCLUDE : Set this to the directory containing R.h #R_INCLUDE: C:\Program Files\R\R-2.5.1\include
#R_LIB : Set this to the R library (Rdll.lib) including path for linking. The library needs to be built as described in the R README.packages file (the pexports.exe approach is the easiest). #R_LIB: C:\Program Files\R\R-2.5.1\bin\Rdll.lib

#RUBY_INCLUDE : Set this to the directory containing ruby.h #RUBY_INCLUDE: D:\ruby\lib\ruby\1.6\i586-mswin32
#RUBY_LIB : Set this to the ruby library including path for linking #RUBY_LIB: D:\ruby\lib\mswin32-ruby16.lib

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates

    OPTIONS 
      -DBISON_EXECUTABLE=${BISON}
      -DPYTHON_INCLUDE=${PYTHON3_DIR}/include
      -DPYTHON_LIB=${PYTHON3_DIR}/libs/python37.lib
      -DPERL5_INCLUDE=${PERL_DIR}/lib/CORE
      -DPERL5_LIB=${PERL_DIR}/lib/CORE/perl.lib
      -DJAVA_INCLUDE=${JAVA_DIR}/include
      -DJAVA_BIN=${JAVA_DIR}/bin
#      -DRUBY_INCLUDE=${RUBY_DIR}
#      -DRUBY_LIB=${RUBY_DIR}
#      -DR_INCLUDE=${R_DIR}
#      -DR_LIB=${R_DIR}
#      -DTCL_INCLUDE=${TCL_DIR}
#      -DTCL_LIB=${TCL_DIR}
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
#file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/swig RENAME copyright)

#file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/lib ${CURRENT_PACKAGES_DIR}/debug)
#file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin ${CURRENT_PACKAGES_DIR}/debug/bin ${CURRENT_PACKAGES_DIR}/debug/share ${CURRENT_PACKAGES_DIR}/debug/include)

#file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/tools)
#file(RENAME ${CURRENT_PACKAGES_DIR}/debug/bin ${CURRENT_PACKAGES_DIR}/tools/${PORT})

#vcpkg_copy_tool_dependencies(${CURRENT_PACKAGES_DIR}/tools/openexr)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME swig)

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
