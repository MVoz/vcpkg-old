include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/GNOME/libdazzle/archive/b02bcf987a277d106f30b0e72525db43a75d6b9e.zip"
    FILENAME "b02bcf987a277d106f30b0e72525db43a75d6b9e.zip"
    SHA512 506156f3a2d83130294edb4c224b5e6e6f352932c511bb2f9a83de40af498d3681dc87e700ee1ce433901c24fe9ae874264f25dba01692661fa2628568505060
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
		-Denable_tests=false
#		-Dcpp_link_args="/LIBPATH:${CURRENT_INSTALLED_DIR}/lib"
#		-Dc_link_args="/LIBPATH:${CURRENT_INSTALLED_DIR}/lib"
#		-Dc_args="/I:${CURRENT_INSTALLED_DIR}/include"
#		-Dcpp_args="/I:${CURRENT_INSTALLED_DIR}/include"
)

vcpkg_install_meson()

vcpkg_copy_pdbs()

# Handle copyright
# file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/libdazzle RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME libdazzle)
