include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/sphinx-doc/sphinx/archive/f63abac2cad2664a8af816017f0f997bae510d14.zip"
    FILENAME "f63abac2cad2664a8af816017f0f997bae510d14.zip"
    SHA512 a7f60ecd87d56410ffde7133b1603bb2b129e92f079b8d721a53d5dbfbe9416915565c868d023dcb398127404da762a1361c1047d410929828865075043e80ee
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

include(${CURRENT_INSTALLED_DIR}/share/python3-setuptools/python-pip-install.cmake)
python_pip_install(SOURCE_PATH ${SOURCE_PATH})
