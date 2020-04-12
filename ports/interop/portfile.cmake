include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/Illumina/interop/archive/a55b40bde4b764e3652758f6cdf72aef5f473370.zip"
    FILENAME "interop.zip"
    SHA512 b78218d7b06651030ab63d3ef4c8b3208f1a08d1118bd16c45a419ef72548cfb891bc97e297b46f6051ca227a5d9b28285e5340288075dcb520924044c490317
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_find_acquire_program(PYTHON3)
vcpkg_find_acquire_program(SWIG)
get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
get_filename_component(SWIG_DIR "${SWIG}" DIRECTORY)
set(ENV{PATH} "$ENV{PATH};${PYTHON3_DIR};${SWIG_DIR}")

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates

    OPTIONS 
#      -DCSHARP_PLATFORM:STRING=x64
#      -DCSHARP_TARGET_FRAMEWORK:STRING=netcoreapp2.0
#      -DCSHARP_TARGET_FRAMEWORK_VERSION:STRING=2.0
#      -DDEPENDENCY_URL:STRING=
      -DDISABLE_PACKAGE_SUBDIR=ON
#      -DDOTNET_ROOT:PATH=
      -DENABLE_APPS=OFF
      -DENABLE_BACKWARDS_COMPATIBILITY=OFF
#      -DENABLE_CSHARP=ON
#      -DENABLE_DEPENDENCY_MANAGER=ON
      -DENABLE_DEPENDENCY_MANAGER_WINDOWS_ONLY=ON
      -DENABLE_DOCS=OFF
      -DENABLE_EXAMPLES=OFF
      -DENABLE_PORTABLE=OFF
      -DENABLE_PYTHON=ON
      -DENABLE_PYTHON_DYNAMIC_LOAD=ON
      -DENABLE_STATIC=ON
      -DENABLE_SWIG=ON
      -DENABLE_TEST=OFF
#      -DFORCE_SHARED_CRT=ON
      -DFORCE_X86=OFF
#      -DMSBUILD_TOOLSET:STRING=12.0
#      -DNUGET_EXE:FILEPATH=E:/tools/vcpkg/installed/x64-windows/bin/nuget.exe
#      -DSKIP_PACKAGE_ALL_WHEEL=OFF
)

vcpkg_install_cmake()

file(RENAME ${CURRENT_PACKAGES_DIR}/lib64 ${CURRENT_PACKAGES_DIR}/lib)
file(RENAME ${CURRENT_PACKAGES_DIR}/debug/lib64 ${CURRENT_PACKAGES_DIR}/debug/lib)

file(REMOVE 
  ${CURRENT_PACKAGES_DIR}/README.md
  ${CURRENT_PACKAGES_DIR}/changes.md
  ${CURRENT_PACKAGES_DIR}/debug/changes.md
  ${CURRENT_PACKAGES_DIR}/debug/README.md
)

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
