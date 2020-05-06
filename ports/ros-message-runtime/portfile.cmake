include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/ros/message_runtime/archive/a0de76d8da977cd4264910d39fecd67af1569897.zip"
    FILENAME "a0de76d8da977cd4264910d39fecd67af1569897.zip"
    SHA512 dda7bc63425425385e744abd00b88d2c1d6711f734a2310d5cf91ebfb3be1709347ad78455efd26ebe29ac9604e51763ae26f8045763d720a81cb6e26814b910
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
