include(vcpkg_common_functions)

find_program(GIT NAMES git git.cmd)
set(GIT_URL "git://anongit.kde.org/kdoctools.git")
set(GIT_REV v5.58.0)
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

#vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_find_acquire_program(DocBookXML4_DTD)
vcpkg_find_acquire_program(DocBookXSL)
vcpkg_find_acquire_program(XGETTEXT)
vcpkg_find_acquire_program(PERL)
vcpkg_find_acquire_program(PYTHON3)
set(KI18N_PYTHON_EXECUTABLE ${PYTHON3})
get_filename_component(DocBookXML4_DTD_DIR "${DocBookXML4_DTD}" DIRECTORY)
get_filename_component(DocBookXSL_DIR "${DocBookXSL}" DIRECTORY)
get_filename_component(GETTEXT_DIR "${XGETTEXT}" DIRECTORY)
get_filename_component(PERL_DIR "${PERL}" DIRECTORY)
set(ENV{PATH} ";$ENV{PATH};${PERL_DIR};${DocBookXML4_DTD_DIR};${DocBookXSL_DIR};${GETTEXT_DIR};${CURRENT_INSTALLED_DIR}/bin;${CURRENT_INSTALLED_DIR}/debug/bin")

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
	NO_CHARSET_FLAG # automatic templates
#	GENERATOR "NMake Makefiles" # automatic templates
#    DISABLE_PARALLEL_CONFIGURE
    OPTIONS_DEBUG # automatic templates
        -DDISABLE_INSTALL_HEADERS=ON # automatic templates
#        -D =OFF
#    OPTIONS_RELEASE
#        -D =OFF
    OPTIONS 
		-DBUILD_HTML_DOCS=OFF
		-DBUILD_MAN_DOCS=OFF
		-DBUILD_QTHELP_DOCS=OFF
		-DBUILD_TESTING=OFF
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
