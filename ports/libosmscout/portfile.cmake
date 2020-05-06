include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/Framstag/libosmscout/archive/c4ae09a9d0bed1eae514af21082491130837e151.zip"
    FILENAME "c4ae09a9d0bed1eae514af21082491130837e151.zip"
    SHA512 133664c3196ec539fe2ca9004437052998159d3ac8e87136299d153a1b525c2cba641c27f251f2e5a674b0ca34f563a48d545220635b98dab1d7c9e7759468d0
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

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
    OPTIONS
      -DOSMSCOUT_BUILD_BINDING_CSHARP=OFF
      -DOSMSCOUT_BUILD_BINDING_JAVA=OFF
      -DOSMSCOUT_BUILD_CLIENT_QT=OFF
      -DOSMSCOUT_BUILD_DEMOS=OFF
      -DOSMSCOUT_BUILD_DOC_API=OFF
      -DOSMSCOUT_BUILD_EXTERN_MATLAB=OFF
      -DOSMSCOUT_BUILD_MAP_AGG=OFF
      -DOSMSCOUT_BUILD_MAP_CAIRO=ON
      -DOSMSCOUT_BUILD_MAP_DIRECTX=ON
      -DOSMSCOUT_BUILD_MAP_OPENGL=OFF #glew #error LNK2019: unresolved external symbol __imp_glew***
      -DOSMSCOUT_BUILD_MAP_QT=OFF
      -DOSMSCOUT_BUILD_MAP_SVG=OFF
      -DOSMSCOUT_BUILD_MSVC_MP=ON
      -DOSMSCOUT_BUILD_TESTS=OFF
      -DOSMSCOUT_BUILD_TOOL_DUMPDATA=ON
      -DOSMSCOUT_BUILD_TOOL_IMPORT=ON
      -DOSMSCOUT_BUILD_TOOL_OSMSCOUT2=OFF
      -DOSMSCOUT_BUILD_TOOL_OSMSCOUTOPENGL=OFF
#      -DOSMSCOUT_BUILD_TOOL_STYLEEDITOR=ON
      -DOSMSCOUT_BUILD_WEBPAGE=OFF
#      -DBUILD_IMPORT_TOOL_FOR_DISTRIBUTION=OFF
#      -DBUILD_SHARED_LIBS=ON
      -DBUILD_WITH_OPENMP=ON
      -DPROTOBUF_SRC_ROOT_FOLDER:PATH=${CURRENT_INSTALLED_DIR}/protobuf-3.5
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
