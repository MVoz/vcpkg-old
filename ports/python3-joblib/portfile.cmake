include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://files.pythonhosted.org/packages/2c/7f/c1da4e341d81840c2fa46d583cbc92bb02e5274fe601e9cbc72bcb78b2d7/joblib-0.13.2.tar.gz"
    FILENAME "joblib-0.13.2.tar.gz"
    SHA512 d29c794f6d993bea225af39369228e4950ec970abeb6c82ff69c9db553ce381216258ba96419f7f0d49d0c6ae966a1de9cae8266b14a7416e1aad16e81b1a8a2
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

include(${CURRENT_INSTALLED_DIR}/share/python3-setuptools/python-pip-install.cmake)
python_pip_install(SOURCE_PATH ${SOURCE_PATH})
