include(vcpkg_common_functions)

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/franko/fox-1.6/archive/c9731f34120175906281e76c5d913a764c4027a2.zip"
    FILENAME "fox-1.6.zip"
    SHA512 aed19ee7badfad3c292efe0e1f6a2c54ce7be6865764cacde8b96554f8f08efe1264d03cb53838f9052a84f9336e155521654a1fbda6cd6214a743611f3f46cd
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

### https://mesonbuild.com/Configuring-a-build-directory.html
vcpkg_configure_meson(
    SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
      --backend=ninja
	  -Dopengl=true
	  -Djpeg=true
	  -Dpng=true
	  -Dzlib=true
	  -Dxft=true
	  -Dapps=false
)

vcpkg_install_meson()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
