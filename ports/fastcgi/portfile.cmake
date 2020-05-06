include(vcpkg_common_functions)

set(FASTCGI_VERSION_STR "2.4.2")
vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/FastCGI-Archives/fcgi2/archive/${FASTCGI_VERSION_STR}.tar.gz"
    FILENAME "FastCGI-Archives-fcgi2-${FASTCGI_VERSION_STR}.tar.gz"
    SHA512 03aca9899eacfd54c878b30691cc4f8db957a065b46426d764003fd057cbf24b4e12ddd26c9b980d5d8965ca40831e415d330e9830529c0d4153400b5c2c8c02
)

# Extract source into architecture specific directory, because FCGI2s' nmake based build currently does not
# support out of source builds.
set(SOURCE_PATH_DEBUG   ${CURRENT_BUILDTREES_DIR}/src-${TARGET_TRIPLET}-debug/fcgi2-${FASTCGI_VERSION_STR})
set(SOURCE_PATH_RELEASE ${CURRENT_BUILDTREES_DIR}/src-${TARGET_TRIPLET}-release/fcgi2-${FASTCGI_VERSION_STR})

if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "release")
    list(APPEND BUILD_TYPES "release")
endif()
if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "debug")
    list(APPEND BUILD_TYPES "debug")
endif()

foreach(BUILD_TYPE IN LISTS BUILD_TYPES)
    file(REMOVE_RECURSE ${CURRENT_BUILDTREES_DIR}/src-${TARGET_TRIPLET}-${BUILD_TYPE})
    vcpkg_extract_source_archive(${ARCHIVE} ${CURRENT_BUILDTREES_DIR}/src-${TARGET_TRIPLET}-${BUILD_TYPE})
	vcpkg_apply_patches(
	  SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src-${TARGET_TRIPLET}-${BUILD_TYPE}/fcgi2-${FASTCGI_VERSION_STR}
	  PATCHES
	  # Thanks to the libfastcgi.zip provided by Voskrese, the patch supporting x64 is made according to the contents of fcgi-2.4.0-x64.patch.
	  ${CMAKE_CURRENT_LIST_DIR}/fastcgi-x64.patch
	)
endforeach()

if (NOT VCPKG_CMAKE_SYSTEM_NAME)
  # Check build system first
  find_program(NMAKE nmake REQUIRED)

  list(APPEND NMAKE_OPTIONS_REL
      ${NMAKE_OPTIONS}
      CFG=release      
  )

  list(APPEND NMAKE_OPTIONS_DBG
      ${NMAKE_OPTIONS}
      CFG=debug
  )
  
  # Begin build process
  if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "release")
    ################
    # Release build
    ################
    message(STATUS "Building ${TARGET_TRIPLET}-rel")
    vcpkg_execute_required_process(
      COMMAND ${NMAKE} -f Makefile.nt
      "${NMAKE_OPTIONS_REL}"
      WORKING_DIRECTORY ${SOURCE_PATH_RELEASE}
      LOGNAME nmake-build-${TARGET_TRIPLET}-release
    )
	
	file(COPY ${SOURCE_PATH_RELEASE}/libfcgi/Release/libfcgi.lib DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
	file(GLOB FCGI_INCLUDE_FILES ${SOURCE_PATH_RELEASE}/include/*.h)
	file(COPY ${FCGI_INCLUDE_FILES} DESTINATION ${CURRENT_PACKAGES_DIR}/include/fastcgi)
	
	if (NOT VCPKG_CRT_LINKAGE STREQUAL static)
		file(COPY ${SOURCE_PATH_RELEASE}/libfcgi/Release/libfcgi.dll DESTINATION ${CURRENT_PACKAGES_DIR}/bin)	
		file(COPY ${SOURCE_PATH_RELEASE}/cgi-fcgi/Release/cgi-fcgi.exe DESTINATION ${CURRENT_PACKAGES_DIR}/tools/fastcgi)
		file(COPY ${SOURCE_PATH_RELEASE}/examples/authorizer/Release/authorizer.exe DESTINATION ${CURRENT_PACKAGES_DIR}/tools/fastcgi)
		file(COPY ${SOURCE_PATH_RELEASE}/examples/echo/Release/echo.exe DESTINATION ${CURRENT_PACKAGES_DIR}/tools/fastcgi)
		file(COPY ${SOURCE_PATH_RELEASE}/examples/echo-cpp/Release/echo-cpp.exe DESTINATION ${CURRENT_PACKAGES_DIR}/tools/fastcgi)
		file(COPY ${SOURCE_PATH_RELEASE}/examples/echo-x/Release/echo-x.exe DESTINATION ${CURRENT_PACKAGES_DIR}/tools/fastcgi)
		file(COPY ${SOURCE_PATH_RELEASE}/examples/size/Release/size.exe DESTINATION ${CURRENT_PACKAGES_DIR}/tools/fastcgi)
	endif()
    message(STATUS "Building ${TARGET_TRIPLET}-rel done")
  endif()

  if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "debug")
    ################
    # Debug build
    ################

    message(STATUS "Building ${TARGET_TRIPLET}-dbg")
    vcpkg_execute_required_process(
      COMMAND ${NMAKE} /G -f Makefile.nt
      "${NMAKE_OPTIONS_DBG}"
      WORKING_DIRECTORY ${SOURCE_PATH_DEBUG}
      LOGNAME nmake-build-${TARGET_TRIPLET}-debug
    )
	
	file(COPY ${SOURCE_PATH_DEBUG}/libfcgi/Debug/libfcgi.lib DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)
	if (NOT VCPKG_CRT_LINKAGE STREQUAL static)
		file(COPY ${SOURCE_PATH_DEBUG}/libfcgi/Debug/libfcgi.dll DESTINATION ${CURRENT_PACKAGES_DIR}/debug/bin)
		file(COPY ${SOURCE_PATH_DEBUG}/cgi-fcgi/Debug/cgi-fcgi.exe DESTINATION ${CURRENT_PACKAGES_DIR}/debug/tools/fastcgi)
		file(COPY ${SOURCE_PATH_DEBUG}/examples/authorizer/Debug/authorizer.exe DESTINATION ${CURRENT_PACKAGES_DIR}/debug/tools/fastcgi)
		file(COPY ${SOURCE_PATH_DEBUG}/examples/echo/Debug/echo.exe DESTINATION ${CURRENT_PACKAGES_DIR}/debug/tools/fastcgi)
		file(COPY ${SOURCE_PATH_DEBUG}/examples/echo-cpp/Debug/echo-cpp.exe DESTINATION ${CURRENT_PACKAGES_DIR}/debug/tools/fastcgi)
		file(COPY ${SOURCE_PATH_DEBUG}/examples/echo-x/Debug/echo-x.exe DESTINATION ${CURRENT_PACKAGES_DIR}/debug/tools/fastcgi)
		file(COPY ${SOURCE_PATH_DEBUG}/examples/size/Debug/size.exe DESTINATION ${CURRENT_PACKAGES_DIR}/debug/tools/fastcgi)
	endif()
    message(STATUS "Building ${TARGET_TRIPLET}-dbg done")
  endif()

  message(STATUS "Packaging ${TARGET_TRIPLET}")

elseif (VCPKG_CMAKE_SYSTEM_NAME STREQUAL "Linux" OR VCPKG_CMAKE_SYSTEM_NAME STREQUAL "Darwin") # Build in UNIX
  # Check build system first
  find_program(MAKE make)
  if (NOT MAKE)
      message(FATAL_ERROR "MAKE not found")
  endif()

  if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "release")
    ################
    # Release build
    ################
    message(STATUS "Configuring ${TARGET_TRIPLET}-rel")
    set(OUT_PATH_RELEASE ${SOURCE_PATH_RELEASE}/../../make-build-${TARGET_TRIPLET}-release)
    file(MAKE_DIRECTORY ${OUT_PATH_RELEASE})
	vcpkg_execute_required_process(
      COMMAND "${SOURCE_PATH_RELEASE}/autogen.sh"
      WORKING_DIRECTORY ${SOURCE_PATH_RELEASE}
      LOGNAME config-${TARGET_TRIPLET}-rel
    )
	
    vcpkg_execute_required_process(
      COMMAND "${SOURCE_PATH_RELEASE}/configure" --prefix=${OUT_PATH_RELEASE}
      WORKING_DIRECTORY ${SOURCE_PATH_RELEASE}
      LOGNAME config-${TARGET_TRIPLET}-rel
    )

    message(STATUS "Building ${TARGET_TRIPLET}-rel")
    vcpkg_execute_required_process(
      COMMAND make
      WORKING_DIRECTORY ${SOURCE_PATH_RELEASE}
      LOGNAME make-build-${TARGET_TRIPLET}-release
    )

    message(STATUS "Installing ${TARGET_TRIPLET}-rel")
    vcpkg_execute_required_process(
      COMMAND make install
      WORKING_DIRECTORY ${SOURCE_PATH_RELEASE}
      LOGNAME make-install-${TARGET_TRIPLET}-release
    )

    file(COPY ${OUT_PATH_RELEASE}/lib DESTINATION ${CURRENT_PACKAGES_DIR})
    file(COPY ${OUT_PATH_RELEASE}/include DESTINATION ${CURRENT_PACKAGES_DIR})
    message(STATUS "Installing ${TARGET_TRIPLET}-rel done")
  endif()

  if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "debug")
    ################
    # Debug build
    ################
    message(STATUS "Configuring ${TARGET_TRIPLET}-dbg")
    set(OUT_PATH_DEBUG ${SOURCE_PATH_RELEASE}/../../make-build-${TARGET_TRIPLET}-debug)
    file(MAKE_DIRECTORY ${OUT_PATH_DEBUG})
	vcpkg_execute_required_process(
      COMMAND "${SOURCE_PATH_DEBUG}/autogen.sh"
      WORKING_DIRECTORY ${SOURCE_PATH_DEBUG}
      LOGNAME config-${TARGET_TRIPLET}-debug
    )
	
    vcpkg_execute_required_process(
      COMMAND "${SOURCE_PATH_DEBUG}/configure" --prefix=${OUT_PATH_DEBUG}
      WORKING_DIRECTORY ${SOURCE_PATH_DEBUG}
      LOGNAME config-${TARGET_TRIPLET}-debug
    )

    message(STATUS "Building ${TARGET_TRIPLET}-dbg")
    vcpkg_execute_required_process(
      COMMAND make
      WORKING_DIRECTORY ${SOURCE_PATH_DEBUG}
      LOGNAME make-build-${TARGET_TRIPLET}-debug
    )

    message(STATUS "Installing ${TARGET_TRIPLET}-dbg")
    vcpkg_execute_required_process(
      COMMAND make -j install
      WORKING_DIRECTORY ${SOURCE_PATH_DEBUG}
      LOGNAME make-install-${TARGET_TRIPLET}-debug
    )

    file(COPY ${OUT_PATH_DEBUG}/lib DESTINATION ${CURRENT_PACKAGES_DIR}/debug)
    message(STATUS "Installing ${TARGET_TRIPLET}-dbg done")
  endif()
elseif(VCPKG_CMAKE_SYSTEM_NAME STREQUAL "WindowsStore")
	file(GLOB FCGI_INCLUDE_FILES ${SOURCE_PATH_RELEASE}/include/*.h)
	file(COPY ${FCGI_INCLUDE_FILES} DESTINATION ${CURRENT_PACKAGES_DIR}/include/fastcgi)
else() # Other build system
  message(STATUS "Unsupport build system.")
endif()

# Handle copyright
configure_file(${SOURCE_PATH_RELEASE}/LICENSE.TERMS ${CURRENT_PACKAGES_DIR}/share/fastcgi/copyright COPYONLY)
