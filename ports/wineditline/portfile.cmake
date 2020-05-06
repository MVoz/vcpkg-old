include(vcpkg_common_functions)

vcpkg_acquire_msys(MSYS_ROOT PACKAGES subversion)

set(SVN ${MSYS_ROOT}/usr/bin/svn.exe)

vcpkg_execute_required_process(
    COMMAND ${SVN} checkout https://svn.code.sf.net/p/mingweditline/code/mingweditline/trunk src/wineditline
    WORKING_DIRECTORY ${CURRENT_BUILDTREES_DIR}
    LOGNAME svn-${TARGET_TRIPLET}-checkout
)

set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/wineditline)
set(CURRENT_PACKAGES_DIR ${CURRENT_PACKAGES_DIR}/${PORT}_${TARGET_TRIPLET})

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
	CURRENT_PACKAGES_DIR ${CURRENT_PACKAGES_DIR}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    # OPTIONS -DUSE_THIS_IN_ALL_BUILDS=1 -DUSE_THIS_TOO=2
    # OPTIONS_RELEASE -DOPTIMIZE=1
    # OPTIONS_DEBUG -DDEBUGGABLE=1
)

#vcpkg_build_cmake()
vcpkg_install_cmake()

# Handle copyright
file(INSTALL ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/wineditline RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME wineditline)
set(VCPKG_POLICY_EMPTY_PACKAGE enabled)