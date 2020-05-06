include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://files.pythonhosted.org/packages/33/fb/ad98d46773929079657706e6b2b6e366ba6c282bc2397d8f9b0ea8e5614c/fbprophet-0.5.tar.gz"
    FILENAME "fbprophet-0.5.tar.gz"
    SHA512 bd6ba02c4ebf88ab2ec36aeb61f0d75473df62d0164663bb8649f875ecd56a7f686b2e12e840b029bd440c9a7fbea6464519fd195b1586079075ba2b0d4f27e4
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

include(${CURRENT_INSTALLED_DIR}/share/python3-setuptools/python-pip-install.cmake)
python_pip_install(SOURCE_PATH ${SOURCE_PATH})
