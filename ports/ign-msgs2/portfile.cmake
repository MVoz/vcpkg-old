include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://bitbucket.org/ignitionrobotics/ign-msgs/get/ignition-msgs2_2.1.0.zip"
    FILENAME "ignition-msgs2_2.1.0.zip"
    SHA512 829face0f329520685023fa229766f244635a94a240da387c67c29e80a2fbc6d1576030e3c2f194df4a8d7b6b17d9e6407eea9f8926b7ffe8a952c64b611e2a3
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_find_acquire_program(PYTHON3)
vcpkg_find_acquire_program(SWIG)
vcpkg_find_acquire_program(RUBY)
#vcpkg_find_acquire_program(DOXYGEN)
vcpkg_find_acquire_program(PERL)

get_filename_component(PERL_DIR "${PERL}" DIRECTORY)
#vcpkg_find_acquire_program(DOXYGEN) #windows error gen html - path PERL_PATH and MSCGEN_PATH
get_filename_component(RUBY_DIR "${RUBY}" DIRECTORY)
get_filename_component(SWIG_DIR "${SWIG}" DIRECTORY)
get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)

set(SED_EXE_PATH "${RUBY_DIR}/../msys32/usr/bin")

set(ENV{PATH} "$ENV{PATH};${SWIG_DIR};${RUBY_DIR};${PYTHON3_DIR};${PERL_DIR};${SED_EXE_PATH}") #;${DOXYGEN_DIR}

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates

    OPTIONS 
      -DBUILD_TESTING=OFF
#      -DCPPCHECK_PATH:FILEPATH=E:/tools/vcpkg/installed/x64-windows/bin/cppcheck.exe
#      -DFIND_PATH:FILEPATH=C:/Windows/System32/find.exe
#      -DGZIP:FILEPATH=E:/tools/Bin/BusyBox/gzip.exe
#      -DIGN_USE_STATIC_RUNTIME=OFF
#      -DRONN:FILEPATH=RONN-NOTFOUND
      -DUSE_FULL_RPATH=OFF
      -DUSE_IGN_RECOMMENDED_FLAGS=ON
#      -Dignition-tools_DIR:PATH=ignition-tools_DIR-NOTFOUND
	  -DPERL_EXECUTABLE=${PERL}
      -DPYTHON_PATH=${PYTHON3_DIR}
	  -DPERL_PATH=${PERL}
	  -DCMAKE_DISABLE_FIND_PACKAGE_DOXYGEN=ON
	  -DIGNITION_DOXYGEN_GENHTML=NO
	  -DENABLE_TESTS_COMPILATION=false
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
