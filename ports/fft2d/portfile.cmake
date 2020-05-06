include(vcpkg_common_functions)

#http://www.kurims.kyoto-u.ac.jp/~ooura/fft-j.html
#http://www.kurims.kyoto-u.ac.jp/~ooura/fft.zip
vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/biotrump/OouraFFT/archive/c6fd2dd6d21397baa6653139d31d84540d5449a2.zip"
    FILENAME "c6fd2dd6d21397baa6653139d31d84540d5449a2.zip"
    SHA512 0e3040077e16c37c41fb8e9dd72336b2d472a93ca201d5efe6444d8945a3ae86e75e449510034987331bc9055237eabc58f0a79dd4ba983ae6269b81ed258840
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH})

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates
#    GENERATOR "NMake Makefiles" # automatic templates
#    DISABLE_PARALLEL_CONFIGURE
    OPTIONS_DEBUG # automatic templates
      -DDISABLE_INSTALL_HEADERS=ON # automatic templates
      -DINSTALL_HEADERS_TOOLS=OFF
      -DINSTALL_HEADERS=OFF
    OPTIONS_RELEASE 
      -DINSTALL_HEADERS=ON # automatic templates
#      -D =OFF
#    OPTIONS 
#      -D =OFF # automatic templates
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/readme.txt ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
