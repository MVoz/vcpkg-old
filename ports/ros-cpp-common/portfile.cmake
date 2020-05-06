include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/ros/roscpp_core/archive/99d61b23b7639b80cd8ee8d5238d90a23d21ff4b.zip"
    FILENAME "roscpp_cor.zip"
    SHA512 2911dabd4a21bff2a20a85deae1d74a13290dcc0908358135600c6c270e3c4fce6c51721f73f0e44ac5d6fd3ec976f22f116dbb680a30548f2a3bde630178197
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_find_acquire_program(PYTHON3)
get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
set(PYTHON3_SCRIPTS "${PYTHON3_DIR}/Scripts")
set(ENV{PATH} "$ENV{PATH};${PYTHON3_DIR};${PYTHON3_SCRIPTS}")

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}/cpp_common
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates
    OPTIONS 
	  -DCATKIN_ENABLE_TESTING=OFF
	  -DNOSETESTS:FILEPATH=${PYTHON3_DIR}/Scripts/nosetests.exe
	  -DPYTHON_VERSION=3.7
#	  -DCATKIN_SKIP_TESTING=ON
)

vcpkg_install_cmake()

file(REMOVE 
  ${CURRENT_PACKAGES_DIR}/local_setup.bat
  ${CURRENT_PACKAGES_DIR}/setup.bat
  ${CURRENT_PACKAGES_DIR}/env.bat
  ${CURRENT_PACKAGES_DIR}/_setup_util.py
  ${CURRENT_PACKAGES_DIR}/_setup_util.py.exe
  ${CURRENT_PACKAGES_DIR}/.catkin
  ${CURRENT_PACKAGES_DIR}/.rosinstall
  ${CURRENT_PACKAGES_DIR}/debug/local_setup.bat
  ${CURRENT_PACKAGES_DIR}/debug/setup.bat
  ${CURRENT_PACKAGES_DIR}/debug/env.bat
  ${CURRENT_PACKAGES_DIR}/debug/_setup_util.py
  ${CURRENT_PACKAGES_DIR}/debug/_setup_util.py.exe
  ${CURRENT_PACKAGES_DIR}/debug/.catkin
  ${CURRENT_PACKAGES_DIR}/debug/.rosinstall
)

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
