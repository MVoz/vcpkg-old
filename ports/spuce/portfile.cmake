include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/audiofilter/spuce/archive/cbbc0feb19dfaee267084af184f5364bc8c9aeff.zip"
    FILENAME "cbbc0feb19dfaee267084af184f5364bc8c9aeff.zip"
    SHA512 74236451c2a92168c559b6db33348bf4eb847422bee7ee8f90adce364fa754cc39ba9b25416d961198b7e0b3a3d275d68c9244f583c6d74e3afd25d39cc563b6
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
#    DISABLE_PARALLEL_CONFIGURE
    OPTIONS 
        -DBUILD_TESTING:BOOL=OFF
#        -D =OFF
#    OPTIONS_RELEASE
#        -D =ON
#        -D =OFF
#    OPTIONS_DEBUG
#        -D =ON
#        -D =OFF
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled)
vcpkg_copy_pdbs()
configure_file(${SOURCE_PATH}/LICENSE_1_0.txt ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)

###
