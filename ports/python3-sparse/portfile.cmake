include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/pydata/sparse/archive/72ca41ea9702b10770b177cbdce99e8fcea4246b.zip"
    FILENAME "72ca41ea9702b10770b177cbdce99e8fcea4246b.zip"
    SHA512 40942dd9fd18c98a05aca3162e30ecf28eb2906d858586f5ea746dcd65250d33d9fc1f9f9926fe2558390c9aa9855223f1490eafe5f764d8dcc4ad2ab6d1c00f
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

include(${CURRENT_INSTALLED_DIR}/share/python3-setuptools/python-pip-install.cmake)
python_pip_install(SOURCE_PATH ${SOURCE_PATH})
