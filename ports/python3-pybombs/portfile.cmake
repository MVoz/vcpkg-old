include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/gnuradio/pybombs/archive/v2.3.3.tar.gz"
    FILENAME "v2.3.3.tar.gz"
    SHA512 44235d491c0547c567115fdac6e446b99f4fd33309d9e25d033395726d60ac532842e16925e4107ed889fcaa73652b3dea62962d6f118b01cff97f71e02b4c33
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

include(${CURRENT_INSTALLED_DIR}/share/python3-setuptools/python-pip-install.cmake)
python_pip_install(SOURCE_PATH ${SOURCE_PATH})
