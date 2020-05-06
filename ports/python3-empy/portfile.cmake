include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "http://www.alcyone.com/software/empy/empy-latest.tar.gz"
    FILENAME "empy-latest.tar.gz"
    SHA512 5de8de26484468d180a2575bfc8302cb3d32004ed4d70768310b7564a9ed1bb880b8c1d862f419588b2b5baa8c3da8bc707eac41f3921e6136cc5bc3f47f1a3d
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

include(${CURRENT_INSTALLED_DIR}/share/python3-setuptools/python-pip-install.cmake)
python_pip_install(SOURCE_PATH ${SOURCE_PATH})