include(vcpkg_common_functions)

vcpkg_from_github(
	OUT_SOURCE_PATH SOURCE_PATH
	REPO openscenegraph/OpenSceneGraph
	REF OpenSceneGraph-3.6.4
	SHA512 7cb34fc279ba62a7d7177d3f065f845c28255688bd29026ffb305346e1bb2e515a22144df233e8a7246ed392044ee3e8b74e51bf655282d33ab27dcaf12f4b19
	HEAD_REF master
    PATCHES
        collada.patch
        static.patch
        fix-example-application.patch
        fix-sdl.patch
)

if(VCPKG_LIBRARY_LINKAGE STREQUAL "static")
    set(OSG_DYNAMIC OFF)
else()
    set(OSG_DYNAMIC ON)
endif()

file(REMOVE ${SOURCE_PATH}/CMakeModules/FindSDL2.cmake)

set(OSG_USE_UTF8_FILENAME ON)
if (VCPKG_CMAKE_SYSTEM_NAME STREQUAL "Linux")
    message("Build osg requires gcc with version higher than 4.7.")
    # Enable OSG_USE_UTF8_FILENAME will call some windows-only functions.
    set(OSG_USE_UTF8_FILENAME OFF)
endif()

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
        -DOSG_USE_UTF8_FILENAME=${OSG_USE_UTF8_FILENAME}
        -DDYNAMIC_OPENSCENEGRAPH=${OSG_DYNAMIC}
        -DDYNAMIC_OPENTHREADS=${OSG_DYNAMIC}
        -DBUILD_OSG_EXAMPLES=ON
        -DBUILD_OSG_APPLICATIONS=ON
)

vcpkg_install_cmake()

# handle osg tools and plugins
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

set(OSG_TOOL_PATH ${CURRENT_PACKAGES_DIR}/tools/osg)
file(MAKE_DIRECTORY ${OSG_TOOL_PATH})

file(GLOB OSG_TOOLS ${CURRENT_PACKAGES_DIR}/bin/*.exe)
file(COPY ${OSG_TOOLS} DESTINATION ${OSG_TOOL_PATH})
file(REMOVE_RECURSE ${OSG_TOOLS})
file(GLOB OSG_TOOLS_DBG ${CURRENT_PACKAGES_DIR}/debug/bin/*.exe)
file(REMOVE_RECURSE ${OSG_TOOLS_DBG})

file(GLOB OSG_PLUGINS_DBG ${CURRENT_PACKAGES_DIR}/debug/bin/osgPlugins-3.6.4/*.dll)
file(COPY ${OSG_PLUGINS_DBG} DESTINATION ${CURRENT_PACKAGES_DIR}/debug/tools/osg/osgPlugins-3.6.4)
file(GLOB OSG_PLUGINS_REL ${CURRENT_PACKAGES_DIR}/bin/osgPlugins-3.6.4/*.dll)
file(COPY ${OSG_PLUGINS_REL} DESTINATION ${OSG_TOOL_PATH}/osgPlugins-3.6.4)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/bin/osgPlugins-3.6.4/)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin/osgPlugins-3.6.4/)

# Handle copyright
file(COPY ${SOURCE_PATH}/LICENSE.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/osg)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/osg/LICENSE.txt ${CURRENT_PACKAGES_DIR}/share/osg/copyright)

#Cleanup
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/lib/pkgconfig ${CURRENT_PACKAGES_DIR}/debug/lib/pkgconfig)

if(VCPKG_LIBRARY_LINKAGE STREQUAL static)
    file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin ${CURRENT_PACKAGES_DIR}/debug/bin)
endif()