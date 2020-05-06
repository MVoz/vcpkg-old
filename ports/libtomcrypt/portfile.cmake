include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/libtom/libtomcrypt/archive/5d87aa21a50544b11215538615dc7818de43b664.zip"
    FILENAME "libtomcrypt.zip"
    SHA512 a5be8d361245e875dc415ab4bce6bc80519c237408dc1cec428cae0a8d9558bb78692ab985163f3dbe29b4186fe32453c687d9a1f3519f797113abf012563a4c
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

# nmake -f makefile.msvc all
#
# nmake /f makefile.msvc "PREFIX=E:/tools/vcpkg/installed/x64-windows" "EXTRALIBS=E:/tools/vcpkg/installed/x64-windows/lib/tommath.lib" CFLAGS="/IE:/tools/vcpkg/installed/x64-windows/include" install
#
# nmake -f makefile.msvc CFLAGS="/DUSE_LTM /DLTM_DESC /Ic:\path\to\libtommath" EXTRALIBS=c:\path\to\libtommath\tommath.lib all

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
