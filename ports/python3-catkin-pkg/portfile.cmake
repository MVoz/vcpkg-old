include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://files.pythonhosted.org/packages/5d/ca/b0bcd8b6443fae5735e0f1a7a9955650311eee54742aaba97f0e92d6e676/catkin_pkg-0.4.12.tar.gz"
    FILENAME "catkin_pkg-0.4.12.tar.gz"
    SHA512 14ce7d3272209d16bd1b6bce20fcb96b2b1751abb5b1d6d516f2df3a8164b95de8622e20be5edbae8c6e7e206b635853c8e13a3e4f24d5ab602cac2e88f46ecd
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

include(${CURRENT_INSTALLED_DIR}/share/python3-setuptools/python-pip-install.cmake)
python_pip_install(SOURCE_PATH ${SOURCE_PATH})