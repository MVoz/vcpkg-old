include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://files.pythonhosted.org/packages/aa/29/dcea65f86356bfa032b32cc326db7d84c272c5c8fc5a82f485c247592a75/pykdtree-1.3.1.tar.gz"
    FILENAME "pykdtree-1.3.1.tar.gz"
    SHA512 9ad67b198421d19323cdfb401f4f9e40121e17d0d060c9752a2cf363669a5a209394f6a3d6bf18014db643dc3584f5acf8d87ccb8f52c1eb73815ae37de21f21
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

include(${CURRENT_INSTALLED_DIR}/share/python3-setuptools/python-pip-install.cmake)
python_pip_install(SOURCE_PATH ${SOURCE_PATH})
