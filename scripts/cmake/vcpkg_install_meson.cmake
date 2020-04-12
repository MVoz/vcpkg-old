function(vcpkg_install_meson)
## https://mesonbuild.com/Installing.html#custom-install-behavior
#    vcpkg_find_acquire_program(NINJA)
    vcpkg_find_acquire_program(MESON)

    unset(ENV{DESTDIR}) # installation directory was already specified with '--prefix' option

    message(STATUS "Package ${TARGET_TRIPLET}-rel")
    vcpkg_execute_required_process(
#        COMMAND ${NINJA} install -v
        COMMAND ${MESON} install
        WORKING_DIRECTORY ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel
        LOGNAME package-${TARGET_TRIPLET}-rel
    )

    message(STATUS "Package ${TARGET_TRIPLET}-dbg")
    vcpkg_execute_required_process(
#        COMMAND ${NINJA} install -v
        COMMAND ${MESON} install
        WORKING_DIRECTORY ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg
        LOGNAME package-${TARGET_TRIPLET}-dbg
    )

endfunction()
