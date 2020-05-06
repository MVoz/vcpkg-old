include(vcpkg_common_functions)

# Currently, only support "x86-windows-static"
if(NOT ${TARGET_TRIPLET} MATCHES "x86-windows-static")
        message(FATAL_ERROR "A supported triplet is only x86-windows-static.")
endif()

# Prepair sources
set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/EffekseerForDXLib_122_316d)
vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/effekseer/Effekseer/releases/download/122/EffekseerForDXLib_122_316d.zip"
    FILENAME "effekseer-for-dxlib-1.22-3.16d.zip"
    SHA512 65cb4403e50d6e40568f343bbb17a7e0396956551c904f499ea130042145f5afcb92ec4ab871eff121290c696e76ad46beaab63583b027835f8352e0f4e6d5d4
)
vcpkg_extract_source_archive(${ARCHIVE})

# Fix for VisualStudio2017
vcpkg_apply_patches(
    SOURCE_PATH ${SOURCE_PATH}
    PATCHES ${CMAKE_CURRENT_LIST_DIR}/make-correspondent-to-vs2017.patch
)

# Copy libraries
file(INSTALL ${SOURCE_PATH}/プロジェクトに追加すべきファイル_VC用/EffekseerForDXLib.h DESTINATION ${CURRENT_PACKAGES_DIR}/include)

file(INSTALL ${SOURCE_PATH}/プロジェクトに追加すべきファイル_VC用/Effekseer_vs2015_x86.lib DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
file(INSTALL ${SOURCE_PATH}/プロジェクトに追加すべきファイル_VC用/EffekseerRendererDX9_vs2015_x86.lib DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
file(INSTALL ${SOURCE_PATH}/プロジェクトに追加すべきファイル_VC用/EffekseerForDXLib_vs2015_x86.lib DESTINATION ${CURRENT_PACKAGES_DIR}/lib)

file(INSTALL ${SOURCE_PATH}/プロジェクトに追加すべきファイル_VC用/Effekseer_vs2015_x86_d.lib DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)
file(INSTALL ${SOURCE_PATH}/プロジェクトに追加すべきファイル_VC用/EffekseerRendererDX9_vs2015_x86_d.lib DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)
file(INSTALL ${SOURCE_PATH}/プロジェクトに追加すべきファイル_VC用/EffekseerForDXLib_vs2015_x86_d.lib DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)

# Handle copyright (EffekseerForDXLibのリポジトリにLICENSEがないので、Effekseerのもので代用)
file(DOWNLOAD https://github.com/effekseer/Effekseer/blob/master/LICENSE ${SOURCE_PATH}/LICENSE)
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/effekseer-for-dxlib-12x RENAME copyright)
