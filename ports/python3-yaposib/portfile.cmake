include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/coin-or/yaposib/archive/ef309b1a6edfe0952e0ff156a0295537b97d64a0.zip"
    FILENAME "yaposib.zip"
    SHA512 602cd2168cca16150f331b772dd6981f8262affb779d53fc3b3e9f61912e7b0114dacab0aea63097f7f6fe9af2095250b4ce2255a3fc643b98369d69be67d5c4
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

include(${CURRENT_INSTALLED_DIR}/share/python3-setuptools/python-pip-install.cmake)
python_pip_install(SOURCE_PATH ${SOURCE_PATH})
