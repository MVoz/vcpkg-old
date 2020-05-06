include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://bitbucket.org/ignitionrobotics/ign-common/get/ignition-common3_3.3.0.zip"
    FILENAME "ignition-common3_3.3.0.zip"
    SHA512 5a63e512d903ea0a4379436357cbc093815074da12ed2ff44b6cbb10aaba187ae6153afba993147dc41b83cd7d5dab626456d25448dcdd2673c6efcad994c814
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

find_program(GIT NAMES git git.cmd)
get_filename_component(GIT_EXE_PATH ${GIT} DIRECTORY)
set(SED_EXE_PATH "${GIT_EXE_PATH}/../usr/bin")

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

set(ENV{PATH} "$ENV{PATH};${SWIG_DIR};${RUBY_DIR};${PYTHON3_DIR};${PERL_DIR};${SED_EXE_PATH}") #;${DOXYGEN_DIR}

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates
    OPTIONS 
      -DBUILD_TESTING=OFF
#      -DCPPCHECK_PATH:FILEPATH=E:/tools/vcpkg/installed/x64-windows/bin/cppcheck.exe
#      -DFIND_PATH:FILEPATH=C:/Windows/System32/find.exe
      -DIGN_BUILD_SYMLINK_TESTS_ON_WINDOWS=OFF
      -DIGN_PROFILER_REMOTERY=OFF
      -DIGN_USE_STATIC_RUNTIME=OFF
      -DUSE_FULL_RPATH=OFF
      -DUSE_IGN_RECOMMENDED_FLAGS=ON
	  -DPERL_EXECUTABLE=${PERL}
      -DPYTHON_PATH=${PYTHON3_DIR}
	  -DPERL_PATH=${PERL}
	  -DCMAKE_DISABLE_FIND_PACKAGE_DOXYGEN=ON
	  -DIGNITION_DOXYGEN_GENHTML=NO
      -DGZIP:FILEPATH=${SED_EXE_PATH}/gzip.exe
      -DRONN:FILEPATH=${RUBY_DIR}/ronn
      -DRUBY:FILEPATH=${RUBY}
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
