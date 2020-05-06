include(vcpkg_common_functions)


https://robotics.bmstu.ru/gitlab/snippets/33/raw
https://github.com/ros-gbp/roscpp_core-release/releases
https://gist.githubusercontent.com/codebot/874494b34f5d02af2b24a5a312847b9c/raw
https://github.com/ros/ros_comm/blob/melodic-devel/clients/roscpp/include/ros/timer.h

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/ros-gbp/roscpp_core-release/archive/rpm/ros-melodic-rostime-0.6.12-0_28.tar.gz"
    FILENAME "ros-melodic-rostime-0.6.12-0_28.tar.gz"
    SHA512 36676b2a97eace3112aba67fafb38ca323f2017832c6b353b6c3d358cddbb9b1951406e7b2fee9c1fbac94a326579cfba2511927e40ae8a9147743b741b711ea
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
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates
	DISABLE_PARALLEL_CONFIGURE # ERROR - The process cannot access the file because it is being used by another process.
    OPTIONS 
	  -DCATKIN_ENABLE_TESTING=OFF
	  -DNOSETESTS:FILEPATH=${PYTHON3_DIR}/Scripts/nosetests.exe
	  -DPYTHON_VERSION=3.7
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
