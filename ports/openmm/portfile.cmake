include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/openmm/openmm/archive/3e53227566c9ee1009374df728aed49ba926016c.zip"
    FILENAME "openmm.zip"
    SHA512 43c13c3612163db93ad843d490cd7160a22cdc8cfbf0f0ffc493f01c55220c49c17db0e8c7d70b129e108d85c4a22a506583acba43ac47efea0624465ac86511
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_find_acquire_program(PYTHON3)
#vcpkg_find_acquire_program(QT5)
vcpkg_find_acquire_program(SWIG)
#vcpkg_find_acquire_program(XGETTEXT)
vcpkg_find_acquire_program(DOXYGEN)
#vcpkg_find_acquire_program(DOXYGEN)
#vcpkg_find_acquire_program(PERL)
#vcpkg_find_acquire_program(FLEX)
#vcpkg_find_acquire_program(BISON)
#get_filename_component(FLEX_DIR "${FLEX}" DIRECTORY)
#get_filename_component(BISON_DIR "${BISON}" DIRECTORY)
#get_filename_component(DOXYGEN_DIR "${DOXYGEN}" DIRECTORY)
#get_filename_component(PERL_DIR "${PERL}" DIRECTORY)
#get_filename_component(QT5_DIR "${QT5}" DIRECTORY)
get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
get_filename_component(DOXYGEN_DIR "${DOXYGEN}" DIRECTORY)
get_filename_component(SWIG_DIR "${SWIG}" DIRECTORY)
#get_filename_component(TEXLIVE_DIR "${TEXLIVE}" DIRECTORY)
#set(ENV{PATH} ";$ENV{PATH};${QT5_DIR};${PYTHON3_DIR};${DOXYGEN_DIR};${XGETTEXT_DIR};${TEXLIVE_DIR};${FLEX_DIR};${BISON_DIR};${DOXYGEN_DIR};${PERL_DIR}")
#vcpkg_find_acquire_program(YASM)
#get_filename_component(YASM_EXE_PATH ${YASM} DIRECTORY)
set(ENV{PATH} "$ENV{PATH};${PYTHON3_DIR};${DOXYGEN_DIR};${SWIG_DIR}")

#get_filename_component(GIT_EXE_PATH ${GIT} DIRECTORY)
#set(SH_EXE_PATH "${GIT_EXE_PATH}/../usr/bin")
#set(ENV{PATH} "$ENV{PATH};${VALAC_DIR};${BISON_DIR};${FLEX_DIR};${SH_EXE_PATH}")

#file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH})

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates
#    GENERATOR "NMake Makefiles" # automatic templates
#    DISABLE_PARALLEL_CONFIGURE
    OPTIONS_DEBUG # automatic templates
      -DDISABLE_INSTALL_HEADERS=ON # automatic templates
      -DINSTALL_HEADERS_TOOLS=OFF
      -DINSTALL_HEADERS=OFF
    OPTIONS_RELEASE 
      -DINSTALL_HEADERS=ON # automatic templates
#      -D =OFF
    OPTIONS 
      -DBUILD_TESTING=OFF
#      -DOPENMM_BUILD_SHARED_LIB:BOOL=ON
#      -DOPENMM_BUILD_STATIC_LIB:BOOL=OFF
#      -DCUDA_USE_STATIC_CUDA_RUNTIME:BOOL=ON

#      -DCUDA_SDK_ROOT_DIR:PATH=CUDA_SDK_ROOT_DIR-NOTFOUND
#      -DCUDA_TOOLKIT_ROOT_DIR:PATH=C:/Program Files/PGI/win64/2018/cuda/10.0
#      -DCUDA_nvrtc_LIBRARY:FILEPATH=C:/Program Files/PGI/win64/2018/cuda/10.0/lib/x64/nvrtc.lib
#      -DOPENMM_BUILD_AMOEBA_CUDA_LIB:BOOL=ON
#      -DOPENMM_BUILD_AMOEBA_PLUGIN:BOOL=ON
#      -DOPENMM_BUILD_CPU_LIB:BOOL=ON
#      -DOPENMM_BUILD_CUDA_COMPILER_PLUGIN:BOOL=ON
#      -DOPENMM_BUILD_CUDA_DOUBLE_PRECISION_TESTS:BOOL=TRUE
#      -DOPENMM_BUILD_CUDA_LIB:BOOL=ON
      -DOPENMM_BUILD_CUDA_TESTS:BOOL=FALSE
#      -DOPENMM_BUILD_C_AND_FORTRAN_WRAPPERS:BOOL=ON
#      -DOPENMM_BUILD_DRUDE_CUDA_LIB:BOOL=ON
#      -DOPENMM_BUILD_DRUDE_OPENCL_LIB:BOOL=ON
#      -DOPENMM_BUILD_DRUDE_PLUGIN:BOOL=ON
      -DOPENMM_BUILD_EXAMPLES:BOOL=OFF
#      -DOPENMM_BUILD_OPENCL_DOUBLE_PRECISION_TESTS:BOOL=TRUE
#      -DOPENMM_BUILD_OPENCL_LIB:BOOL=ON
      -DOPENMM_BUILD_OPENCL_TESTS:BOOL=FALSE
#      -DOPENMM_BUILD_PME_PLUGIN:BOOL=ON
      -DOPENMM_BUILD_PYTHON_WRAPPERS:BOOL=OFF
#      -DOPENMM_BUILD_RPMD_CUDA_LIB:BOOL=ON
#      -DOPENMM_BUILD_RPMD_OPENCL_LIB:BOOL=ON
#      -DOPENMM_BUILD_RPMD_PLUGIN:BOOL=ON
#      -DOPENMM_GENERATE_API_DOCS:BOOL=OFF
#      -DSWIG_EXECUTABLE:FILEPATH=
)

vcpkg_install_cmake()

#file(GLOB_RECURSE TMP_FILES "${SOURCE_PATH}/include/*.hin" "${SOURCE_PATH}/include/*.orig" "${SOURCE_PATH}/include/*.in")
#file(REMOVE_RECURSE ${TMP_FILES})

#remove_srcs_file("${SOURCE_PATH}/include/*.hin" "${SOURCE_PATH}/include/*.orig" "${SOURCE_PATH}/include/*.in")

#file(COPY ${SOURCE_PATH}/include DESTINATION ${CURRENT_PACKAGES_DIR}/include)
#file(RENAME ${CURRENT_PACKAGES_DIR}/include/include ${CURRENT_PACKAGES_DIR}/include/openldap)

#file(TO_NATIVE_PATH "${CURRENT_INSTALLED_DIR}/include" PGSQL_INCLUDE_DIR)
#file(COPY ${CURRENT_PACKAGES_DIR}/wpilib/lib/ DESTINATION ${CURRENT_PACKAGES_DIR}/bin FILES_MATCHING PATTERN "*.dll")
#file(COPY ${SOURCE_PATH}/greatest.h DESTINATION ${CURRENT_PACKAGES_DIR}/include)

#vcpkg_fixup_cmake_targets(CONFIG_PATH "lib/cmake/${PORT}")
#vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/nlohmann_json TARGET_PATH share/nlohmann_json)
#file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/bin)
#file(RENAME ${CURRENT_PACKAGES_DIR}/lib/${LIB_NAME}.dll ${CURRENT_PACKAGES_DIR}/bin/${LIB_NAME}.dll
#file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/openmm RENAME copyright)

#file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/lib ${CURRENT_PACKAGES_DIR}/debug)
#file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin ${CURRENT_PACKAGES_DIR}/debug/bin ${CURRENT_PACKAGES_DIR}/debug/share ${CURRENT_PACKAGES_DIR}/debug/include)

#file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/tools)
#file(RENAME ${CURRENT_PACKAGES_DIR}/debug/bin ${CURRENT_PACKAGES_DIR}/tools/${PORT})

#vcpkg_copy_tool_dependencies(${CURRENT_PACKAGES_DIR}/tools/openexr)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME openmm)

#install(
#    TARGETS ${PROJECT} 
#    EXPORT ${PROJECT}-export
#    RUNTIME DESTINATION ${BINARY_INSTALL_DIR}
#    LIBRARY DESTINATION ${LIBRARY_INSTALL_DIR}
#    ARCHIVE DESTINATION ${LIBRARY_INSTALL_DIR}
#    BUNDLE DESTINATION .
##    FRAMEWORK DESTINATION ${FRAMEWORK_INSTALL_DIR}
##    PUBLIC_HEADER DESTINATION ${INCLUDE_INSTALL_DIR}/qjson${QJSON_SUFFIX}
#)

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
