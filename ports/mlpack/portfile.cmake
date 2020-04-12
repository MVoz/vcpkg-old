<<<<<<< HEAD
include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO mlpack/mlpack
    REF mlpack-3.1.0
    SHA512 dc305a9a2f7232d3957206a346d0ac97ba13b933d5dbef45329002b8380ecc0982621c0b97f6c5ee82d0a26ad53b1cdd7a9b991fb749efc8546394988ac40a5b
    HEAD_REF master
	PATCHES 
		cmakelists.patch
)

string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "dynamic" MLPACK_SHARED_LIBS)

set(BUILD_TOOLS OFF)
if("tools" IN_LIST FEATURES)
    set(BUILD_TOOLS ON)
endif()

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
	OPTIONS
		-DBUILD_TESTS=${BUILD_TOOLS}
		-DBUILD_CLI_EXECUTABLES=${BUILD_TOOLS}
		-DBUILD_SHARED_LIBS=${MLPACK_SHARED_LIBS}
)
vcpkg_install_cmake()
vcpkg_copy_pdbs()

file(INSTALL ${SOURCE_PATH}/COPYRIGHT.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/mlpack RENAME copyright)

if(BUILD_TOOLS)
	file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/tools)
	file(GLOB MLPACK_TOOLS ${CURRENT_PACKAGES_DIR}/bin/*.exe)
	file(COPY ${MLPACK_TOOLS} DESTINATION ${CURRENT_PACKAGES_DIR}/tools/${PORT})
	file(REMOVE ${MLPACK_TOOLS})
	file(GLOB MLPACK_TOOLS_DEBUG ${CURRENT_PACKAGES_DIR}/debug/bin/*.exe)
	file(REMOVE ${MLPACK_TOOLS_DEBUG})
endif()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
=======
include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO mlpack/mlpack
    REF mlpack-3.1.0
    SHA512 dc305a9a2f7232d3957206a346d0ac97ba13b933d5dbef45329002b8380ecc0982621c0b97f6c5ee82d0a26ad53b1cdd7a9b991fb749efc8546394988ac40a5b
    HEAD_REF master
	PATCHES 
		cmakelists.patch
)

string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "dynamic" MLPACK_SHARED_LIBS)

set(BUILD_TOOLS OFF)
if("tools" IN_LIST FEATURES)
    set(BUILD_TOOLS ON)
endif()

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
	OPTIONS
		-DBUILD_TESTS=${BUILD_TOOLS}
		-DBUILD_CLI_EXECUTABLES=${BUILD_TOOLS}
		-DBUILD_SHARED_LIBS=${MLPACK_SHARED_LIBS}
)
vcpkg_install_cmake()
vcpkg_copy_pdbs()

file(INSTALL ${SOURCE_PATH}/COPYRIGHT.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/mlpack RENAME copyright)

if(BUILD_TOOLS)
	file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/tools)
	file(GLOB MLPACK_TOOLS ${CURRENT_PACKAGES_DIR}/bin/*.exe)
	file(COPY ${MLPACK_TOOLS} DESTINATION ${CURRENT_PACKAGES_DIR}/tools/${PORT})
	file(REMOVE ${MLPACK_TOOLS})
	file(GLOB MLPACK_TOOLS_DEBUG ${CURRENT_PACKAGES_DIR}/debug/bin/*.exe)
	file(REMOVE ${MLPACK_TOOLS_DEBUG})
endif()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
>>>>>>> [mlpack] Updated to version 3.1.0 (#6263)
