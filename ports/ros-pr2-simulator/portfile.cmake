include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/PR2/pr2_simulator/archive/7ac14227ae51d105931bee91a75a4333b396f66a.zip"
    FILENAME "7ac14227ae51d105931bee91a75a4333b396f66a.zip"
    SHA512 b8ca69c9a259b6218b9340a25f08b9dbe1f2f9488d6c82fca65baa76cb2e6e256b1f0a6635727bb17bb04cd910606cbcc533798f2f82751a8d77ef315c22864b
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
    SOURCE_PATH ${SOURCE_PATH}/pr2_simulator
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
###