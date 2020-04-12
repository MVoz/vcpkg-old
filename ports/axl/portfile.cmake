include(vcpkg_common_functions)

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/vovkos/axl/archive/b8f7023f657b8ddaa35742de05accc485fca85f8.zip"
    FILENAME "axl.zip"
    SHA512 dfb22f85007055f9549de92a3e64ed1402347cba0471fc1d60552f187d332e23518403b4ea475c542a01be919db61b62cfe75508a4e130abcafa3c48d52bdad3
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_find_acquire_program(DOXYGEN)
vcpkg_find_acquire_program(TEXLIVE)
get_filename_component(DOXYGEN_DIR "${DOXYGEN}" DIRECTORY)
get_filename_component(TEXLIVE_DIR "${TEXLIVE}" DIRECTORY)
set(ENV{PATH} "$ENV{PATH};${DOXYGEN_DIR};${TEXLIVE_DIR}")

#LUA_INC_DIR LUA_LIB_DIR LUA_LIB_NAME AXL_CMAKE_DIR RAGEL_EXE 7Z_EXE

#-- Dependency
#--     RAGEL_EXE:           E:/tools/vcpkg/installed/x64-windows/bin/ragel.exe
#-- Lua paths:
#-- Pcap paths:
#-- LibUSB paths:
#-- OpenSSL paths:
#-- Expat paths:
#-- QT 5.12.3 paths:
#--     Core CMake files:    
#--     Gui CMake files:     
#--     Widgets CMake files: 
#--     Network CMake files: 
#-- Doxygen found at:        
#-- doxyrest:                NOT FOUND, missing import_doxyrest.cmake, adjust AXL_IMPORT_DIR_LIST(optional)
#-- sphinx:                  NOT FOUND, adjust SPHINX_BUILD_EXE in paths.cmake(optional)
#-- latex:                   NOT FOUND, adjust PDFLATEX_EXE in paths.cmake(optional)
#-- 7-Zip

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates

    OPTIONS 
      -DBUILD_AXL_CRY=ON
      -DBUILD_AXL_DOX=ON
      -DBUILD_AXL_FSM=ON
      -DBUILD_AXL_GUI=OFF
      -DBUILD_AXL_GUI_GDI=ON
      -DBUILD_AXL_GUI_QT=OFF
      -DBUILD_AXL_INI=ON
      -DBUILD_AXL_IO=ON
      -DBUILD_AXL_IO_PCAP=ON
      -DBUILD_AXL_IO_USB=ON
      -DBUILD_AXL_LEX=ON
      -DBUILD_AXL_LUA=ON
      -DBUILD_AXL_ST=ON
      -DBUILD_AXL_TESTS=OFF
      -DBUILD_AXL_TEST_AUTO=OFF
      -DBUILD_AXL_TEST_QT=OFF
      -DBUILD_AXL_XML=ON
      -DBUILD_AXL_ZIP=ON
      -DMSVC_USE_FOLDERS=ON
      -DMSVC_USE_PCH=OFF
      -DMSVC_USE_UNICODE=ON
	  -DRAGEL_EXE=${CURRENT_INSTALLED_DIR}/bin/ragel.exe
)

vcpkg_install_cmake()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/license ${CURRENT_PACKAGES_DIR}/debug/license)

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE.txt ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
