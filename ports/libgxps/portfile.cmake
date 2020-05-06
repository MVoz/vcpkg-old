include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://gitlab.gnome.org/GNOME/libgxps/-/archive/master/libgxps-master.tar.gz"
    FILENAME "libgxps-master.tar.gz"
    SHA512 3790fbfbf40c6d4b078ecfb0b6fb551117a894ed3c51ae4c43f071073641174ca368e013a22865fb4955e488fa32b9eafdd8a9b4ff72388ac94c7f4df49cb4b2
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE} 

    # PATCHES
    #   001_port_fixes.patch
    #   002_more_port_fixes.patch
)

# fake pkg-config
configure_file(${CURRENT_PORT_DIR}/pkg-config.bat ${CURRENT_BUILDTREES_DIR}/pkg-config.bat @ONLY CRLF)
set(ENV{PKG_CONFIG} ${CURRENT_BUILDTREES_DIR}/pkg-config.bat)

# https://mesonbuild.com/Configuring-a-build-directory.html
vcpkg_configure_meson(
	SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
#	OPTIONS_RELEASE
#	OPTIONS_DEBUG
		--backend=ninja
#		-Dsubproject:option=_build
#		-Dcpp_link_args="/LIBPATH:${CURRENT_INSTALLED_DIR}/lib"
#		-Dc_link_args="/LIBPATH:${CURRENT_INSTALLED_DIR}/lib"
#		-Dc_args="/I:${CURRENT_INSTALLED_DIR}/include"
#		-Dcpp_args="/I:${CURRENT_INSTALLED_DIR}/include"
#		--buildtype=release
#		--backend=vs ## bosh
#		--backend=vs2017
#		--backend=vs2015		
)

vcpkg_install_meson()

# Handle copyright
# file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/libgxps RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME libgxps)
