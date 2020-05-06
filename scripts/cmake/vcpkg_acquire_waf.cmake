# The python executable `waf` is the generic component of the meta build system 
# acquired, and needs to reside in the root of the source tree of 
# the program to be compiled. The project to be compiled only needs to provide 
# the custom build-scripts (`wscript`). If it ships with generic scripts as well,
# it remains to be seen if they work with vcpkg. This could be the case for versions
# from 1.19.11 upwards. Older versions will not recognize VS2017. If an update is 
# needed, or if a project does not ship the waf executable, it may be necessary/
# possible to replace the shipped waf-version with the one acquired here (example: 
# aubio). The replacement needs to be scripted in the portfile of the program. This
# file only handles acquisition and initial compile of the generic build-script `waf`.
# Note that a (hidden) folder 'waflib' is embedded in the executable that is
# extracted upon execution. Using other wavlib folders (addressed by a environment
# variable or contained in the project source) is discouraged, as they are likely
# incompatible with the waf executable compiled here. Better modify the waf boostrap
# exectued in belows script. Project specific build instructions should go into the 
# wscript files within the source only.
# Other than enhancements and updates, common modifications are the arguments
# of the bootstrap compile, e.g. the inclusion of optional tools (see waf-light
# help, add additional modules to the variable BOOTSTRAP_ARGUMENTS below, currently
# only msvc, msvcdeps and syms are added.)

function(vcpkg_acquire_waf)

# required interpreter
vcpkg_find_acquire_program(PYTHON3)

set(VAR "WAF")

set(PROGNAME waf)
set(REQUIRED_INTERPRETER PYTHON3)
if(CMAKE_HOST_WIN32)
	set(SCRIPTNAME waf.bat)
else()
	set(SCRIPTNAME waf-light)
endif()
set(BOOTSTRAP_SCRIPT_NAME waf-light)
set(BOOTSTRAP_ARGUMENTS configure;build;--tools=syms,msvc,msvcdeps)
set(TOOLPATH "${DOWNLOADS}/tools/waf")
set(PATHS "${TOOLPATH}/waf-2.0.18")
set(URL "https://waf.io/waf-2.0.18.tar.bz2")
set(ARCHIVE "waf-2.0.18.tar.bz2")
set(HASH aa102922dd48bd1d2f39208ee84f91330a1a5993a3471667181e3e47817d4cf57b0ff9041c1d75b6648d279de6688c7564670cb76ca19da1bd412d1603389e0a)
set(STAMP "waf.stamp")
if(NOT EXISTS "${PATHS}/${STAMP}")
  file(REMOVE_RECURSE ${TOOLPATH})
  file(MAKE_DIRECTORY ${TOOLPATH})
  # download
  if(NOT EXISTS "${DOWNLOADS}/${ARCHIVE}")
    if(_VCPKG_NO_DOWNLOADS)
      message(FATAL_ERROR "Downloads are disabled, but '${DOWNLOADS}/${ARCHIVE}' does not exist.")
    else()
      message(STATUS "Downloading ${URL}...")
      file(DOWNLOAD ${URL} ${DOWNLOADS}/${ARCHIVE}
        EXPECTED_HASH SHA512=${HASH}
        STATUS DL_STATUS
        SHOW_PROGRESS
      )
      list(GET DL_STATUS 0 STATUS_CODE)
      if (NOT "${STATUS_CODE}" STREQUAL "0")
        message(STATUS "Downloading ${URL}... Failed. Status: ${download_status}")
        file(REMOVE ${DOWNLOADS}/${ARCHIVE})
        set(DL_SUCCESS 0)
      else()
        message(STATUS "Downloading ${URL}... Done!")
        set(DL_SUCCESS 1)
      endif()
      if (NOT ${DL_SUCCESS})
        message(FATAL_ERROR
          "\n"
          "    Failed to download file.\n"
          "    Add mirrors or submit an issue at https://github.com/Microsoft/vcpkg/issues\n")
      endif()
    endif()
  else()
    message(STATUS "Using cached ${ARCHIVE}")
  endif()

  # extract
  message(STATUS "Extracting ${ARCHIVE}...")
  execute_process(
    COMMAND ${CMAKE_COMMAND} -E tar xzf ${DOWNLOADS}/${ARCHIVE}
    WORKING_DIRECTORY ${TOOLPATH}
  )
  message(STATUS "Extracting ${ARCHIVE}... Done!")

  # bootstrap
  find_file(BUILD_TOOL ${PROGNAME} PATHS ${PATHS})
  if(${BUILD_TOOL} MATCHES "-NOTFOUND" OR NOT EXISTS "${PATHS}/${STAMP}")
    message(STATUS "Bootstrapping waf 2.0.16...")
    vcpkg_execute_required_process(
      COMMAND ${PYTHON3} ${PATHS}/${BOOTSTRAP_SCRIPT_NAME} ${BOOTSTRAP_ARGUMENTS}
        WORKING_DIRECTORY ${PATHS}
        LOGNAME build-waf
    )
    file(WRITE "${PATHS}/${STAMP}" "0")
    message(STATUS "Bootstrapping waf 2.0.16... Done!")
  endif()
endif()

set(WAF_DIR ${PATHS} PARENT_SCOPE)
set(WAFDIR ${PATHS}/waflib PARENT_SCOPE)
set(${VAR} ${PYTHON3} ${PROGNAME})
set(${VAR} ${${VAR}} PARENT_SCOPE)

# If for some reason python2 is needed, the python acquisition above needs to be adjusted.
message(STATUS "\$\{${VAR}\} includes the python call and can be used in any working directory that contains a waf executable." )

endfunction()
