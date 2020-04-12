include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/pypa/pip/archive/19.1.1.tar.gz"
    FILENAME "19.1.1.tar.gz"
    SHA512 91cd07118d2f7a39b0ecc5f26ae18de3778ebdde90a40f5fa8cf543dfc8e006647ee2f0f6574db1e102e421962db0d725b0ce7ac75f2bb9591cf4754604c9b1a
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

include(${CURRENT_INSTALLED_DIR}/share/python3-setuptools/python-pip-install.cmake)
python_pip_install(SOURCE_PATH ${SOURCE_PATH})
