include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/nu774/qaac/archive/29a5396380d91ff482a474fa9024747da383fb67.zip"
    FILENAME "qaac.zip"
    SHA512 bd2dc71b4a517d06686089c2f194b2f8e636adf1f982172ac97d09e90aece62b42348e962ba793fad12d18fb742e385edc35360b3f61257d3fafb8c2659593a9
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_install_msbuild(
    SOURCE_PATH ${SOURCE_PATH}
    PROJECT_SUBPATH "vcproject/qaac.sln"
#    /verbosity:diag
#    /nowarn:msb4011 ## dotnet
#    OPTIONS BuildInParallel=true
#    TARGET qaac
    SKIP_CLEAN
    LICENSE_SUBPATH COPYING
    USE_VCPKG_INTEGRATION
)

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
###
