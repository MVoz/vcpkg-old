# Common Ambient Variables:
#   CURRENT_BUILDTREES_DIR    = ${VCPKG_ROOT_DIR}\buildtrees\${PORT}
#   CURRENT_PACKAGES_DIR      = ${VCPKG_ROOT_DIR}\packages\${PORT}_${TARGET_TRIPLET}
#   CURRENT_PORT_DIR          = ${VCPKG_ROOT_DIR}\ports\${PORT}
#   PORT                      = current port name (zlib, etc)
#   TARGET_TRIPLET            = current triplet (x86-windows, x64-windows-static, etc)
#   VCPKG_CRT_LINKAGE         = C runtime linkage type (static, dynamic)
#   VCPKG_LIBRARY_LINKAGE     = target library linkage type (static, dynamic)
#   VCPKG_ROOT_DIR            = <C:\path\to\current\vcpkg>
#   VCPKG_TARGET_ARCHITECTURE = target architecture (x64, x86, arm)
#

include(vcpkg_common_functions)
set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/Video_Codec_SDK_8.0.14)
vcpkg_download_distfile(ARCHIVE
    URLS "https://pkgs.rpmfusion.org/repo/pkgs/free/nvidia-video-codec-sdk/Video_Codec_SDK_8.0.14.zip/3ced811ec18bc795ab343ca44b11950d/Video_Codec_SDK_8.0.14.zip"
    FILENAME "Video_Codec_SDK_8.0.14.zip"
    SHA512 081af464a1bfb0f37bffcfb6d12ebfaa4b856b076273aace7c573588081c14a7a056906c3f8db69695a62066103754ea6d96f859ee108ee35f6633100b0ddb39
)
vcpkg_extract_source_archive(${ARCHIVE})

file(GLOB INCLUDES ${SOURCE_PATH}/Samples/common/inc/*.h)
file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/include)
file(COPY ${INCLUDES} DESTINATION ${CURRENT_PACKAGES_DIR}/include)
file(INSTALL ${SOURCE_PATH}/Samples/common/src DESTINATION ${CURRENT_PACKAGES_DIR})

vcpkg_apply_patches(
    SOURCE_PATH ${CURRENT_PACKAGES_DIR}/include
    PATCHES
    ${CURRENT_PORT_DIR}/fixed_CUresult_ver.patch
)

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LicenseAgreement.pdf DESTINATION ${CURRENT_PACKAGES_DIR}/share/videocodecsdk RENAME copyright)
