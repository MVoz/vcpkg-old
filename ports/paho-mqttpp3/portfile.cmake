include(vcpkg_common_functions)

# Download from Github
vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO eclipse/paho.mqtt.cpp
  REF v1.0.1
  SHA512 be612197fae387b9f1d8f10944d451ec9e7ebec6045beed365e642089c0a5fde882ed5c734f2b46a5008f98b8445a51114492f0f36fdc684b8a8fe4b71fe31a4
  HEAD_REF master
)

vcpkg_check_features("ssl" PAHO_WITH_SSL)

# Link with 'paho-mqtt3as' library
set(PAHO_C_LIBNAME paho-mqtt3as)

# Setting the library path
if (NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "release")
  set(PAHO_C_LIBRARY_PATH "${CURRENT_INSTALLED_DIR}/lib")
else()
  set(PAHO_C_LIBRARY_PATH "${CURRENT_INSTALLED_DIR}/debug/lib")
endif()

# Setting the include path where MqttClient.h is present
set(PAHO_C_INC "${CURRENT_INSTALLED_DIR}/include/paho-mqtt")

# Set the generator to Ninja
set(PAHO_CMAKE_GENERATOR "Ninja")

# NOTE: the Paho C++ cmake files on Github are problematic. 
# It uses two different options PAHO_BUILD_STATIC and PAHO_BUILD_SHARED instead of just using one variable.
# Unless the open source community cleans up the cmake files, we are stuck with setting both of them.
if (VCPKG_LIBRARY_LINKAGE STREQUAL "static")
  set(PAHO_MQTTPP3_STATIC ON)
  set(PAHO_MQTTPP3_SHARED OFF)
  set(PAHO_C_LIB "${PAHO_C_LIBRARY_PATH}/${PAHO_C_LIBNAME}")
  set(PAHO_OPTIONS -DPAHO_MQTT_C_LIBRARIES=${PAHO_C_LIB})
else()
  set(PAHO_MQTTPP3_STATIC OFF)
  set(PAHO_MQTTPP3_SHARED ON)
  set(PAHO_OPTIONS)
endif()

vcpkg_configure_cmake(
  SOURCE_PATH ${SOURCE_PATH}
  PREFER_NINJA
  GENERATOR ${PAHO_CMAKE_GENERATOR}
  OPTIONS
  -DPAHO_BUILD_STATIC=${PAHO_MQTTPP3_STATIC}
  -DPAHO_BUILD_SHARED=${PAHO_MQTTPP3_SHARED}
  -DPAHO_WITH_SSL=${PAHO_WITH_SSL}
  -DPAHO_MQTT_C_INCLUDE_DIRS=${PAHO_C_INC}
  ${PAHO_OPTIONS}
)

# Run the build, copy pdbs and fixup the cmake targets
vcpkg_install_cmake()
vcpkg_copy_pdbs()
vcpkg_fixup_cmake_targets(CONFIG_PATH "lib/cmake/PahoMqttCpp" TARGET_PATH "share/pahomqttcpp")

# Remove the include and share folders in debug folder
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)

# Add copyright
file(INSTALL ${SOURCE_PATH}/about.html DESTINATION ${CURRENT_PACKAGES_DIR}/share/paho-mqttpp3 RENAME copyright)
