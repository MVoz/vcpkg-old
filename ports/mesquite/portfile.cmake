include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/jppelteret/mesquite/archive/2a2ce64e55828a07bf6ee3ee9c75ef8ef7e4ac48.zip"
    FILENAME "mesquite-1.zip"
    SHA512 c4a39d93b3bf5641c14dfeca8581c35aae6e1e6a9b89a23457f3d042a89811d654baf1efc1209c94854f7dbed388ce8abab8ea5c7c7b75df0a381b8ec90de149
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates
    OPTIONS 
#      -DEXECUTABLE_OUTPUT_PATH:PATH=
#      -DIGEOM_DEFS:FILEPATH=IGEOM_DEFS-NOTFOUND #CGM (or other iGeom interface)
#      -DIMESH_DEFS:FILEPATH=IMESH_DEFS-NOTFOUND #MOAB (or other iMesh interface)
#      -DIREL_DEFS:FILEPATH=IREL_DEFS-NOTFOUND #Lasso (or other iRel interface)
#      -DLIBRARY_OUTPUT_PATH:PATH=
#      -DMesquite_DISABLE_DEBUG_ASSERTS:BOOL=ON
#      -DMesquite_ENABLE_SHARED:BOOL=ON
      -DMesquite_ENABLE_TESTS:BOOL=OFF
      -DMesquite_ENABLE_TRAP_FPE:BOOL=ON
#      -DMesquite_MSQ_FUNCTION:STRING=
#      -DMesquite_NAMESPACE:STRING=Mesquite2
      -DMesquite_USE_FUNCTION_TIMERS:BOOL=ON
)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/lgpl.txt ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
