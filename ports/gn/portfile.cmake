include(vcpkg_common_functions)

find_program(GIT NAMES git git.cmd)
set(GIT_URL "https://gn.googlesource.com/gn")
set(GIT_REV master)
set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/${PORT})
if(NOT EXISTS "${SOURCE_PATH}/.git")
	message(STATUS "Cloning and fetching submodules")
	vcpkg_execute_required_process(
	  COMMAND ${GIT} clone --recurse-submodules ${GIT_URL} ${SOURCE_PATH}
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

vcpkg_find_acquire_program(NINJA)
vcpkg_find_acquire_program(PYTHON2)
get_filename_component(PYTHON2_DIR "${PYTHON2}" DIRECTORY)
get_filename_component(GIT_DIR "${GIT}" DIRECTORY)
set(ENV{PATH} "$ENV{PATH};${PYTHON2_DIR};${GIT_DIR}")

vcpkg_execute_required_process(
    COMMAND ${PYTHON2} build/gen.py
    WORKING_DIRECTORY ${SOURCE_PATH}
    LOGNAME gen-${TARGET_TRIPLET}
)

set(ENV{NO-DEV} True)
set(CLICOLOR_FORCE 1)
set(ENV{CLICOLOR_FORCE} "1")
set(ENV{NINJA_STATUS} "[%u/%r processes, %s/%f/%t @ %o(%c)/s : %es ] (%e)")
#set(ENV{NINJA_SUMMARIZE_BUILD} "1")
#set(ENV{NINJA_STATUS} "%es [%p/%s/%t] ")
#set(ENV{NINJA_STATUS} "[%p]")
#os.environ['NINJA_STATUS'] = '[%f/%t][%p][%es] '
set(ENV{CMAKE_RULE_MESSAGES} "OFF")
set(CMAKE_RULE_MESSAGES "OFF")
#NINJA_STATUS="[%f/%t][%e] "; %ninja_build -C %{_target_platform} ...
#NINJAFLAGS="-j1" MAKEOPTS="-j1" emerge -av1 =webkit-gtk-2.16.1

execute_process(
    COMMAND ${NINJA} -C out -d stats
    WORKING_DIRECTORY ${SOURCE_PATH}
    RESULT_VARIABLE build-${TARGET_TRIPLET}
)

file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/tools/gn)
file(COPY ${SOURCE_PATH}/out/gn.exe DESTINATION ${CURRENT_PACKAGES_DIR}/tools/gn)

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
