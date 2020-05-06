include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/LukasBanana/GaussianLib/archive/8630d4ac14a37f01c71bdf0c1c653e3746aa08da.zip"
    FILENAME "8630d4ac14a37f01c71bdf0c1c653e3746aa08da.zip"
    SHA512 baf9779902b095cb05bd22a3359bdccbb4d6a65ea97f4c8219156ea8a6f2e99af121c0d21adf32dc166f476ceb21ea4b62b8036dab737ecdffc893cb71758bd7
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
#    PATCHES
#      001_gaussianlib_fixes.patch
#      001_gaussianlib_patch.patch
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates
#    GENERATOR "NMake Makefiles" # automatic templates
#    DISABLE_PARALLEL_CONFIGURE
    OPTIONS_DEBUG # automatic templates
      -DDISABLE_INSTALL_HEADERS=ON # automatic templates
      -DINSTALL_HEADERS_TOOLS=OFF
      -DINSTALL_HEADERS=OFF
    OPTIONS_RELEASE 
      -DINSTALL_HEADERS=ON # automatic templates
#      -D =OFF
    OPTIONS 
      -DGaussLib_DISABLE_AUTO_INIT=OFF 
	  -DGaussLib_ASSERT_EXCEPTION=ON 
	  -DGaussLib_ENABLE_INVERSE_OPERATOR=ON 
	  -DGaussLib_ENABLE_SWIZZLE_OPERATOR=ON 
	  -DGaussLib_ROW_VECTORS=ON
	  -DGaussLib_ROW_MAJOR_STORAGE=ON
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE.txt ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
