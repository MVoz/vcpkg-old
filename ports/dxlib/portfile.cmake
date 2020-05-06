# Specify version
set(MAJOR_VERSION 3)
set(MINOR_VERSION 19)
set(VERSION ${MAJOR_VERSION}.${MINOR_VERSION})

include(vcpkg_common_functions)

# Currently, only support "x[x86|64]-windows-static"
if((NOT ${TARGET_TRIPLET} MATCHES "x86-windows-static") AND (NOT ${TARGET_TRIPLET} MATCHES "x64-windows-static"))
        message(FATAL_ERROR "A supported triplet is only x86-windows-static and x64-windows-static.")
endif()

# Prepair sources
set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/DxLib_VC)
vcpkg_download_distfile(ARCHIVE
    URLS "http://dxlib.o.oo7.jp/DxLib/DxLib_VC${MAJOR_VERSION}_${MINOR_VERSION}.exe"
    FILENAME "dxlib-${VERSION}.exe"
    SHA512 36287fa941ffe15777ca4f8547aa933a0597051612739f07f8ffdf05a6c9b7c391d55b06774482596618f738b9e1e77eb132f8b0397000e165c64e806fd2b048
)
file(COPY ${ARCHIVE} DESTINATION ${CURRENT_BUILDTREES_DIR}/src)
file(REMOVE_RECURSE ${SOURCE_PATH})
vcpkg_execute_required_process(
    COMMAND ./dxlib-${VERSION}.exe
    WORKING_DIRECTORY ${CURRENT_BUILDTREES_DIR}/src
    LOGNAME extract-${TARGET_TRIPLET}
)

# Copy libraries (to avoid LNK2005, except wide character library whose name includes "W")
file(GLOB INDLUDES ${SOURCE_PATH}/プロジェクトに追加すべきファイル_VC用/*.h)
file(INSTALL ${INDLUDES} DESTINATION ${CURRENT_PACKAGES_DIR}/include)
file(GLOB REL_LIBS ${SOURCE_PATH}/プロジェクトに追加すべきファイル_VC用/*[0123456789abcdefghijklmnopqrstuvxyz]_vs2015_${TRIPLET_SYSTEM_ARCH}.lib)
file(INSTALL ${REL_LIBS} DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
file(GLOB DEB_LIBS ${SOURCE_PATH}/プロジェクトに追加すべきファイル_VC用/*[0123456789abcdefghijklmnopqrstuvxyz]_vs2015_${TRIPLET_SYSTEM_ARCH}_d.lib)
file(INSTALL ${DEB_LIBS} DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)

# Handle copyright
file(INSTALL ${SOURCE_PATH}/DxLib.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/dxlib RENAME copyright)
