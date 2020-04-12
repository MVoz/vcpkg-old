include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://files.pythonhosted.org/packages/fa/9a/0674cb1725196568bdbca98304f2efb17368b57af1a4bb3fc772c026f474/pyelftools-0.25.tar.gz"
    FILENAME "pyelftools-0.25.tar.gz"
    SHA512 06ead53ada32676161193d7e5cdb3b9e4c1910dcb34f77a544f53445651f8118b582716bf8c5cc54efb21b1ddbbcdb4b41c533350af3c41553d103c7fc74702f
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

include(${CURRENT_INSTALLED_DIR}/share/python3-setuptools/python-pip-install.cmake)
python_pip_install(SOURCE_PATH ${SOURCE_PATH})
