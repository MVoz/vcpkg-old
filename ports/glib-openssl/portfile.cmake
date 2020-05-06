include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://gitlab.gnome.org/Archive/glib-openssl/-/archive/master/glib-openssl-master.tar.bz2"
    FILENAME "glib-openssl-master.tar.bz2"
    SHA512 7c2e34d3dbccd6c2bd44c674c4ac09f0b555e2d7ee81a38d19fed5b34c6780e21cf8a207503030647d3f4c83f61a76efef92b956b600f6e45841623a1b3fe708
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE} 

)

vcpkg_configure_meson(
	SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
#        -Denable-glx=no
#        -Denable-egl=no
#        -Ddocs=false
		--backend=ninja
		-Dplatforms=windows
#		--buildtype=release
#		--backend=vs2017
#		--backend=vs2015		
#		--vs=2017:universal		

)

vcpkg_install_meson()

vcpkg_copy_pdbs()

# Handle copyright
# file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/glib-openssl RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME glib-openssl)
