include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/CheetahTemplate3/cheetah3/archive/3.2.3.tar.gz"
    FILENAME "Cheetah-3.2.3.tar.gz"
    SHA512 553eca6b3e5dbbce5d575ee4e63bbc1985afe4574115e0ca439f08d9fc827737a16d4649cdcb2002ad9de15224c2615313aadf612965f006bf895ab002810730
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

include(${CURRENT_INSTALLED_DIR}/share/python3-setuptools/python-pip-install.cmake)
python_pip_install(SOURCE_PATH ${SOURCE_PATH})