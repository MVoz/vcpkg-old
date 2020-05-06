include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://gitlab.freedesktop.org/seungha.yang/webrtc-audio-processing/-/archive/fix-msvc-build/webrtc-audio-processing-fix-msvc-build.tar.gz"
    FILENAME "webrtc-audio-processing-fix-msvc-build.tar.gz"
    SHA512 cfd87dbfbc162c0b1a8e995ced515f5bbe42cc21aa60a4664a8a1e69e68a42fd06a23a5248b62d280ed8253e06129bc00396bf39375739ec1404a59c0b16d708
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

### https://mesonbuild.com/Configuring-a-build-directory.html
vcpkg_configure_meson(
	SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
		--backend=ninja
)

vcpkg_install_meson()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/COPYING ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
