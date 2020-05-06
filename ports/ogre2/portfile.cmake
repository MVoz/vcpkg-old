include(vcpkg_common_functions)

# Development only with release
# set(VCPKG_BUILD_TYPE release)

vcpkg_from_bitbucket(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO sinbad/ogre
    REF 06a386fa64e7
    SHA512 e91e7dd67db921b46d3705334b05bbbe74721893807b6a5c83a96d54fe97debbbc307999afaafd606ceed6f2ab9f5d0117ae64b802ac03b077771ee3b09ce458
)

message(STATUS "SOURCE PATH: ${SOURCE_PATH}")

vcpkg_apply_patches(
    SOURCE_PATH ${SOURCE_PATH}
    PATCHES
        "${CMAKE_CURRENT_LIST_DIR}/001-cmake-install-dir.patch"
)

if (VCPKG_LIBRARY_LINKAGE STREQUAL static)
    set(OGRE_STATIC ON)
else()
    set(OGRE_STATIC OFF)
endif()

# Configure features

if("d3d9" IN_LIST FEATURES)
    set(WITH_D3D9 ON)
else()
    set(WITH_D3D9 OFF)
endif()

if("java" IN_LIST FEATURES)
    set(WITH_JAVA ON)
else()
    set(WITH_JAVA OFF)
endif()

if("python" IN_LIST FEATURES)
    set(WITH_PYTHON ON)
else()
    set(WITH_PYTHON OFF)
endif()

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DOGRE_BUILD_SAMPLES2=OFF
        -DOGRE_BUILD_TESTS=OFF
        -DOGRE_BUILD_TOOLS=OFF
        -DOGRE_BUILD_MSVC_MP=ON
        -DOGRE_BUILD_MSVC_ZM=ON
        -DOGRE_INSTALL_DEPENDENCIES=OFF
        -DOGRE_INSTALL_DOCS=OFF
        -DOGRE_INSTALL_PDB=OFF
        -DOGRE_INSTALL_SAMPLES=OFF
        -DOGRE_INSTALL_TOOLS=OFF
        -DOGRE_INSTALL_VSPROPS=OFF
	-DOGRE_LIB_DIRECTORY=lib/OGRE-2.1
        -DOGRE_STATIC=${OGRE_STATIC}
        -DOGRE_UNITY_BUILD=OFF
        -DOGRE_CONFIG_THREAD_PROVIDER=std
        -DOGRE_BUILD_RENDERSYSTEM_D3D11=ON
        -DOGRE_BUILD_RENDERSYSTEM_GL=ON
        -DOGRE_BUILD_RENDERSYSTEM_GL3PLUS=ON
        -DOGRE_BUILD_RENDERSYSTEM_GLES=OFF
        -DOGRE_BUILD_RENDERSYSTEM_GLES2=OFF
        -DOGRE_CMAKE_DIR=share/ogre2
)

vcpkg_install_cmake()

# Remove unwanted files
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

vcpkg_fixup_cmake_targets(CONFIG_PATH share/ogre2)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)

file(GLOB REL_CFGS ${CURRENT_PACKAGES_DIR}/bin/*.cfg)
file(COPY ${REL_CFGS} DESTINATION ${CURRENT_PACKAGES_DIR}/lib)

# TODO file(GLOB DBG_CFGS ${CURRENT_PACKAGES_DIR}/debug/bin/*.cfg)
# TODO file(COPY ${DBG_CFGS} DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)

# TODO file(REMOVE ${REL_CFGS} ${DBG_CFGS})
# file(REMOVE ${REL_CFGS})

if(VCPKG_LIBRARY_LINKAGE STREQUAL "static")
    file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin ${CURRENT_PACKAGES_DIR}/debug/bin)
endif()

file(RENAME ${CURRENT_PACKAGES_DIR}/include/OGRE ${CURRENT_PACKAGES_DIR}/include/OGRE-2.1)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/ogre2/FindOGRE.cmake ${CURRENT_PACKAGES_DIR}/share/ogre2/OGRE2Config.cmake)

file(GLOB SHARE_FILES ${CURRENT_PACKAGES_DIR}/share/ogre2/*.cmake)
foreach(SHARE_FILE ${SHARE_FILES})
  file(READ "${SHARE_FILE}" _contents)
  # Find modules in vcpkg share
  string(REPLACE "include(FindPkgMacros)" "set (CMAKE_MODULE_PATH \${CMAKE_MODULE_PATH};${CURRENT_INSTALLED_DIR}/share/ogre2)\ninclude(FindPkgMacros)" _contents "${_contents}")
  # Overwrite enviroment paths by vcpkg CURRENT_PACKAGES_DIR
  string(REPLACE "getenv_path(OGRE_SOURCE)" "set(OGRE_SOURCE ${CURRENT_INSTALLED_DIR})" _contents "${_contents}")
  string(REPLACE "getenv_path(OGRE_BUILD)" "set(OGRE_BUILD \${OGRE_SOURCE})" _contents "${_contents}")
  string(REPLACE "getenv_path(OGRE_DEPENDENCIES_DIR)" "set(OGRE_DEPENDENCIES_DIR \${OGRE_SOURCE})" _contents "${_contents}")
  # Change in headers location
  string(REPLACE "PATH_SUFFIXES \"OGRE\"" "PATH_SUFFIXES \"OGRE-2.1\"" _contents "${_contents}")
  string(REPLACE "add_parent_dir(OGRE_INCLUDE_DIRS OGRE_INCLUDE_DIR)" "" _contents "${_contents}")
  # vcpkg uses manual-link directory to place OgreMain 
  string(REPLACE "set(OGRE_LIB_SEARCH_PATH \${dir}/lib" "set(OGRE_LIB_SEARCH_PATH \${dir}/lib/OGRE-2.1/manual-link" _contents "${_contents}")
  string(REPLACE "PATH_SUFFIXES \"\" \"Release\" \"RelWithDebInfo\" \"MinSizeRel\"" "NO_DEFAULT_PATH" _contents "${_contents}")
  string(REPLACE "PATH_SUFFIXES \"\" \"Debug\"" "NO_DEFAULT_PATH" _contents "${_contents}")
  # Missing subdirectory for Overlay
  string(REPLACE "Overlay OgreOverlaySystem.h \"\"" "Overlay OgreOverlaySystem.h \"Overlay\"" _contents "${_contents}")
  # Adjust library dirs to OGRE-2.1 and manual-link path origin
  string(REPLACE "\${COMPONENT} OGRE/\${COMPONENT}" "\${COMPONENT} OGRE-2.1/\${COMPONENT}" _contents "${_contents}")
  string(REPLACE "HINTS \${OGRE_LIBRARY_DIR_REL}" "HINTS \${OGRE_LIBRARY_DIR_REL}/../"  _contents "${_contents}" )
  string(REPLACE "HINTS \${OGRE_LIBRARY_DIR_DBG}" "HINTS \${OGRE_LIBRARY_DIR_DBG}/../"  _contents "${_contents}" )
  # Remove reference to Samples, disabled at configure time
  string(REPLACE "set(OGRE_INCLUDE_DIRS \${OGRE_INCLUDE_DIRS} \"\${OGRE_SOURCE}/Samples/Common/include\")" "" _contents "${_contents}")
  file(WRITE "${SHARE_FILE}" "${_contents}")
endforeach()

# Copy dlls
file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/bin/OGRE-2.1)
file(GLOB MAIN_REL ${CURRENT_PACKAGES_DIR}/bin/Release/* ${CURRENT_PACKAGES_DIR}/bin/Debug/*)
file(COPY ${MAIN_REL} DESTINATION ${CURRENT_PACKAGES_DIR}/bin/OGRE-2.1/)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin/Release/  ${CURRENT_PACKAGES_DIR}/bin/Debug/)

# Copy OgreMain.lib to manual-link
file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/lib/OGRE-2.1/manual-link)
file(GLOB MAIN_LIB_REL ${CURRENT_PACKAGES_DIR}/lib/OGRE-2.1/Release/OgreMain.lib ${CURRENT_PACKAGES_DIR}/lib/OGRE-2.1/Debug/OgreMain*.lib)
file(COPY ${MAIN_LIB_REL} DESTINATION ${CURRENT_PACKAGES_DIR}/lib/OGRE-2.1/manual-link)
file(REMOVE ${MAIN_LIB_REL})

# Copy all .lib files to
file(GLOB LIBS_REL DESTINATION ${CURRENT_PACKAGES_DIR}/lib/OGRE-2.1/Release/* ${CURRENT_PACKAGES_DIR}/lib/OGRE-2.1/Debug/*)
file(COPY ${LIBS_REL} DESTINATION ${CURRENT_PACKAGES_DIR}/lib/OGRE-2.1)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/lib/OGRE-2.1/Release/)

# Handle copyright
file(INSTALL ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/ogre2 RENAME copyright)

vcpkg_copy_pdbs()

# Optional support not built
# 
#rapidjson: C+#JSON parser <http://rapidjson.org/>
#Remotery: Realtime CPU/D3D/OpenGL/CUDA/Metal Profiler in a single C file with web browser viewer <https://github.com/Celtoys/Remotery>
#cg: C for graphics shader language <http://developer.nvidia.com/object/cg_toolkit.html>
#boost: Boost (general) <http://boost.org>
#boost-thread: Used for threading support <http://boost.org>
#boost-date_time: Used for threading support <http://boost.org>
#POCO: POCO framework <http://pocoproject.org/>
#tbb: Threading Building Blocks <http://www.threadingbuildingblocks.org/>
#GLSL Optimizer: GLSL Optimizer <http://github.com/aras-p/glsl-optimizer/>
#HLSL2GLSL: HLSL2GLSL <http://hlsl2glslfork.googlecode.com/>
#OIS: Input library needed for the samples <http://sourceforge.net/projects/wgois>
#SDL2: Simple DirectMedia Library <https://www.libsdl.org/>
#Doxygen: Tool for building API documentation <http://doxygen.org>
#Softimage: Softimage SDK needed for building XSIExporter <FALSE>
#TinyXML: TinyXML needed for building OgreXMLConverter <FALSE>
#CppUnit: Library for performing unit tests <http://cppunit.sourceforge.net>


