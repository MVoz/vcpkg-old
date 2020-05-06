include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/GNOME/mm-common/archive/1da8c1cef889977fd128a80605fe1b94798dab4b.zip"
    FILENAME "1da8c1cef889977fd128a80605fe1b94798dab4b.zip"
    SHA512 6f4cf2022e062d17e958b04ed7d8c0e10ede470b16007ea87f904651c07b63cda3aa75553d84f9f3fd182cca4c450dcd60c28fc9e90a22a6b0bce80654e7de42
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_acquire_msys(MSYS_ROOT)
find_program(GIT NAMES git git.cmd)

get_filename_component(GIT_EXE_PATH ${GIT} DIRECTORY)
set(SH_EXE_PATH "${GIT_EXE_PATH}/../usr/bin")

#set(BASH ${SH_EXE_PATH}/bash.exe)
set(BASH ${MSYS_ROOT}/usr/bin/bash.exe)
#set(SH ${SH_EXE_PATH}/sh.exe)

# Insert msys into the path between the compiler toolset and windows system32. This prevents masking of "link.exe" but DOES mask "find.exe".
string(REPLACE ";$ENV{SystemRoot}\\system32;" ";${MSYS_ROOT}/usr/bin;${SH_EXE_PATH};$ENV{SystemRoot}\\system32;" NEWPATH "$ENV{PATH}")
set(ENV{PATH} "${NEWPATH}")

### https://mesonbuild.com/Configuring-a-build-directory.html
vcpkg_configure_meson(
    SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
		--backend=ninja
		-Duse-network=true
)

vcpkg_install_meson()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
