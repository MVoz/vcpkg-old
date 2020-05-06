
#vcpkg_check_linkage(ONLY_STATIC_LIBRARY) ## = ## VCPKG_LIBRARY_LINKAGE=static ## = ## BUILD_STATIC_LIBS=ON
include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/zeroc-ice/mcpp/archive/65b088cc7802d0fd46838f5b94fd319d71d56dcd.zip"
    FILENAME "65b088cc7802d0fd46838f5b94fd319d71d56dcd.zip"
    SHA512 3e2e92181ac910e0951da0529a1f0c847903aac6ab29972e9b27a947549b59fdbd062c07d5359ae871f9be06b2d4f54a42f7549a669fc91e91d60a49df684be2
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_install_msbuild(
    SOURCE_PATH ${SOURCE_PATH}
    PROJECT_SUBPATH "msbuild/mcpp.vcxproj"
    SKIP_CLEAN
    LICENSE_SUBPATH LICENSE
    USE_VCPKG_INTEGRATION
)

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
###
