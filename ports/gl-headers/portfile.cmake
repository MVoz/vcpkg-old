include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://gitlab.freedesktop.org/gstreamer/meson-ports/gl-headers/-/archive/5c8c7c0d3ca1f0b783272dac0b95e09414e49bc8/gl-headers-5c8c7c0d3ca1f0b783272dac0b95e09414e49bc8.tar.gz"
    FILENAME "gl-headers.tar.gz"
    SHA512 d001535e1c1b5bb515ac96c7d15b25ca51460a5af0c858df53b11c7bae87c4a494e4a1b1b9c3c41a5989001db083645dde2054b82acbbeab7f9939308b676f9c
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_configure_meson(
	SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
		--backend=ninja
)

vcpkg_install_meson()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
###
