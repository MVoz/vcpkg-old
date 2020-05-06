if (EXISTS "${CURRENT_INSTALLED_DIR}/share/opencv4")
  message(FATAL_ERROR "OpenCV 4 is installed, please uninstall and try again:\n    vcpkg remove opencv4")
endif()

include(vcpkg_common_functions)

set(OPENCV_VERSION "3.4.7")

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO opencv/opencv
    REF ${OPENCV_VERSION}
    SHA512 ba1336ad4e5208748aa09c99770392cc71ef72688560d0b03287ddafd36093ef30cbdf6422f87f8f878663ab8085cc0ff8a8c65fd1ff0ec6800855ea01309beb
    HEAD_REF master
    PATCHES
      0001-disable-downloading.patch
      0002-install-options.patch
      0003-force-package-requirements.patch
      0009-fix-uwp.patch
)

string(COMPARE EQUAL "${VCPKG_CRT_LINKAGE}" "static" BUILD_WITH_STATIC_CRT)

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
 "contrib"  WITH_CONTRIB
 "cuda"     WITH_CUDA
 "cuda"     WITH_CUBLAS
 "dnn"      BUILD_opencv_dnn
 "eigen"    WITH_EIGEN
 "ffmpeg"   WITH_FFMPEG
 "flann"    BUILD_opencv_flann
 "gdcm"     WITH_GDCM
 "halide"   WITH_HALIDE
 "jasper"   WITH_JASPER
 "jpeg"     WITH_JPEG
 "nonfree"  OPENCV_ENABLE_NONFREE
 "openexr"  WITH_OPENEXR
 "opengl"   WITH_OPENGL
 "png"      WITH_PNG
 "qt"       WITH_QT
 "sfm"      BUILD_opencv_sfm
 "tiff"     WITH_TIFF
 "webp"     WITH_WEBP
 "world"    BUILD_opencv_world
)

# Cannot use vcpkg_check_features() for "ipp", "ovis", "tbb", and "vtk".
# As the respective value of their variables can be unset conditionally.
set(WITH_IPP OFF)
if("ipp" IN_LIST FEATURES)
  set(WITH_IPP ON)
endif()

set(BUILD_opencv_ovis OFF)
if("ovis" IN_LIST FEATURES)
  set(BUILD_opencv_ovis ON)
endif()

set(WITH_TBB OFF)
if("tbb" IN_LIST FEATURES)
  set(WITH_TBB ON)
endif()

set(WITH_VTK OFF)
if("vtk" IN_LIST FEATURES)
  set(WITH_VTK ON)
endif()

if("dnn" IN_LIST FEATURES)
  vcpkg_download_distfile(TINYDNN_ARCHIVE
    URLS "https://github.com/tiny-dnn/tiny-dnn/archive/v1.0.0a3.tar.gz"
    FILENAME "opencv-cache/tiny_dnn/adb1c512e09ca2c7a6faef36f9c53e59-v1.0.0a3.tar.gz"
    SHA512 5f2c1a161771efa67e85b1fea395953b7744e29f61187ac5a6c54c912fb195b3aef9a5827135c3668bd0eeea5ae04a33cc433e1f6683e2b7955010a2632d168b
  )
endif()

# Build image quality module when building with 'contrib' feature and not UWP.
set(BUILD_opencv_quality OFF)
if("contrib" IN_LIST FEATURES)
  if (VCPKG_TARGET_IS_UWP)
    set(BUILD_opencv_quality OFF)
    message(WARNING "The image quality module (quality) does not build for UWP, the module has been disabled.")
    # The hdf module is silently disabled by OpenCVs buildsystem if HDF5 is not detected.
    message(WARNING "The hierarchical data format module (hdf) depends on HDF5 which doesn't support UWP, the module has been disabled.")
  else()
    set(BUILD_opencv_quality CMAKE_DEPENDS_IN_PROJECT_ONLY)
  endif()

  vcpkg_from_github(
      OUT_SOURCE_PATH CONTRIB_SOURCE_PATH
      REPO opencv/opencv_contrib
      REF ${OPENCV_VERSION}
      SHA512 922620f3e8754fc15dedf8993bdc1f00c06b623cbeeb72afb984ddaad6e0e04f46561a0ee4d20f5e260616c1f32c6dc0dd7248355d417873ae72bd03cb5d57fd
      HEAD_REF master
  )
  set(BUILD_WITH_CONTRIB_FLAG "-DOPENCV_EXTRA_MODULES_PATH=${CONTRIB_SOURCE_PATH}/modules")
  # Used for opencv's face module
  vcpkg_download_distfile(OCV_DOWNLOAD
    URLS "https://raw.githubusercontent.com/opencv/opencv_3rdparty/8afa57abc8229d611c4937165d20e2a2d9fc5a12/face_landmark_model.dat"
    FILENAME "opencv-cache/data/7505c44ca4eb54b4ab1e4777cb96ac05-face_landmark_model.dat"
    SHA512 c16e60a6c4bb4de3ab39b876ae3c3f320ea56f69c93e9303bd2dff8760841dcd71be4161fff8bc71e8fe4fe8747fa8465d49d6bd8f5ebcdaea161f4bc2da7c93
  )

  function(download_opencv_3rdparty ID COMMIT HASH)
    if(NOT EXISTS "${DOWNLOADS}/opencv-cache/${ID}/${COMMIT}.stamp")
      vcpkg_download_distfile(OCV_DOWNLOAD
          URLS "https://github.com/opencv/opencv_3rdparty/archive/${COMMIT}.zip"
          FILENAME "opencv_3rdparty-${COMMIT}.zip"
          SHA512 ${HASH}
      )
      vcpkg_extract_source_archive(${OCV_DOWNLOAD})
      file(MAKE_DIRECTORY "${DOWNLOADS}/opencv-cache/${ID}")
      file(GLOB XFEATURES2D_I ${CURRENT_BUILDTREES_DIR}/src/opencv_3rdparty-${COMMIT}/*)
      foreach(FILE ${XFEATURES2D_I})
        file(COPY ${FILE} DESTINATION "${DOWNLOADS}/opencv-cache/${ID}")
        get_filename_component(XFEATURES2D_I_NAME "${FILE}" NAME)
        file(MD5 "${FILE}" FILE_HASH)
        file(RENAME "${DOWNLOADS}/opencv-cache/${ID}/${XFEATURES2D_I_NAME}" "${DOWNLOADS}/opencv-cache/${ID}/${FILE_HASH}-${XFEATURES2D_I_NAME}")
      endforeach()
      file(WRITE "${DOWNLOADS}/opencv-cache/${ID}/${COMMIT}.stamp")
    endif()
  endfunction()

  # Used for opencv's xfeature2d module
  download_opencv_3rdparty(
    xfeatures2d/boostdesc
    34e4206aef44d50e6bbcd0ab06354b52e7466d26
    2ccdc8fb59da55eabc73309a80a4d3b1e73e2341027cdcdd2d714e0f519e60f243f38f79b13ed3de32f595aa23e4f86418eed42e741f32a81b1e6e0879190601
  )

  # Used for opencv's xfeature2d module
  download_opencv_3rdparty(
    xfeatures2d/vgg
    fccf7cd6a4b12079f73bbfb21745f9babcd4eb1d
    7051f5d6ccb938d296b919dd6d5dcddc5afb527aed456639c9984276a8f64565c084d96a72499a7756f127f8d2b1ce9ab70e4cbb3f89c4e16f82296c2a15daed
  )
endif()

if(WITH_IPP)
  if(VCPKG_TARGET_IS_OSX)
    if(VCPKG_TARGET_ARCHITECTURE STREQUAL "x64")
      vcpkg_download_distfile(OCV_DOWNLOAD
        URLS "https://raw.githubusercontent.com/opencv/opencv_3rdparty/32e315a5b106a7b89dbed51c28f8120a48b368b4/ippicv/ippicv_2019_mac_intel64_general_20180723.tgz"
        FILENAME "opencv-cache/ippicv/fe6b2bb75ae0e3f19ad3ae1a31dfa4a2-ippicv_2019_mac_intel64_general_20180723.tgz"
        SHA512 266fe3fecf8e95e1f51c09b65330a577743ef72b423b935d4d1fe8d87f1b4f258c282fe6a18fc805d489592f137ebed37c9f1d1b34026590d9f1ba107015132e
    )
    else()
      message(WARNING "This target architecture is not supported IPPICV")
      set(WITH_IPP OFF)
    endif()
  elseif(VCPKG_TARGET_IS_LINUX)
    if(VCPKG_TARGET_ARCHITECTURE STREQUAL "x64")
      vcpkg_download_distfile(OCV_DOWNLOAD
        URLS "https://raw.githubusercontent.com/opencv/opencv_3rdparty/32e315a5b106a7b89dbed51c28f8120a48b368b4/ippicv/ippicv_2019_lnx_intel64_general_20180723.tgz"
        FILENAME "opencv-cache/ippicv/c0bd78adb4156bbf552c1dfe90599607-ippicv_2019_lnx_intel64_general_20180723.tgz"
        SHA512 e4ec6b3b9fc03d7b3ae777c2a26f57913e83329fd2f7be26c259b07477ca2a641050b86979e0c96e25aa4c1f9f251b28727690358a77418e76dd910d0f4845c9
      )
    elseif(VCPKG_TARGET_ARCHITECTURE STREQUAL "x86")
      vcpkg_download_distfile(OCV_DOWNLOAD
        URLS "https://raw.githubusercontent.com/opencv/opencv_3rdparty/32e315a5b106a7b89dbed51c28f8120a48b368b4/ippicv/ippicv_2019_lnx_ia32_general_20180723.tgz"
        FILENAME "opencv-cache/ippicv/4f38432c30bfd6423164b7a24bbc98a0-ippicv_2019_lnx_ia32_general_20180723.tgz"
        SHA512 d96d3989928ff11a18e631bf5ecfdedf88fd350162a23fa2c8f7dbc3bf878bf442aff7fb2a07dc56671d7268cc20682055891be75b9834e9694d20173e92b6a3
      )
    else()
      message(WARNING "This target architecture is not supported IPPICV")
      set(WITH_IPP OFF)
    endif()
  elseif(VCPKG_TARGET_IS_WINDOWS)
    if(VCPKG_TARGET_ARCHITECTURE STREQUAL "x64")
      vcpkg_download_distfile(OCV_DOWNLOAD
        URLS "https://raw.githubusercontent.com/opencv/opencv_3rdparty/32e315a5b106a7b89dbed51c28f8120a48b368b4/ippicv/ippicv_2019_win_intel64_20180723_general.zip"
        FILENAME "opencv-cache/ippicv/1d222685246896fe089f88b8858e4b2f-ippicv_2019_win_intel64_20180723_general.zip"
        SHA512 b6c4f2696e2004b8f5471efd9bdc6c684b77830e0533d8880310c0b665b450d6f78e10744c937f5592ab900e187c475e46cb49e98701bb4bcbbc7da77723011d
      )
    elseif(VCPKG_TARGET_ARCHITECTURE STREQUAL "x86")
      vcpkg_download_distfile(OCV_DOWNLOAD
        URLS "https://raw.githubusercontent.com/opencv/opencv_3rdparty/32e315a5b106a7b89dbed51c28f8120a48b368b4/ippicv/ippicv_2019_win_ia32_20180723_general.zip"
        FILENAME "opencv-cache/ippicv/0157251a2eb9cd63a3ebc7eed0f3e59e-ippicv_2019_win_ia32_20180723_general.zip"
        SHA512 c33fd4019c71b064b153e1b25e0307f9c7ada693af8ec910410edeab471c6f14df9b11bf9f5302ceb0fcd4282f5c0b6c92fb5df0e83eb50ed630c45820d1e184
      )
    else()
      message(WARNING "This target architecture is not supported IPPICV")
      set(WITH_IPP OFF)
    endif()
  else()
    message(WARNING "This target architecture is not supported IPPICV")
    set(WITH_IPP OFF)
  endif()
endif()

set(WITH_MSMF ON)
if(NOT VCPKG_TARGET_IS_WINDOWS OR VCPKG_TARGET_IS_UWP)
  set(WITH_MSMF OFF)
endif()

if (VCPKG_LIBRARY_LINKAGE STREQUAL static)
  if (WITH_TBB)
    message(WARNING "TBB is currently unsupported in this build configuration, turning it off")
    set(WITH_TBB OFF)
  endif()

  if (WITH_VTK)
    message(WARNING "VTK is currently unsupported in this build configuration, turning it off")
    set(WITH_VTK OFF)
  endif()

  if (VCPKG_TARGET_IS_WINDOWS AND BUILD_opencv_ovis)
    message(WARNING "OVIS is currently unsupported in this build configuration, turning it off")
    set(BUILD_opencv_ovis OFF)
  endif()
endif()

if("ffmpeg" IN_LIST FEATURES)
  if(VCPKG_TARGET_IS_UWP)
    set(VCPKG_C_FLAGS "/sdl- ${VCPKG_C_FLAGS}")
    set(VCPKG_CXX_FLAGS "/sdl- ${VCPKG_CXX_FLAGS}")
  endif()
endif()

if("qt" IN_LIST FEATURES)
  list(APPEND ADDITIONAL_BUILD_FLAGS "-DCMAKE_AUTOMOC=ON")
endif()

set(BUILD_opencv_line_descriptor ON)
set(BUILD_opencv_saliency ON)
set(BUILD_opencv_bgsegm ON)
if(VCPKG_TARGET_ARCHITECTURE MATCHES "arm")
  set(BUILD_opencv_line_descriptor OFF)
  set(BUILD_opencv_saliency OFF)
  set(BUILD_opencv_bgsegm OFF)
endif()

vcpkg_configure_cmake(
    PREFER_NINJA
    SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
        ###### ocv_options
        -DOpenCV_INSTALL_BINARIES_PREFIX=
        -DOPENCV_LIB_INSTALL_PATH=lib
        -DOPENCV_3P_LIB_INSTALL_PATH=lib
        -DOPENCV_CONFIG_INSTALL_PATH=share/opencv
        -DOPENCV_FFMPEG_USE_FIND_PACKAGE=FFMPEG
        -DCMAKE_DEBUG_POSTFIX=d
        -DOpenCV_DISABLE_ARCH_PATH=ON
        # Do not build docs/examples
        -DBUILD_DOCS=OFF
        -DBUILD_EXAMPLES=OFF
        ###### Disable build 3rd party libs
        -DBUILD_JASPER=OFF
        -DBUILD_JPEG=OFF
        -DBUILD_OPENEXR=OFF
        -DBUILD_PNG=OFF
        -DBUILD_TIFF=OFF
        -DBUILD_WEBP=OFF
        -DBUILD_ZLIB=OFF
        ###### Disable build 3rd party components
        -DBUILD_PROTOBUF=OFF
        ###### OpenCV Build components
        -DBUILD_opencv_apps=OFF
        -DBUILD_opencv_bgsegm=${BUILD_opencv_bgsegm}
        -DBUILD_opencv_line_descriptor=${BUILD_opencv_line_descriptor}
        -DBUILD_opencv_saliency=${BUILD_opencv_saliency}
        -DBUILD_PACKAGE=OFF
        -DBUILD_PERF_TESTS=OFF
        -DBUILD_TESTS=OFF
        -DBUILD_WITH_DEBUG_INFO=ON
        -DBUILD_WITH_STATIC_CRT=${BUILD_WITH_STATIC_CRT}
        ###### PROTOBUF
        -DPROTOBUF_UPDATE_FILES=ON
        -DUPDATE_PROTO_FILES=ON
        # CMAKE
        -DCMAKE_DISABLE_FIND_PACKAGE_Git=ON
        -DCMAKE_DISABLE_FIND_PACKAGE_JNI=ON
        # ENABLE
        -DENABLE_CXX11=ON
        ###### OPENCV vars
        "-DOPENCV_DOWNLOAD_PATH=${DOWNLOADS}/opencv-cache"
        ${BUILD_WITH_CONTRIB_FLAG}
        -DOPENCV_OTHER_INSTALL_PATH=share/opencv
        ###### customized properties
        ## Options from vcpkg_check_features()
        ${FEATURE_OPTIONS}
        -DHALIDE_ROOT_DIR=${CURRENT_INSTALLED_DIR}
        -DWITH_IPP=${WITH_IPP}
        -DWITH_MATLAB=OFF
        -DWITH_MSMF=${WITH_MSMF}
        -DWITH_PROTOBUF=ON
        -DWITH_OPENCLAMDBLAS=OFF
        -DWITH_TBB=${WITH_TBB}
        -DWITH_VTK=${WITH_VTK}
        ###### WITH PROPERTIES explicitly disabled, they have problems with libraries if already installed by user and that are "involuntarily" found during install
        -DWITH_LAPACK=OFF
        ###### BUILD_options (mainly modules which require additional libraries)
        -DBUILD_opencv_ovis=${BUILD_opencv_ovis}
        ###### The following modules are disabled for UWP
        -DBUILD_opencv_quality=${BUILD_opencv_quality}
        ###### Additional build flags
        ${ADDITIONAL_BUILD_FLAGS}
)

vcpkg_install_cmake()
vcpkg_fixup_cmake_targets(CONFIG_PATH "share/opencv" TARGET_PATH "share/opencv")
vcpkg_copy_pdbs()

if(VCPKG_LIBRARY_LINKAGE STREQUAL "static")
  file(READ ${CURRENT_PACKAGES_DIR}/share/opencv/OpenCVModules.cmake OPENCV_MODULES)
  string(REPLACE "set(CMAKE_IMPORT_FILE_VERSION 1)"
                 "set(CMAKE_IMPORT_FILE_VERSION 1)
find_package(Protobuf REQUIRED)
if(Protobuf_FOUND)
  if(TARGET protobuf::libprotobuf)
    add_library(libprotobuf INTERFACE IMPORTED)
    set_target_properties(libprotobuf PROPERTIES
      INTERFACE_LINK_LIBRARIES protobuf::libprotobuf
    )
  else()
    add_library(libprotobuf UNKNOWN IMPORTED)
    set_target_properties(libprotobuf PROPERTIES
      IMPORTED_LOCATION \"${Protobuf_LIBRARY}\"
      INTERFACE_INCLUDE_DIRECTORIES \"${Protobuf_INCLUDE_DIR}\"
      INTERFACE_SYSTEM_INCLUDE_DIRECTORIES \"${Protobuf_INCLUDE_DIR}\"
    )
  endif()
endif()
find_package(TIFF QUIET)
find_package(HDF5 QUIET)
find_package(Freetype QUIET)
find_package(Ogre QUIET)
find_package(gflags QUIET)
find_package(Ceres QUIET)
find_package(ade QUIET)
find_package(VTK QUIET)
find_package(OpenMP QUIET)
find_package(GDCM QUIET)" OPENCV_MODULES "${OPENCV_MODULES}")

  file(WRITE ${CURRENT_PACKAGES_DIR}/share/opencv/OpenCVModules.cmake "${OPENCV_MODULES}")

  file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin ${CURRENT_PACKAGES_DIR}/debug/bin)
endif()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE ${CURRENT_PACKAGES_DIR}/setup_vars_opencv3.cmd)
file(REMOVE ${CURRENT_PACKAGES_DIR}/debug/setup_vars_opencv3.cmd)
file(REMOVE ${CURRENT_PACKAGES_DIR}/LICENSE)
file(REMOVE ${CURRENT_PACKAGES_DIR}/debug/LICENSE)
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
