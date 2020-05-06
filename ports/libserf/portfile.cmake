include(vcpkg_common_functions)

vcpkg_find_acquire_program(PYTHON2)
vcpkg_find_acquire_program(SCONS)
vcpkg_acquire_msys(MSYS_ROOT PACKAGES subversion)
set(SVN ${MSYS_ROOT}/usr/bin/svn.exe)

vcpkg_execute_required_process(
    COMMAND ${SVN} checkout https://svn.apache.org/repos/asf/serf/trunk/ src/serf
    WORKING_DIRECTORY ${CURRENT_BUILDTREES_DIR}
    LOGNAME svn-${TARGET_TRIPLET}-checkout
)

set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/serf)

#TARGET_ARCH=${TRIPLET_SYSTEM_ARCH}
#MSVC_VERSION=14.1
set(TARGET_ARCH ${TRIPLET_SYSTEM_ARCH})
if(${TRIPLET_SYSTEM_ARCH} STREQUAL x64)
    set(TARGET_ARCH x86_64)
endif()

# Clean from any previous builds
vcpkg_execute_required_process(
	SOURCE_PATH ${SOURCE_PATH}
	CURRENT_PACKAGES_DIR ${CURRENT_PACKAGES_DIR}
    COMMAND ${SCONS}
		--clean --remove
    WORKING_DIRECTORY ${SOURCE_PATH}
    LOGNAME build-${TARGET_TRIPLET}.log
)

# This build release
vcpkg_execute_required_process(
	SOURCE_PATH ${SOURCE_PATH}
	CURRENT_PACKAGES_DIR ${CURRENT_PACKAGES_DIR}
    COMMAND ${SCONS}
		PREFIX=${CURRENT_PACKAGES_DIR}
		LIBDIR=${CURRENT_PACKAGES_DIR}/lib
		APR=${CURRENT_INSTALLED_DIR}
		APU=${CURRENT_INSTALLED_DIR}
		EXPAT=${CURRENT_INSTALLED_DIR}
		OPENSSL=${CURRENT_INSTALLED_DIR}
		ZLIB=${CURRENT_INSTALLED_DIR}
#		GSSAPI=${CURRENT_INSTALLED_DIR}
#		BROTLI=${CURRENT_INSTALLED_DIR}
		APR_STATIC=True
		TARGET_ARCH=${TARGET_ARCH}
		MSVC_VERSION=14.1
    WORKING_DIRECTORY ${SOURCE_PATH}
    LOGNAME release-${TARGET_TRIPLET}.log
)

vcpkg_execute_required_process(
	SOURCE_PATH ${SOURCE_PATH}
	CURRENT_PACKAGES_DIR ${CURRENT_PACKAGES_DIR}
    COMMAND ${SCONS}
		install
    WORKING_DIRECTORY ${SOURCE_PATH}
    LOGNAME release-install-${TARGET_TRIPLET}.log
)

# Clean from any previous builds
vcpkg_execute_required_process(
	SOURCE_PATH ${SOURCE_PATH}
	CURRENT_PACKAGES_DIR ${CURRENT_PACKAGES_DIR}
    COMMAND ${SCONS}
		--clean --remove
    WORKING_DIRECTORY ${SOURCE_PATH}
    LOGNAME clean-${TARGET_TRIPLET}.log
)

# This build debug
vcpkg_execute_required_process(
	SOURCE_PATH ${SOURCE_PATH}
	CURRENT_PACKAGES_DIR ${CURRENT_PACKAGES_DIR}
    COMMAND ${SCONS}
		DEBUG=yes
		PREFIX=${CURRENT_PACKAGES_DIR}
		LIBDIR=${CURRENT_PACKAGES_DIR}/debug/lib
		APR=${CURRENT_INSTALLED_DIR}
		APU=${CURRENT_INSTALLED_DIR}
		EXPAT=${CURRENT_INSTALLED_DIR}
		OPENSSL=${CURRENT_INSTALLED_DIR}
		ZLIB=${CURRENT_INSTALLED_DIR}
#		GSSAPI=${CURRENT_INSTALLED_DIR}
#		BROTLI=${CURRENT_INSTALLED_DIR}
		APR_STATIC=True
		TARGET_ARCH=${TARGET_ARCH}
		MSVC_VERSION=14.1
    WORKING_DIRECTORY ${SOURCE_PATH}
    LOGNAME debug-${TARGET_TRIPLET}.log
)

vcpkg_execute_required_process(
    COMMAND ${SCONS}
		install
    WORKING_DIRECTORY ${SOURCE_PATH}
    LOGNAME debug-install-${TARGET_TRIPLET}.log
)

# Handle copyright
# file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/libserf RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME libserf)
