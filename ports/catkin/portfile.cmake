include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/ros/catkin/archive/0baff3a78c3ca1fcbf65493a8d656054a61a6c12.zip"
    FILENAME "0baff3a78c3ca1fcbf65493a8d656054a61a6c12.zip"
    SHA512 e4740d8038766b9fcff9f02061c32ff504e4adcefb3a48b371674f6efea740586416a4402fe885c7ce51d11b1fa28cda6b59948bed8402d201235885af3c5b38
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_find_acquire_program(PYTHON3)
get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
set(PYTHON3_SCRIPTS "${PYTHON3_DIR}/Scripts")
set(ENV{PATH} "$ENV{PATH};${PYTHON3_DIR};${PYTHON3_SCRIPTS}")

#pip uninstall em #!!!
#pip install empy

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates

    OPTIONS 
	  -DCATKIN_ENABLE_TESTING=OFF
#	  -DEMPY_EXECUTABLE:FILEPATH=EMPY_EXECUTABLE-NOTFOUND
#	  -DEMPY_SCRIPT:STRING=${PYTHON3_DIR}/lib/site-packages/em.py
#	  -DPY_EM:STRING=${PYTHON3_DIR}/lib/site-packages/em.py
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
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
