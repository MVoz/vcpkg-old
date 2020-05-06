include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/hotdoc/hotdoc/archive/04f9fff329c440b56a79017bdac1baf8e65fd062.zip"
    FILENAME "04f9fff329c440b56a79017bdac1baf8e65fd062.zip"
    SHA512 bd56714cba401c21091a0d0e43244c54141b41f76345855315c94661cb2a5d10643d562d93954500a99c9d0570bf13f3d0f718785e9be91c483ff49ecee4a050
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

include(${CURRENT_INSTALLED_DIR}/share/python3-setuptools/python-pip-install.cmake)
python_pip_install(SOURCE_PATH ${SOURCE_PATH})
