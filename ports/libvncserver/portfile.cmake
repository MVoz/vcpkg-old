include(vcpkg_common_functions)

vcpkg_check_linkage(ONLY_STATIC_LIBRARY) #error LNK2001: unresolved external symbol rfbLog

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/LibVNC/libvncserver/archive/6afa018aa8076d57be17dcd31d3f3aaf39b49123.zip"
    FILENAME "libvncserv.zip"
    SHA512 7f5d4916492bd304d0a5f9e04c4adc66e72a1b1d92c6ae6f76b061615125db6606a4e4fbb55659542262a8900a868c8584d86b3ade5aa7cbc8f2dfede99f39d5
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

#pnmshow.c.obj : error LNK2001: unresolved external symbol rfbLog
#libvncserver/libvncserver/websockets.c
vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
	NO_CHARSET_FLAG # automatic templates
    OPTIONS 
        -DWITH_24BPP=ON
        -DWITH_FFMPEG=OFF #error
        -DWITH_GCRYPT=ON
        -DWITH_GNUTLS=OFF
        -DWITH_IPv6=OFF
        -DWITH_JPEG=ON
        -DWITH_LZO=ON
        -DWITH_OPENSSL=ON
        -DWITH_PNG=ON
        -DWITH_SASL=ON
        -DWITH_SDL=OFF  #client_examples\SDLvncviewer.c(203): error C2036: 'void *': unknown size
        -DWITH_SYSTEMD=OFF
        -DWITH_THREADS=ON
        -DWITH_TIGHTVNC_FILETRANSFER=ON
        -DWITH_WEBSOCKETS=ON
        -DWITH_ZLIB=ON
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/COPYING ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
