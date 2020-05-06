include(vcpkg_common_functions)

#vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/commontk/PythonQt/archive/dafdb7255b82163329672edebba4f267958c7376.zip"
    FILENAME "PythonQt5.zip"
    SHA512 3da80b85688e9082eb77b806d00d850288447fdf329d4ac003d6b5ec63cb70e0c2614a3946e622841ae5504f50080d63f6117172764c056f19810cfded811672
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    PATCHES
      001_pythonqt5.patch
)

file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH}/extensions)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates

    OPTIONS 
      -DBUILD_TESTING:BOOL=OFF
#      -DPythonQt_DEBUG:BOOL=OFF
      -DPythonQt_Wrap_QtAll:BOOL=ON
      -DPythonQt_Wrap_Qtcore:BOOL=ON
      -DPythonQt_Wrap_Qtgui:BOOL=ON
      -DPythonQt_Wrap_Qtnetwork:BOOL=ON
      -DPythonQt_Wrap_Qtopengl:BOOL=ON
      -DPythonQt_Wrap_Qtqml:BOOL=ON
      -DPythonQt_Wrap_Qtquick:BOOL=ON
      -DPythonQt_Wrap_Qtsql:BOOL=ON
      -DPythonQt_Wrap_Qtsvg:BOOL=ON
      -DPythonQt_Wrap_Qtuitools:BOOL=ON
      -DPythonQt_Wrap_Qtxml:BOOL=ON
      -DPythonQt_Wrap_Qtxmlpatterns:BOOL=ON
	OPTIONS_RELEASE
	  -DPYTHON_LIBRARY=${CURRENT_INSTALLED_DIR}/lib/python37.lib
    OPTIONS_DEBUG
      -DPythonQt_DEBUG:BOOL=ON
	  -DPYTHON_LIBRARY=${CURRENT_INSTALLED_DIR}/Debug/lib/python37_d.lib
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/COPYING ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
