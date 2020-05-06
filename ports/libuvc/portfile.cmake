include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/pupil-labs/libuvc/archive/b394ccc6bac7a26bcf3391c3a1fbf071da789a3b.zip"
    FILENAME "libuvc.zip"
    SHA512 44c6d4546455c7a5d56a3adcbd4aa332f219eea7186830c1e9ab1a8beca03d44f93a5936ac01bf019bd06b7ca4c432476b32a991855b5580e1dd6ab969bb7335
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
#    DISABLE_PARALLEL_CONFIGURE
    OPTIONS_DEBUG # automatic templates
        -DDISABLE_INSTALL_HEADERS=ON # automatic templates
		-DLIBUSB_LIBRARIES=${CURRENT_INSTALLED_DIR}/debug/lib/libusb-1.0.lib
#        -D =OFF
#    OPTIONS_RELEASE
#        -D =OFF
    OPTIONS 
        -DBUILD_SHARED_LIBS=ON # automatic templates
		-DBUILD_TEST=OFF 
		-DBUILD_EXAMPLE=OFF
		-DCMAKE_BUILD_TARGET=Shared
		-DLIBUSB_LIBRARIES=${CURRENT_INSTALLED_DIR}/lib/libusb-1.0.lib
		-DLIBUSB_INCLUDE_DIR=${CURRENT_INSTALLED_DIR}/include/libusb-1.0
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE.txt ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
