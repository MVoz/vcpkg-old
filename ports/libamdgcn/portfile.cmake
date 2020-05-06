include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/HSAFoundation/CLOC/archive/fe5372f02adb9e92812f89026f6a9ac4f462b055.zip"
    FILENAME "fe5372f02adb9e92812f89026f6a9ac4f462b055.zip"
    SHA512 397af13ddafd28574479d94acfb342762e2fa95377cb5910b857e5b1ba5b5b436e420bf3f7e6deb1bd904cb86a42f1412a9adc339ad7dd1cc6a16c2053c343c7
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_find_acquire_program(CLANG)
get_filename_component(LLVM_ROOT "${CLANG}" DIRECTORY)
set(LLVM_DIR "${LLVM_ROOT}/..")
#set(ENV{LLVM_DIR "${LLVM_DIR}")
set(ENV{PATH} "$ENV{PATH};${LLVM_ROOT};${LLVM_DIR}")

set(LLVM_INCLUDE_DIRS "${LLVM_DIR}/include")
set(LLVM_LIBRARY_DIRS "${LLVM_DIR}/lib")
set(LLVM_TOOLS_BINARY_DIR "${LLVM_DIR}/bin")

set(llvm ${LLVM_DIR})

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}/libamdgcn
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
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
