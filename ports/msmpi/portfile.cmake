include(vcpkg_common_functions)

set(MSMPI_VERSION "10.0.12498")
set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/msmpi-${MSMPI_VERSION})

vcpkg_download_distfile(SDK_ARCHIVE
    URLS "https://download.microsoft.com/download/A/E/0/AE002626-9D9D-448D-8197-1EA510E297CE/msmpisdk.msi"
    FILENAME "msmpisdk-${MSMPI_VERSION}.msi"
    SHA512 36a31b2516f45fbc26167b31d2d6419f1928aef1591033f0430d36570159205e1a3134557a4ac0462f2d879add1fc6fee87a6997032e4438b528cd42a8bbe6b1
)

macro(download_msmpi_redistributable_package)
    vcpkg_download_distfile(REDIST_ARCHIVE
        URLS "https://download.microsoft.com/download/A/E/0/AE002626-9D9D-448D-8197-1EA510E297CE/msmpisetup.exe"
        FILENAME "msmpisetup-${MSMPI_VERSION}.exe"
        SHA512 c272dc842eb1e693f25eb580e1caf0c1fdb385611a12c20cdc6a40cf592ccbdba434a1c16edb63eef14b1a2ac6e678ac1cd561ec5fd003a5d17191a0fad281ae
    )
endmacro()

### Check for correct version of installed redistributable package

# We always want the ProgramFiles folder even on a 64-bit machine (not the ProgramFilesx86 folder)
vcpkg_get_program_files_platform_bitness(PROGRAM_FILES_PLATFORM_BITNESS)
set(SYSTEM_MPIEXEC_FILEPATH "${PROGRAM_FILES_PLATFORM_BITNESS}/Microsoft MPI/Bin/mpiexec.exe")

if(EXISTS "${SYSTEM_MPIEXEC_FILEPATH}")
    set(MPIEXEC_VERSION_LOGNAME "mpiexec-version")
    vcpkg_execute_required_process(
        COMMAND ${SYSTEM_MPIEXEC_FILEPATH}
        WORKING_DIRECTORY ${CURRENT_BUILDTREES_DIR}
        LOGNAME ${MPIEXEC_VERSION_LOGNAME}
    )
    file(READ ${CURRENT_BUILDTREES_DIR}/${MPIEXEC_VERSION_LOGNAME}-out.log MPIEXEC_OUTPUT)

    if(MPIEXEC_OUTPUT MATCHES "\\[Version ([0-9]+\\.[0-9]+\\.[0-9]+)\\.[0-9]+\\]")
        if(NOT CMAKE_MATCH_1 STREQUAL MSMPI_VERSION)
            download_msmpi_redistributable_package()

            message(FATAL_ERROR
                "  The version of the installed MSMPI redistributable packages does not match the version to be installed\n"
                "    Expected version: ${MSMPI_VERSION}\n"
                "    Found version: ${CMAKE_MATCH_1}\n"
                "  Please upgrade the installed version on your system.\n"
                "  The appropriate installer for the expected version has been downloaded to:\n"
                "    ${REDIST_ARCHIVE}\n")
        endif()
    else()
        message(FATAL_ERROR
            "  Could not determine installed MSMPI redistributable package version.\n"
            "  See logs for more information:\n"
            "    ${CURRENT_BUILDTREES_DIR}\\${MPIEXEC_VERSION_LOGNAME}-out.log\n"
            "    ${CURRENT_BUILDTREES_DIR}\\${MPIEXEC_VERSION_LOGNAME}-err.log\n")
    endif()
else()
    download_msmpi_redistributable_package()

    message(FATAL_ERROR
        "  Could not find:\n"
        "    ${SYSTEM_MPIEXEC_FILEPATH}\n"
        "  Please install the MSMPI redistributable package before trying to install this port.\n"
        "  The appropriate installer has been downloaded to:\n"
        "    ${REDIST_ARCHIVE}\n")
endif()

file(TO_NATIVE_PATH "${SDK_ARCHIVE}" SDK_ARCHIVE)
file(TO_NATIVE_PATH "${SOURCE_PATH}/sdk" SDK_SOURCE_DIR)
file(TO_NATIVE_PATH "${CURRENT_BUILDTREES_DIR}/msiexec-${TARGET_TRIPLET}.log" MSIEXEC_LOG_PATH)

set(PARAM_MSI "/a \"${SDK_ARCHIVE}\"")
set(PARAM_LOG "/log \"${MSIEXEC_LOG_PATH}\"")
set(PARAM_TARGET_DIR "TARGETDIR=\"${SDK_SOURCE_DIR}\"")
set(SCRIPT_FILE ${CURRENT_BUILDTREES_DIR}/msiextract-msmpi.bat)
# Write the command out to a script file and run that to avoid weird escaping behavior when spaces are present
file(WRITE ${SCRIPT_FILE} "msiexec ${PARAM_MSI} /qn ${PARAM_LOG} ${PARAM_TARGET_DIR}")

vcpkg_execute_required_process(
    COMMAND ${SCRIPT_FILE}
    WORKING_DIRECTORY ${CURRENT_BUILDTREES_DIR}
    LOGNAME extract-sdk
)

set(SOURCE_INCLUDE_PATH "${SOURCE_PATH}/sdk/PFiles/Microsoft SDKs/MPI/Include")
set(SOURCE_LIB_PATH "${SOURCE_PATH}/sdk/PFiles/Microsoft SDKs/MPI/Lib")

# Install include files
file(INSTALL
        "${SOURCE_INCLUDE_PATH}/mpi.h"
        "${SOURCE_INCLUDE_PATH}/mpif.h"
        "${SOURCE_INCLUDE_PATH}/mpi.f90"
        "${SOURCE_INCLUDE_PATH}/mpio.h"
        "${SOURCE_INCLUDE_PATH}/mspms.h"
        "${SOURCE_INCLUDE_PATH}/pmidbg.h"
        "${SOURCE_INCLUDE_PATH}/${TRIPLET_SYSTEM_ARCH}/mpifptr.h"
    DESTINATION
        ${CURRENT_PACKAGES_DIR}/include
)

# Install release libraries
file(INSTALL
        "${SOURCE_LIB_PATH}/${TRIPLET_SYSTEM_ARCH}/msmpi.lib"
        "${SOURCE_LIB_PATH}/${TRIPLET_SYSTEM_ARCH}/msmpifec.lib"
        "${SOURCE_LIB_PATH}/${TRIPLET_SYSTEM_ARCH}/msmpifmc.lib"
    DESTINATION
        ${CURRENT_PACKAGES_DIR}/lib
)
if(TRIPLET_SYSTEM_ARCH STREQUAL "x86")
    file(INSTALL
            "${SOURCE_LIB_PATH}/${TRIPLET_SYSTEM_ARCH}/msmpifes.lib"
            "${SOURCE_LIB_PATH}/${TRIPLET_SYSTEM_ARCH}/msmpifms.lib"
        DESTINATION
            ${CURRENT_PACKAGES_DIR}/lib
    )
endif()

# Install debug libraries
# NOTE: since the binary distribution does not include any debug libraries we simply install the release libraries
SET(VCPKG_POLICY_ONLY_RELEASE_CRT enabled)
file(INSTALL
        "${SOURCE_LIB_PATH}/${TRIPLET_SYSTEM_ARCH}/msmpi.lib"
        "${SOURCE_LIB_PATH}/${TRIPLET_SYSTEM_ARCH}/msmpifec.lib"
        "${SOURCE_LIB_PATH}/${TRIPLET_SYSTEM_ARCH}/msmpifmc.lib"
    DESTINATION
        ${CURRENT_PACKAGES_DIR}/debug/lib
)
if(TRIPLET_SYSTEM_ARCH STREQUAL "x86")
    file(INSTALL
            "${SOURCE_LIB_PATH}/${TRIPLET_SYSTEM_ARCH}/msmpifes.lib"
            "${SOURCE_LIB_PATH}/${TRIPLET_SYSTEM_ARCH}/msmpifms.lib"
        DESTINATION
            ${CURRENT_PACKAGES_DIR}/debug/lib
    )
endif()

# Handle copyright
file(COPY "${SOURCE_PATH}/sdk/PFiles/Microsoft SDKs/MPI/License/MicrosoftMPI-SDK-EULA.rtf" DESTINATION ${CURRENT_PACKAGES_DIR}/share/msmpi)
file(COPY "${SOURCE_PATH}/sdk/PFiles/Microsoft SDKs/MPI/License/MPI-SDK-TPN.txt" DESTINATION ${CURRENT_PACKAGES_DIR}/share/msmpi)
file(WRITE ${CURRENT_PACKAGES_DIR}/share/msmpi/copyright "See the accompanying MicrosoftMPI-SDK-EULA.rtf and MPI-SDK-TPN.txt")
