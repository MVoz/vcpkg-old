include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/mwgoldsmith/mfx/archive/e8598289785899a34359a492577014c1fa5b6077.zip"
    FILENAME "mfx.zip"
    SHA512 2fa11433295df0aa1a16d05b68761fe0083e995721664add338332c6e085022b0082586fd0d8102fc92cc1d2284d0e3f9eb7eb6c32b867f46de7fdf7d48455a2
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    PATCHES
      001_libmfx_patch.patch
)

vcpkg_install_msbuild(
    SOURCE_PATH ${SOURCE_PATH}
    PROJECT_SUBPATH "projects/vs14/mfx.vcxproj"
    SKIP_CLEAN
    LICENSE_SUBPATH COPYING
    USE_VCPKG_INTEGRATION
)

set(PREBUILT ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel)
file(COPY ${PREBUILT}/msvc/include/mfx DESTINATION ${CURRENT_PACKAGES_DIR}/include)

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
