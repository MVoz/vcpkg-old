if (VCPKG_TARGET_ARCHITECTURE STREQUAL "arm")
  message(FATAL_ERROR "darknet does not support ARM")
endif()

if (VCPKG_CMAKE_SYSTEM_NAME STREQUAL "WindowsStore")
  message(FATAL_ERROR "darknet does not support UWP")
endif()

include(vcpkg_common_functions)

vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO AlexeyAB/darknet
  REF 8c970498a296ed129ffef7d872ccc25d42d1afda
  SHA512 70dda24656469b8a61a645533ac227b644d365c7d5f4dbc93077a3f46563dd45ae88c563fb1c8f8d02a2021760aba24bea35d81f0f307975d051d0f9bfe92265
  HEAD_REF master
  PATCHES
    fix_cmakelists.patch
)

set(ENABLE_CUDA OFF)
if("cuda" IN_LIST FEATURES)
  set(ENABLE_CUDA ON)
endif()

set(ENABLE_OPENCV OFF)
if("opencv" IN_LIST FEATURES)
  set(ENABLE_OPENCV ON)
endif()

if("opencv-cuda" IN_LIST FEATURES)
  set(ENABLE_OPENCV ON)
  set(ENABLE_CUDA ON)
endif()

if("weights" IN_LIST FEATURES)
  vcpkg_download_distfile(YOLOV3_WEIGHTS
    URLS "https://pjreddie.com/media/files/yolov3.weights"
    FILENAME "darknet-cache/yolov3.weights"
    SHA512 293c70e404ff0250d7c04ca1e5e053fc21a78547e69b5b329d34f25981613e59b982d93fff2c352915ef7531d6c3b02a9b0b38346d05c51d6636878d8883f2c1
  )
  vcpkg_download_distfile(YOLOV2_WEIGHTS
    URLS "https://pjreddie.com/media/files/yolov2.weights"
    FILENAME "darknet-cache/yolov2.weights"
    SHA512 5271da2dd2da915172ddd034c8e894877e7066051f105ae82e25e185a2b4e4157d2b9514653c23780e87346f2b20df6363018b7e688aba422e2dacf1d2fbf6ab
  )
  vcpkg_download_distfile(YOLOV3-TINY_WEIGHTS
    URLS "https://pjreddie.com/media/files/yolov3-tiny.weights"
    FILENAME "darknet-cache/yolov3-tiny.weights"
    SHA512 981a56459515f727bb7b3d3341b95f4117499b6726eab2798e1c3e524de1ee8ed0d954c11b27bbbb926da2cc955526a194eddf69c55d65923994ab2e8af07042
  )
  vcpkg_download_distfile(YOLOV2-TINY_WEIGHTS
    URLS "https://pjreddie.com/media/files/yolov2-tiny.weights"
    FILENAME "darknet-cache/yolov2-tiny.weights"
    SHA512 f0857a7a02cf4322354d288c9afa0b87321b23082b719bc84ea64e2f3556cc1fafeb836ee5bf9fb6dcf448839061b93623a067dfde7afa1338636865ea88989a
  )
endif()

#make sure we don't use any integrated pre-built library
file(REMOVE_RECURSE ${SOURCE_PATH}/3rdparty)

vcpkg_configure_cmake(
  SOURCE_PATH ${SOURCE_PATH}
  OPTIONS
    -DENABLE_CUDA=${ENABLE_CUDA}
    -DENABLE_OPENCV=${ENABLE_OPENCV}
)

vcpkg_install_cmake()

#somehow the native CMAKE_EXECUTABLE_SUFFIX does not work, so here we emulate it
if(CMAKE_HOST_WIN32)
  set(EXECUTABLE_SUFFIX ".exe")
else()
  set(EXECUTABLE_SUFFIX "")
endif()

file(REMOVE ${CURRENT_PACKAGES_DIR}/debug/bin/darknet${EXECUTABLE_SUFFIX})
file(REMOVE ${CURRENT_PACKAGES_DIR}/debug/bin/uselib${EXECUTABLE_SUFFIX})
if(EXISTS ${CURRENT_PACKAGES_DIR}/debug/bin/uselib_track${EXECUTABLE_SUFFIX})
  file(REMOVE ${CURRENT_PACKAGES_DIR}/debug/bin/uselib_track${EXECUTABLE_SUFFIX})
endif()
file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/tools/darknet/)
file(RENAME ${CURRENT_PACKAGES_DIR}/bin/darknet${EXECUTABLE_SUFFIX} ${CURRENT_PACKAGES_DIR}/tools/darknet/darknet${EXECUTABLE_SUFFIX})
file(RENAME ${CURRENT_PACKAGES_DIR}/bin/uselib${EXECUTABLE_SUFFIX} ${CURRENT_PACKAGES_DIR}/tools/darknet/uselib${EXECUTABLE_SUFFIX})
if(EXISTS ${CURRENT_PACKAGES_DIR}/bin/uselib_track${EXECUTABLE_SUFFIX})
  file(RENAME ${CURRENT_PACKAGES_DIR}/bin/uselib_track${EXECUTABLE_SUFFIX} ${CURRENT_PACKAGES_DIR}/tools/darknet/uselib_track${EXECUTABLE_SUFFIX})
endif()
file(COPY ${SOURCE_PATH}/cfg DESTINATION ${CURRENT_PACKAGES_DIR}/tools/darknet)
file(COPY ${SOURCE_PATH}/data DESTINATION ${CURRENT_PACKAGES_DIR}/tools/darknet)
vcpkg_copy_tool_dependencies(${CURRENT_PACKAGES_DIR}/tools/darknet)

if(VCPKG_LIBRARY_LINKAGE STREQUAL static)
  file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin ${CURRENT_PACKAGES_DIR}/debug/bin)
endif()

vcpkg_fixup_cmake_targets()

file(COPY ${SOURCE_PATH}/cmake/Modules/FindCUDNN.cmake DESTINATION ${CURRENT_PACKAGES_DIR}/share/darknet)
file(COPY ${SOURCE_PATH}/cmake/Modules/FindPThreads_windows.cmake DESTINATION ${CURRENT_PACKAGES_DIR}/share/darknet)
file(COPY ${SOURCE_PATH}/cmake/Modules/FindStb.cmake DESTINATION ${CURRENT_PACKAGES_DIR}/share/darknet)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/darknet RENAME copyright)

if("weights" IN_LIST FEATURES)
  file(COPY ${VCPKG_ROOT_DIR}/downloads/darknet-cache/yolov3.weights DESTINATION ${CURRENT_PACKAGES_DIR}/tools/darknet)
  file(COPY ${VCPKG_ROOT_DIR}/downloads/darknet-cache/yolov2.weights DESTINATION ${CURRENT_PACKAGES_DIR}/tools/darknet)
  file(COPY ${VCPKG_ROOT_DIR}/downloads/darknet-cache/yolov3-tiny.weights DESTINATION ${CURRENT_PACKAGES_DIR}/tools/darknet)
  file(COPY ${VCPKG_ROOT_DIR}/downloads/darknet-cache/yolov2-tiny.weights DESTINATION ${CURRENT_PACKAGES_DIR}/tools/darknet)
endif()
