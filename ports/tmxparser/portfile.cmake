include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO sainteos/tmxparser
    REF v2.1.0
    HEAD_REF master
    SHA512 011cce3bb98057f8e2a0a82863fedb7c4b9e41324d5cfa6daade4d000c3f6c8c157da7b153f7f2564ecdefe8019fc8446c9b1b8a675be04329b04a0891ee1c27
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
      -DBUILD_SHARED_LIBS:BOOL=ON
)

vcpkg_install_cmake()
vcpkg_copy_pdbs()

file(REMOVE_RECURSE
    ${CURRENT_PACKAGES_DIR}/debug/include
    ${CURRENT_PACKAGES_DIR}/debug/share
)

if(VCPKG_LIBRARY_LINKAGE STREQUAL "static")
    file(GLOB LIBS ${CURRENT_PACKAGES_DIR}/lib/*.so* ${CURRENT_PACKAGES_DIR}/debug/lib/*.so*)
    if(LIBS)
        file(REMOVE ${LIBS})
    endif()
else()
    file(GLOB LIBS ${CURRENT_PACKAGES_DIR}/lib/*.a ${CURRENT_PACKAGES_DIR}/debug/lib/*.a)
    if(LIBS)
        file(REMOVE ${LIBS})
    endif()
endif()

# Handle copyright
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/tmxparser/copyright COPYONLY)
