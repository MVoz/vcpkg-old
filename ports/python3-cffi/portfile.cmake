include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://files.pythonhosted.org/packages/93/1a/ab8c62b5838722f29f3daffcc8d4bd61844aa9b5f437341cc890ceee483b/cffi-1.12.3.tar.gz"
    FILENAME "cffi-1.12.3.tar.gz"
    SHA512 9070f5cfe543c9261a79f995548899c3e7539ee20f562ba91a4a909887745bd28448b0e38241031d6b2ab87286fd0ec91768b8bf6577716427612d41b0ed3b93
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

include(${CURRENT_INSTALLED_DIR}/share/python3-setuptools/python-pip-install.cmake)
python_pip_install(SOURCE_PATH ${SOURCE_PATH})

