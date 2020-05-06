#string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "static" CURL_STATICLIB)
#vcpkg_check_linkage(ONLY_STATIC_LIBRARY) ## = ## VCPKG_LIBRARY_LINKAGE=static ## = ## BUILD_STATIC_LIBS=ON
#vcpkg_check_linkage(ONLY_STATIC_LIBRARY ONLY_DYNAMIC_CRT)
#vcpkg_check_linkage(ONLY_DYNAMIC_LIBRARY)
#vcpkg_check_linkage(ONLY_DYNAMIC_LIBRARY ONLY_DYNAMIC_CRT)

include(vcpkg_common_functions)

find_program(GIT NAMES git git.cmd)
set(GIT_URL "http://gitlab.dpi.inpe.br/terralib/terralib.git")
set(GIT_REV master)
set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/${PORT})
if(NOT EXISTS "${SOURCE_PATH}/.git")
    message(STATUS "Cloning and fetching submodules")
    vcpkg_execute_required_process(
      COMMAND ${GIT} -c http.sslVerify=false clone --recurse-submodules ${GIT_URL} ${SOURCE_PATH}
      WORKING_DIRECTORY ${SOURCE_PATH}
      LOGNAME clone
    )
    message(STATUS "Checkout revision ${GIT_REV}")
    vcpkg_execute_required_process(
      COMMAND ${GIT} checkout ${GIT_REV}
      WORKING_DIRECTORY ${SOURCE_PATH}
      LOGNAME checkout
    )
endif()

# -- Found R: E:/tools/R/R_SERVER/include (found version "") #deps???
vcpkg_find_acquire_program(PYTHON3)
#vcpkg_find_acquire_program(QT5)
vcpkg_find_acquire_program(SWIG)
vcpkg_find_acquire_program(XGETTEXT)
vcpkg_find_acquire_program(DOXYGEN)
#vcpkg_find_acquire_program(DOXYGEN)
#vcpkg_find_acquire_program(PERL)
#vcpkg_find_acquire_program(FLEX)
#vcpkg_find_acquire_program(BISON)
#get_filename_component(FLEX_DIR "${FLEX}" DIRECTORY)
#get_filename_component(BISON_DIR "${BISON}" DIRECTORY)
get_filename_component(DOXYGEN_DIR "${DOXYGEN}" DIRECTORY)
#get_filename_component(PERL_DIR "${PERL}" DIRECTORY)
#get_filename_component(QT5_DIR "${QT5}" DIRECTORY)
get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
get_filename_component(SWIG_DIR "${SWIG}" DIRECTORY)
get_filename_component(GETTEXT_DIR "${XGETTEXT}" DIRECTORY)
#get_filename_component(TEXLIVE_DIR "${TEXLIVE}" DIRECTORY)
#set(ENV{PATH} ";$ENV{PATH};${QT5_DIR};${PYTHON3_DIR};${DOXYGEN_DIR};${XGETTEXT_DIR};${TEXLIVE_DIR};${FLEX_DIR};${BISON_DIR};${DOXYGEN_DIR};${PERL_DIR}")
#vcpkg_find_acquire_program(YASM)
#get_filename_component(YASM_EXE_PATH ${YASM} DIRECTORY)
set(ENV{PATH} "$ENV{PATH};${DOXYGEN_DIR};${SWIG_DIR};${GETTEXT_DIR};${PYTHON3_DIR}")

#get_filename_component(GIT_EXE_PATH ${GIT} DIRECTORY)
#set(SH_EXE_PATH "${GIT_EXE_PATH}/../usr/bin")
#set(ENV{PATH} "$ENV{PATH};${VALAC_DIR};${BISON_DIR};${FLEX_DIR};${SH_EXE_PATH}")

#file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH})

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}/build/cmake
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates
    OPTIONS 
      -DBUILD_TESTING=OFF
      -DTERRALIB_BUILD_UNITTEST_ENABLED=OFF
      -DTERRALIB_BUILD_EXAMPLES_ENABLED=OFF
	  -DTERRALIB_TRANSLATOR_ENABLED=OFF
	  -DTERRALIB_BUILD_AS_BUNDLE:BOOL=1
	  -DTERRALIB_BUILD_AS_DEV:BOOL=1
	  -DTERRALIB_MOD_STATISTICS_CORE_ENABLED:BOOL=OFF ### error
	  -DTERRALIB_BUILD_ITEST_ENABLED:BOOL=OFF
      -DTERRALIB_EXAMPLE_ADO_ENABLED=OFF
      -DTERRALIB_EXAMPLE_ATTRIBUTEFILL_ENABLED=OFF
      -DTERRALIB_EXAMPLE_BINDING_LUA_ENABLED=OFF
      -DTERRALIB_EXAMPLE_CELLSPACE_ENABLED=OFF
      -DTERRALIB_EXAMPLE_COMMON_ENABLED=OFF
      -DTERRALIB_EXAMPLE_CORE_ENABLED=OFF
      -DTERRALIB_EXAMPLE_DATAACCESS_ENABLED=OFF
      -DTERRALIB_EXAMPLE_FACTORY_ENABLED=OFF
      -DTERRALIB_EXAMPLE_GAP_ENABLED=OFF
      -DTERRALIB_EXAMPLE_GEOMETRY_ENABLED=OFF
      -DTERRALIB_EXAMPLE_RASTER_ENABLED=OFF
      -DTERRALIB_EXAMPLE_RP_ENABLED=OFF
      -DTERRALIB_EXAMPLE_SAM_ENABLED=OFF
      -DTERRALIB_EXAMPLE_SERIALIZATION_ENABLED=OFF
      -DTERRALIB_EXAMPLE_SRS_ENABLED=OFF
      -DTERRALIB_EXAMPLE_ST_ENABLED=OFF
      -DTERRALIB_EXAMPLE_TIN_ENABLED=OFF
      -DTERRALIB_EXAMPLE_VP_ENABLED=OFF
      -DTERRALIB_EXAMPLE_XERCES_ENABLED=OFF
      -DTERRALIB_UNITTEST_CLASSIFICATION_ENABLED=OFF
      -DTERRALIB_UNITTEST_COMMON_ENABLED=OFF
      -DTERRALIB_UNITTEST_CORE_ENABLED=OFF
      -DTERRALIB_UNITTEST_DATAACCESS_ENABLED=OFF
      -DTERRALIB_UNITTEST_DATATYPE_ENABLED=OFF
      -DTERRALIB_UNITTEST_EDIT_ENABLED=OFF
      -DTERRALIB_UNITTEST_FIXGEOMETRIES_ENABLED=OFF
      -DTERRALIB_UNITTEST_GEOMETRY_ENABLED=OFF
      -DTERRALIB_UNITTEST_MEMORY_ENABLED=OFF
      -DTERRALIB_UNITTEST_OGR_ENABLED=OFF
      -DTERRALIB_UNITTEST_POSTGIS_ENABLED=OFF
      -DTERRALIB_UNITTEST_RASTER_ENABLED=OFF
      -DTERRALIB_UNITTEST_RP_ENABLED=OFF
      -DTERRALIB_UNITTEST_SAM_ENABLED=OFF
      -DTERRALIB_UNITTEST_SRS_ENABLED=OFF
      -DTERRALIB_UNITTEST_VP_ENABLED=OFF
      -DTERRALIB_UNITTEST_WS_CORE_ENABLED=OFF
      -DTERRALIB_UNITTEST_WS_OGC_WCS_ENABLED=OFF
      -DTERRALIB_UNITTEST_WS_OGC_WMS_ENABLED=OFF
      -DUSE_QT4=OFF
      -DUSE_QT5=OFF
      -DTERRALIB_LOGGER_DEBUG_ENABLED=ON
      -DTERRALIB_LOGGER_ENABLED=ON ### LOGGER - error
      -DTERRALIB_LOGGER_ERROR_ENABLED=ON
      -DTERRALIB_LOGGER_FATAL_ENABLED=ON
      -DTERRALIB_LOGGER_INFO_ENABLED=ON
      -DTERRALIB_LOGGER_TRACE_ENABLED=ON
      -DTERRALIB_LOGGER_WARN_ENABLED=ON
#      -Dterralib4_DIR:PATH=terralib4_DIR-NOTFOUND
#      -Dterralib_layout_DIR:PATH=terralib_layout_DIR-NOTFOUND
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
#file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/terralib RENAME copyright)

#file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/lib ${CURRENT_PACKAGES_DIR}/debug)
#file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin ${CURRENT_PACKAGES_DIR}/debug/bin ${CURRENT_PACKAGES_DIR}/debug/share ${CURRENT_PACKAGES_DIR}/debug/include)

#file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/tools)
#file(RENAME ${CURRENT_PACKAGES_DIR}/debug/bin ${CURRENT_PACKAGES_DIR}/tools/${PORT})

#vcpkg_copy_tool_dependencies(${CURRENT_PACKAGES_DIR}/tools/openexr)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME terralib)

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
configure_file(${SOURCE_PATH}/COPYING ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
