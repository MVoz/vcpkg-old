include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://files.pythonhosted.org/packages/c1/e9/35d9c0d5c6467a05f3528f21a3d56f0063fe8cf5658080dc144e3b0ac154/elasticsearch-7.0.2.tar.gz"
    FILENAME "elasticsearch-7.0.2.tar.gz"
    SHA512 42790dcbff37e93c004aa055d6fa7687d3127a18ec26a7847a22f1af4e5bc091847a55da11d7789aba1fe66e9d2e39abe4d3f139d9ecf3f774fbc31cca285547
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

include(${CURRENT_INSTALLED_DIR}/share/python3-setuptools/python-pip-install.cmake)
python_pip_install(SOURCE_PATH ${SOURCE_PATH})
