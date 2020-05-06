include(vcpkg_common_functions)

# Currently, only support "x86-windows-static"
if(NOT ${TARGET_TRIPLET} MATCHES "x86-windows-static")
        message(FATAL_ERROR "A supported triplet is only x86-windows-static.")
endif()

# Prepair sources
set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/EffekseerRuntime122)
vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/effekseer/Effekseer/releases/download/122/EffekseerRuntime122.zip"
    FILENAME "effekseer-1.22.zip"
    SHA512 a66f56c63d756d212402973feb3010d065060f5e51c7082d0b0804af1a978111d0b42827f39b337f8f569632af312a47d702668c6275aad56c0210f27a34ac67
)
vcpkg_extract_source_archive(${ARCHIVE})

# Copy libraries
file(GLOB INDLUDES ${SOURCE_PATH}/Compiled/include/*.h)
file(INSTALL ${INDLUDES} DESTINATION ${CURRENT_PACKAGES_DIR}/include)
file(GLOB REL_LIBS ${SOURCE_PATH}/Compiled/lib/VS2015/Release/*.lib)
file(INSTALL ${REL_LIBS} DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
file(GLOB DEB_LIBS ${SOURCE_PATH}/Compiled/lib/VS2015/Debug/*.lib)
file(INSTALL ${DEB_LIBS} DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)

# Handle copyright
file(DOWNLOAD https://github.com/effekseer/Effekseer/blob/master/LICENSE ${SOURCE_PATH}/LICENSE)
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/effekseer-12x RENAME copyright)
