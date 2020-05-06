include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://gitlab.kitware.com/xdmf/xdmf/-/archive/8d9c98081d89ac77a132d56bc8bef53581db4078/xdmf-8d9c98081d89ac77a132d56bc8bef53581db4078.tar.gz"
    FILENAME "xdmf-8d9c98081d89ac77a132d56bc8bef53581db4078.tar.gz"
    SHA512 32e0719b1e2889387d547a593d94a353e1d3b0e1c0f7ec8be257f966ae100ab2da33cabac16e32d8a25245b0773733e899295564290225b2b7bf43108cbe6101
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

#vcpkg_find_acquire_program(PYTHON3)
#get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
#set(ENV{PATH} "$ENV{PATH};${PYTHON3_DIR}")

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates

    OPTIONS 
      -DXDMF_BUILD_DOCUMENTATION:BOOL=OFF
      -DXDMF_BUILD_TESTING:BOOL=OFF
      -DXDMF_BUILD_UTILS:BOOL=OFF
#      -DXDMF_LIBNAME:STRING=Xdmf
      -DXDMF_WRAP_JAVA:BOOL=OFF
      -DXDMF_WRAP_PYTHON:BOOL=OFF
)

vcpkg_install_cmake()

#vcpkg_fixup_cmake_targets()

### https://mesonbuild.com/Configuring-a-build-directory.html
#vcpkg_configure_meson(
#    SOURCE_PATH ${SOURCE_PATH}
#    OPTIONS
#      --backend=ninja
#)

#vcpkg_install_meson()

###
#msbuild build-package.proj /t:Clean;BeforeBuild
#msbuild build.proj /t:Build
#msbuild build-package.proj /t:PreparePackage;Package

#vcpkg_install_msbuild(
#    SOURCE_PATH ${SOURCE_PATH}
#    PROJECT_SUBPATH "ide/vs2017/mimalloc.vcxproj"
#    TARGET restore
#    SKIP_CLEAN
#    RELEASE_CONFIGURATION Release_x86${MPG123_CONFIGURATION_SUFFIX}
#    DEBUG_CONFIGURATION Debug_x86${MPG123_CONFIGURATION_SUFFIX}
#    LICENSE_SUBPATH LICENSE
#    INCLUDES_SUBPATH hidapi ALLOW_ROOT_INCLUDES
#    ALLOW_ROOT_INCLUDES ON
#    USE_VCPKG_INTEGRATION
#)

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
#file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/xdmf RENAME copyright)

#file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/lib ${CURRENT_PACKAGES_DIR}/debug)
#file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin ${CURRENT_PACKAGES_DIR}/debug/bin ${CURRENT_PACKAGES_DIR}/debug/share ${CURRENT_PACKAGES_DIR}/debug/include)

#file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/tools)
#file(RENAME ${CURRENT_PACKAGES_DIR}/debug/bin ${CURRENT_PACKAGES_DIR}/tools/${PORT})

#vcpkg_copy_tool_dependencies(${CURRENT_PACKAGES_DIR}/tools/openexr)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME xdmf)

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
