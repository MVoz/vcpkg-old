include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/ddemidov/vexcl/archive/4a99b23fe6d9e6a393fa6815cb72f181e8567c8f.zip"
    FILENAME "vexcl.zip"
    SHA512 902d1bedbf3d0fb2d58b59d0aa3bd8d3e28d3723bf78358b1feb14d6e1ccd5af6f42d75e2de709d70a40628ad5cb3a7b5d5ca0e08e2d537373b640f76f9f4aa7
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates

#    OPTIONS 
#      -DVEXCL_AMD_SI_WORKAROUND:BOOL=OFF
#      -DVEXCL_BACKEND:STRING=OpenCL
#      -DVEXCL_BUILD_EXAMPLES:BOOL=OFF
#      -DVEXCL_BUILD_TESTS:BOOL=OFF
#      -DVEXCL_CACHE_KERNELS:BOOL=ON
#      -DVEXCL_CHECK_SIZES:STRING=0
#      -DVEXCL_CLOGS:BOOL=OFF
#      -DVEXCL_HAVE_BOOST_COMPUTE:BOOL=OFF
#      -DVEXCL_INSTALL_CL_HPP:BOOL=OFF
#      -DVEXCL_JIT_COMPILER_FLAGS:STRING=
#      -DVEXCL_SHOW_COPIES:BOOL=OFF
#      -DVEXCL_SHOW_KERNELS:BOOL=OFF
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE.md ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
