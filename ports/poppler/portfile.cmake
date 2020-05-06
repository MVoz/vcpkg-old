include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE

    URLS "https://github.com/freedesktop/poppler/archive/080a79b47c643ccf68d4be1b49ec6062d0b8ba36.zip"
    FILENAME "poppler_cmake.zip"
    SHA512 1fa8bc35a2fc60ef918234f883f539673854d29e62624ce91cc7721bd7c6118874a8282ad7799038deac09c6d622d9b31edc9f8339997897fec8719f557a715a
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
#    DISABLE_PARALLEL_CONFIGURE
    OPTIONS 

        -DBUILD_CPP_TESTS:BOOL=OFF
        -DBUILD_GTK_TESTS:BOOL=OFF
        -DBUILD_QT4_TESTS:BOOL=OFF
        -DBUILD_QT5_TESTS:BOOL=OFF
#        -DECM_DIR:PATH=ECM_DIR-NOTFOUND
#        -DENABLE_CMS:STRING=auto
        -DENABLE_CPP:BOOL=ON
        -DENABLE_LIBCURL:BOOL=ON
        -DENABLE_RELOCATABLE:BOOL=ON
        -DENABLE_SPLASH:BOOL=ON
        -DENABLE_UTILS:BOOL=ON
        -DENABLE_XPDF_HEADERS:BOOL=ON
        -DENABLE_ZLIB:BOOL=ON
        -DENABLE_ZLIB_UNCOMPRESS:BOOL=OFF

#        -DLIB_SUFFIX:STRING=

#        -DQT_QMAKE_EXECUTABLE:FILEPATH=QT_QMAKE_EXECUTABLE-NOTFOUND-NOTFOUND
#        -DQt5Core_DIR:PATH=Qt5Core_DIR-NOTFOUND
#        -DQt5Gui_DIR:PATH=Qt5Gui_DIR-NOTFOUND
#        -DQt5Test_DIR:PATH=Qt5Test_DIR-NOTFOUND
#        -DQt5Widgets_DIR:PATH=Qt5Widgets_DIR-NOTFOUND
#        -DQt5Xml_DIR:PATH=Qt5Xml_DIR-NOTFOUND
        -DSPLASH_CMYK:BOOL=OFF
        -DUSE_FIXEDPOINT:BOOL=OFF
        -DUSE_FLOAT:BOOL=OFF
        -DWITH_Cairo:BOOL=ON
        -DWITH_GLIB:BOOL=ON
        -DWITH_Iconv:BOOL=ON
        -DWITH_JPEG:BOOL=ON
        -DWITH_NSS3:BOOL=OFF
        -DWITH_PNG:BOOL=ON
        -DWITH_Qt4:BOOL=OFF
        -DWITH_TIFF:BOOL=ON
        -DWITH_Qt5:BOOL=ON
		-DENABLE_QT5:BOOL=ON
		-DENABLE_GOBJECT_INTROSPECTION:BOOL=OFF
		-DWITH_GObjectIntrospection:BOOL=OFF
		-DTESTDATADIR=${SOURCE_PATH}/test

)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled)
vcpkg_copy_pdbs()
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)

###
