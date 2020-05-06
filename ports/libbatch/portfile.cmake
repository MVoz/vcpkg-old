include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "http://files.salome-platform.org/Salome/other/libBatch-2.4.1.tar.gz"
    FILENAME "libBatch-2.4.1.tar.gz"
    SHA512 56b73aa40953d4d294ba6caf9bf6967373b77c99604567380c936816c6de5a7dbc02327aa510248e047af62b36dc3aa0603477211deb119ccac922ce25a62304
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_find_acquire_program(PYTHON3)
vcpkg_find_acquire_program(SWIG)
get_filename_component(SWIG_DIR "${SWIG}" DIRECTORY)
get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
set(ENV{PATH} "$ENV{PATH};${PYTHON3_DIR};${SWIG_DIR}")

#-- LIBBATCH_RM_COMMAND found : using 'del' (Windows default)
#-- LIBBATCH_SH_COMMAND found : C:/Windows/System32/cmd.exe
#-- LIBBATCH_CP_COMMAND found : using 'copy' (Windows default)
#-- LIBBATCH_MKDIR_COMMAND found : using 'mkdir' (Windows default)
#-- LIBBATCH_RSH_COMMAND not found, local submission might not work properly
#-- LIBBATCH_RCP_COMMAND not found, local submission might not work properly
#-- LIBBATCH_SSH_COMMAND not found, local submission might not work properly
#-- LIBBATCH_SCP_COMMAND not found, local submission might not work properly
#-- LIBBATCH_RSYNC_COMMAND not found, local submission might not work properly

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates

    OPTIONS 
      -DSWIG_ROOT_DIR=${SWIG_DIR}
      -DLIBBATCH_BUILD_TESTSFALSE
      -DLIBBATCH_LOCAL_SUBMISSIONTRUE
      -DLIBBATCH_PYTHON_WRAPPINGTRUE
#      -DPTHREAD_ROOT_DIR:PATH=
      -DPYTHON_ROOT_DIR=${PYTHON3_DIR}
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/COPYING ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
