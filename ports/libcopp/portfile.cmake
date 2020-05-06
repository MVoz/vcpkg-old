include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/owt5008137/libcopp/archive/dfec57b5f5db2f213fc8dbc1a310212bfd03706f.zip"
    FILENAME "dfec57b5f5db2f213fc8dbc1a310212bfd03706f.zip"
    SHA512 834198e69cae9970e84984e77d54c5ce8e426bbe1f7b801b7514bfbd2a4d162e92c75c42f7ae6e22bc8cb5254954f09a803c264d4d14984b669d2a13a0d81e5f
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_find_acquire_program(PYTHON3)
vcpkg_find_acquire_program(NASM)
get_filename_component(NASM_DIR "${NASM}" DIRECTORY)
get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
set(ENV{PATH} "$ENV{PATH};${PYTHON3_DIR};${NASM_DIR}")

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates

    OPTIONS 
      -DBOOST_ROOT=${CURRENT_INSTALLED_DIR}
      -DCMAKE_POSITION_INDEPENDENT_CODE=ON
      -DCOMPILER_OPTION_MSVC_ZC_CPP=ON
      -DGTEST_ROOT=${CURRENT_INSTALLED_DIR}
      -DLIBCOPP_ENABLE_SEGMENTED_STACKS=OFF #[default=NO] Enable split stack supported context.(it's only availabe in linux and gcc 4.7.0 or upper)
      -DLIBCOPP_ENABLE_VALGRIND=OFF
      -DLIBCOPP_TEST_ENABLE_BOOST_UNIT_TEST=OFF
      -DLIBCOTASK_ENABLE=OFF #[default=YES] Enable build libcotask.
      -DLOCK_DISABLE_MT=ON
      -DPROJECT_DISABLE_MT=ON #[default=NO] Disable multi-thread support.
      -DPROJECT_ENABLE_SAMPLE=OFF
      -DPROJECT_ENABLE_UNITTEST=OFF
      -DLIBCOPP_FCONTEXT_USE_TSX=OFF #|NO 	[default=NO] Enable Intel Transactional Synchronisation Extensions (TSX).
	  -DLIBCOPP_FCONTEXT_ABI=MS
	  -DLIBCOPP_FCONTEXT_BIN_FORMATION=PE
	  -DLIBCOPP_FCONTEXT_AS_TOOL=MASM
	  -DLIBCOPP_FCONTEXT_AS_ACTION=""
	  -DLIBCOPP_FCONTEXT_OS_PLATFORM=x86_64
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
