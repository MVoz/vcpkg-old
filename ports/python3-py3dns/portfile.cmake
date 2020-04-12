include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://files.pythonhosted.org/packages/b9/46/8ea57e6722fec2384d2de7afee81b892693ae3ed99917756d71dd0027739/py3dns-3.2.0.tar.gz"
    FILENAME "py3dns-3.2.0.tar.gz"
    SHA512 b8b928bff37cd80cf27878e7a1b4dd599b0f8fb372bc4942d59fd65cee7de695796c0dbcdf8cf7757b64eb9aebb1d64d4c7915929b406751cf15299a6060d0d6
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

include(${CURRENT_INSTALLED_DIR}/share/python3-setuptools/python-pip-install.cmake)
python_pip_install(SOURCE_PATH ${SOURCE_PATH})
