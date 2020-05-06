include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://bitbucket.org/ignitionrobotics/ign-cmake/get/ignition-cmake2_2.1.1.zip"
    FILENAME "ignition-cmake2_2.1.1.zip"
    SHA512 e3c80d2246b81db8717c93686a0d837ba2ec9a4c95c3b72528d099e96a9f5bd0c4964aea33f5b4c23fda7ea2e724818c58ba52cff147c6960c13400820d92cdc
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

find_program(GIT NAMES git git.cmd)
get_filename_component(GIT_EXE_PATH ${GIT} DIRECTORY)
set(SED_EXE_PATH "${GIT_EXE_PATH}/../usr/bin")

vcpkg_find_acquire_program(PYTHON3)
#vcpkg_find_acquire_program(DOXYGEN) #windows error gen html - path PERL_PATH and MSCGEN_PATH
vcpkg_find_acquire_program(PERL)

get_filename_component(PERL_DIR "${PERL}" DIRECTORY)
#get_filename_component(DOXYGEN_DIR "${DOXYGEN}" DIRECTORY)
get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)

set(ENV{PATH} "$ENV{PATH};${PYTHON3_DIR};${PERL_DIR};${SED_EXE_PATH}") #;${DOXYGEN_DIR}

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates

    OPTIONS 
      -DBUILD_TESTING=OFF
#      -DCPPCHECK_PATH=E:/tools/vcpkg/installed/x64-windows/debug/bin/cppcheck.exe
#      -DEXAMPLE_LCOV_PATH=EXAMPLE_LCOV_PATH-NOTFOUND
#      -DFIND_PATH=C:/Windows/System32/find.exe
      -DPYTHON_PATH=${PYTHON3_DIR}
      -DUSE_FULL_RPATH=OFF
	  -DPERL_PATH=${PERL}
	  -DCMAKE_DISABLE_FIND_PACKAGE_DOXYGEN=ON
	  -DIGNITION_DOXYGEN_GENHTML=NO
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###