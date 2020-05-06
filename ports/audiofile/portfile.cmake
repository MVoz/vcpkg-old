include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/sideshowb/AudioFile/archive/master.zip"
    FILENAME "AudioFile.zip"
    SHA512 051da49b5a68522f5204b819c83bcbe40a53af284f07993e66fe562fc28e204071649d875bbadfa464071173159e54e3d505248ac68ebc49d74ecde793b59e15
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
#        -D =OFF
#    OPTIONS_RELEASE
#        -D =OFF
    OPTIONS 
        -DBUILD_SHARED_LIBS=ON # automatic templates
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
