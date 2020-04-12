include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://files.pythonhosted.org/packages/48/64/dc7152b7ca88903669c296beddf3a8de839c3900684136514293dc99d432/pystan-2.19.0.0.tar.gz"
    FILENAME "pystan-2.19.0.0.tar.gz"
    SHA512 b4dbfcd8b98d22a1177ebf5d98f9355c7161144bdfddd37316160298e851ced9ec434292192bd053784dda5b0dec0dee72359c3f059b61e65e7223cc9e78e6c1
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

include(${CURRENT_INSTALLED_DIR}/share/python3-setuptools/python-pip-install.cmake)
python_pip_install(SOURCE_PATH ${SOURCE_PATH})
