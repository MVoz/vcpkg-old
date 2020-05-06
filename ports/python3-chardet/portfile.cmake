include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/Joungkyun/python-chardet/archive/8b37ce711b98d6690edeb71c58692c2bfc1de97c.zip"
    FILENAME "8b37ce711b98d6690edeb71c58692c2bfc1de97c.zip"
    SHA512 a0307648fb9f00a71081b7d7d28f4a079740e0a8a31796a977886ebbd22e681cb41cf4be9a3e9741785d3fed4e4a3764881163e8759bc94205a101e5c602f061
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

include(${CURRENT_INSTALLED_DIR}/share/python3-setuptools/python-pip-install.cmake)
python_pip_install(SOURCE_PATH ${SOURCE_PATH})
