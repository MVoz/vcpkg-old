include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/gentryx/libgeodecomp/archive/09529db4b3f458f93a0240be578d1da6f1c2dc21.zip"
    FILENAME "libgeodecomp.zip"
    SHA512 d0c15f2c80806fe9bbbb0e7aacb70fa616898433630a2a40f3bb625b94bbcace162bc603e69f26e332621bfb2075c5f3e253417f844d8324fbc2b422331b5d4d
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

set(VCPKG_FORTRAN_ENABLED ON)
vcpkg_enable_fortran(intel)

vcpkg_find_acquire_program(RUBY)
get_filename_component(RUBY_DIR "${RUBY}" DIRECTORY)
set(ENV{PATH} "$ENV{PATH};${RUBY_DIR}")

#get_filename_component(GIT_EXE_PATH ${GIT} DIRECTORY)
#set(SH_EXE_PATH "${GIT_EXE_PATH}/../usr/bin")
#set(ENV{PATH} "$ENV{PATH};${VALAC_DIR};${BISON_DIR};${FLEX_DIR};${SH_EXE_PATH}")

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
#    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates

    OPTIONS 
#      -DHPX_Fortran_COMPILER=
#      -DHPX_Fortran_COMPILER_ID=
#      -DHPX_Fortran_COMPILER_VERSION=
#      -DHPX_GIT_COMMIT=unknown
#      -DHPX_WITH_MALLOC=system
#      -DLFA_ADDITIONAL_COMPILE_FLAGS= -Wall
#      -DLGD_ADDITIONAL_CXX_COMPILE_FLAGS= /W4
#      -DLGD_ADDITIONAL_C_COMPILE_FLAGS=   /W4
#      -DLIB_DIR=lib
#      -DLIB_INSTALL_DIR=lib
#      -DLIB_LINKAGE_TYPE=SHARED
#      -DLIMIT_TESTS=FALSE
#      -DOPENCL_LIBRARIES:FILEPATH=E:/tools/vcpkg/installed/x64-windows/lib/OpenCL.lib
#      -DOpenCV_DIR:PATH=OpenCV_DIR-NOTFOUND
#      -DPTESMUMPS_LIBRARY:FILEPATH=PTESMUMPS_LIBRARY-NOTFOUND
#      -DPTSCOTCHERR_LIBRARY:FILEPATH=PTSCOTCHERR_LIBRARY-NOTFOUND
#      -DPTSCOTCH_LIBRARY:FILEPATH=PTSCOTCH_LIBRARY-NOTFOUND
#      -DQt5Core_DIR:PATH=E:/tools/vcpkg/installed/x64-windows/lib/cmake/Qt5Core
#      -DQt5Gui_DIR:PATH=E:/tools/vcpkg/installed/x64-windows/lib/cmake/Qt5Gui
#      -DQt5OpenGL_DIR:PATH=E:/tools/vcpkg/installed/x64-windows/lib/cmake/Qt5OpenGL
#      -DQt5Widgets_DIR:PATH=E:/tools/vcpkg/installed/x64-windows/lib/cmake/Qt5Widgets
#      -DQt5_DIR:PATH=E:/tools/vcpkg/installed/x64-windows/lib/cmake/Qt5
#      -DSCOTCHERR_LIBRARY:FILEPATH=SCOTCHERR_LIBRARY-NOTFOUND
#      -DSCOTCH_INCLUDE_DIRS:PATH=SCOTCH_INCLUDE_DIRS-NOTFOUND
#      -DSCOTCH_LIBRARY:FILEPATH=SCOTCH_LIBRARY-NOTFOUND
      -DWITH_AVX_FORCED_OFF=TRUE
#      -DWITH_BOOST_ASIO=TRUE
#      -DWITH_BOOST_MOVE=TRUE
#      -DWITH_BOOST_MPI=ON
#      -DWITH_BOOST_SERIALIZATION=ON
#      -DWITH_BOOST_SHARED_PTR=FALSE
#      -DWITH_CPP14=TRUE
#      -DWITH_CUDA=TRUE
#      -DWITH_FORCED_CPP11=FALSE
      -DWITH_FORTRAN=TRUE
      -DWITH_HPX=1
#      -DWITH_INCREASED_PRECISION=FALSE
#      -DWITH_INTRINSICS=FALSE
#      -DWITH_LAX_VISIT_TESTS=FALSE
#      -DWITH_LIBPTHREAD=TRUE
      -DWITH_MPI=TRUE
      -DWITH_OPENCL=TRUE
#      -DWITH_OPENCV=FALSE
      -DWITH_QT5=1
      -DWITH_SCOTCH=FALSE
      -DWITH_SILO=FALSE
#      -DWITH_THREADS=TRUE
#      -DWITH_TYPEMAPS=FALSE
      -DWITH_VISIT=FALSE
#      -D_OPENCL_CPP_INCLUDE_DIRS:PATH=E:/tools/vcpkg/installed/x64-windows/include
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
