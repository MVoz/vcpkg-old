include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://www.riverbankcomputing.com/static/Downloads/sip/4.19.17/sip-4.19.17.zip"
    FILENAME "sip-4.19.17.zip"
    SHA512 af095148b463bd1700a7ca894224f579c8aae0ed101a9b45b7df81378a0c8251a74e7e6b2f2e304c6898c8ae30522781cbe39138225a1a28b7baf620048cb625
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

include(${CURRENT_INSTALLED_DIR}/share/python3-setuptools/python-pip-install.cmake)
python_pip_install(SOURCE_PATH ${SOURCE_PATH})
