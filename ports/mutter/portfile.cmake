include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/GNOME/mutter/archive/5a4bc15d0b047fa8ea3392fcfe24340ccfc44789.zip"
    FILENAME "mutter.zip"
    SHA512 c7106502359d3c1ff81324a4119743205affe57fafdcf8d510aae7297d159ce32801d635e9c61e8b5d00cefd7dab0299d1c79d3511e40a7072cbb17621b4b99a
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

# https://mesonbuild.com/Configuring-a-build-directory.html
vcpkg_configure_meson(
	SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
#	OPTIONS_RELEASE
#	OPTIONS_DEBUG
		--backend=ninja
#		-Dsubproject:option=_build
		-Dclutter_tests=false
		-Dcore_tests=false
		-Dtests=false
		-Dinstalled_tests=false
		-Dsm=false
		-Dlibwacom=false
		-Dudev=false
		-Dopengl=false
		-Degl=false
		-Dglx=false
		-Dwayland=false
		-Dremote_desktop=false
		-Dpango_ft2=false
		-Dstartup_notification=false
		
		
#		-Dcpp_link_args="/LIBPATH:${CURRENT_INSTALLED_DIR}/lib"
#		-Dc_link_args="/LIBPATH:${CURRENT_INSTALLED_DIR}/lib"
#		-Dc_args="/I:${CURRENT_INSTALLED_DIR}/include"
#		-Dcpp_args="/I:${CURRENT_INSTALLED_DIR}/include"
)

vcpkg_install_meson()

vcpkg_copy_pdbs()

# Handle copyright
# file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/mutter RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME mutter)
