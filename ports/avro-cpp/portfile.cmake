include(vcpkg_common_functions)

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_download_distfile(ARCHIVE
    URLS "http://apache-mirror.rbc.ru/pub/apache/avro/stable/cpp/avro-cpp-1.9.0.tar.gz"
    FILENAME "avro-cpp-1.9.0.tar.gz"
    SHA512 9ce22c3bfae65f781e2d45dd2e6ec429a471bc9ea58291f92abc5f5772e973658446531fcbdd168a013ed3e9b0de9c8ce8757968055949e807c55fd294197666
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
	NO_CHARSET_FLAG # automatic templates

)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
