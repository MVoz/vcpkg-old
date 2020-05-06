include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/scipy/scipy/archive/v1.2.2.tar.gz"
    FILENAME "v1.2.2.tar.gz"
    SHA512 0d51d2d341e0b6409e89c01571a41922183f9aa5a6c83a1c78b1ce4bb2d21bb3fd98f8082b467f482677779d248a98fe4ab5c83deb02f013f800d20299d14bbe
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

include(${CURRENT_INSTALLED_DIR}/share/python3-setuptools/python-pip-install.cmake)
python_pip_install(SOURCE_PATH ${SOURCE_PATH})
