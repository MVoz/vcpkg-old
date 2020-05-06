include(vcpkg_common_functions)

if(VCPKG_CMAKE_SYSTEM_NAME STREQUAL "Linux")
    message("${PORT} currently requires the following tools from the system package manager:\n    python-yaml\n\nThis can be installed on Ubuntu systems via apt-get install python-yaml PYTHON2-yaml (depending on your current python default interpreter)")
endif() 

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO svaarala/duktape
    REF v2.4.0
    SHA512 5f42ff6faab8d49531423e199c032fd2de49524bab71f39d1cf822e6f9ee82a6089c9a93837ae7849d19a95693318a8480986e4672f6f73f3182b4902e6b2daa
    HEAD_REF master
)

file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH})
file(COPY ${CMAKE_CURRENT_LIST_DIR}/duktapeConfig.cmake DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT})
file(COPY ${CMAKE_CURRENT_LIST_DIR}/usage DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT})

if(CMAKE_HOST_WIN32)
    set(EXECUTABLE_SUFFIX ".exe")
else()
    set(EXECUTABLE_SUFFIX "")
endif()

vcpkg_find_acquire_program(PYTHON2)
get_filename_component(PYTHON2_DIR "${PYTHON2}" DIRECTORY)
vcpkg_add_to_path("${PYTHON2_DIR}")
if(NOT EXISTS ${PYTHON2_DIR}/easy_install${EXECUTABLE_SUFFIX})
    if(NOT EXISTS ${PYTHON2_DIR}/Scripts/pip${EXECUTABLE_SUFFIX})
        vcpkg_download_distfile(GET_PIP
            URLS "https://bootstrap.pypa.io/3.3/get-pip.py"
            FILENAME "tools/python/python2/get-pip.py"
            SHA512 1436215d2bc45a8019503aaf6c0e5f7da142108dee0fa2db282e22670eca84beff487ec45f1e6b8968c481f7009afb211a76ac93b637b48ba83f099831db33ff
        )
        execute_process(COMMAND ${PYTHON2_DIR}/python${EXECUTABLE_SUFFIX} ${PYTHON2_DIR}/get-pip.py)
    endif()
    execute_process(COMMAND ${PYTHON2_DIR}/Scripts/pip${EXECUTABLE_SUFFIX} install pyyaml)
else()
    execute_process(COMMAND ${PYTHON2_DIR}/easy_install${EXECUTABLE_SUFFIX} pyyaml)
endif()

execute_process(COMMAND ${PYTHON2} ${SOURCE_PATH}/tools/configure.py --source-directory ${SOURCE_PATH}/src-input --output-directory ${SOURCE_PATH}/src --config-metadata ${SOURCE_PATH}/config -DDUK_USE_FASTINT)

vcpkg_apply_patches(
    SOURCE_PATH ${SOURCE_PATH}
    PATCHES
        duk_config.h.patch 
)

vcpkg_configure_cmake(
    PREFER_NINJA
    SOURCE_PATH ${SOURCE_PATH}
)

vcpkg_install_cmake()

set(DUK_CONFIG_H_PATH "${CURRENT_PACKAGES_DIR}/include/duk_config.h")
file(READ ${DUK_CONFIG_H_PATH} CONTENT)
if(VCPKG_LIBRARY_LINKAGE STREQUAL dynamic)
    string(REPLACE "// #undef DUK_F_DLL_BUILD" "#undef DUK_F_DLL_BUILD\n#define DUK_F_DLL_BUILD" CONTENT "${CONTENT}")
else()
    string(REPLACE "// #undef DUK_F_DLL_BUILD" "#undef DUK_F_DLL_BUILD" CONTENT "${CONTENT}")
endif()
file(WRITE ${DUK_CONFIG_H_PATH} "${CONTENT}")

# Remove debug include
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

# Copy copright information
file(INSTALL "${SOURCE_PATH}/LICENSE.txt" DESTINATION "${CURRENT_PACKAGES_DIR}/share/duktape" RENAME "copyright")

vcpkg_copy_pdbs()
