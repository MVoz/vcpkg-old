include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://bitbucket.org/ignitionrobotics/ign-math/get/ignition-math5_5.0.0.zip"
    FILENAME "ignition-math5_5.0.0.zip"
    SHA512 15ed42c8e60ecd5c86b3d849207bd752e8d535d75b4821ed788dbd9d6b70a537cae608dd3ee42e41868a5042909801d614fa1560e380faaf44c0da86de4b9cc7
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
#      -DCPPCHECK_PATH:FILEPATH=E:/tools/vcpkg/installed/x64-windows/debug/bin/cppcheck.exe
#      -DFIND_PATH:FILEPATH=C:/Windows/System32/find.exe
#      -DGZIP:FILEPATH=E:/tools/Bin/BusyBox/gzip.exe
#      -DIGN_USE_STATIC_RUNTIME=OFF
#      -DRONN:FILEPATH=RONN-NOTFOUND
      -DUSE_FULL_RPATH=OFF
      -DUSE_IGN_RECOMMENDED_FLAGS=ON
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
