include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/ros/std_msgs/archive/a17abc417cde4643ff3b229d1f2a72ca860d0833.zip"
    FILENAME "a17abc417cde4643ff3b229d1f2a72ca860d0833.zip"
    SHA512 205058a2778719800ac8318b04950eab8439fa03d5783c833f161905040a7d1d2420fe02b46b5dfc4e9126a098d09c46a3388c2a45e055eb1a64697541878ddc
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_find_acquire_program(PYTHON3)
get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
set(ENV{PATH} "$ENV{PATH};${PYTHON3_DIR};${PYTHON3_DIR}/Scripts")

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates
    OPTIONS 
	  -DCATKIN_ENABLE_TESTING=OFF
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
