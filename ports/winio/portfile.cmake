include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/starofrainnight/winio/archive/3.0.zip"
    FILENAME "3.0.zip"
    SHA512 969536d141e876ec97ee891ade34d9b7982d67cc869ba1f104e47420f7f35c997f62053a56ab08832abe70c73850af802e5d9f00e36f9f8735aac2b4d177e929
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

file(COPY ${CURRENT_PORT_DIR}/WinIo.vcxproj ${CURRENT_PORT_DIR}/WinIo.vcxproj.filters DESTINATION ${SOURCE_PATH}/Source/Dll)

vcpkg_install_msbuild(
    SOURCE_PATH ${SOURCE_PATH}
    PROJECT_SUBPATH "Source/Dll/WinIo.vcxproj"
    SKIP_CLEAN
    LICENSE_SUBPATH LICENSE
    USE_VCPKG_INTEGRATION
)

#file(COPY ${SOURCE_PATH}/include/winio.h DESTINATION ${CURRENT_PACKAGES_DIR}/include) ???
##include "../Drv/winio_nt.h" ???

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
###