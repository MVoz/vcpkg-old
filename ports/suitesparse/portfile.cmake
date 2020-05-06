include(vcpkg_common_functions)

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

set(SUITESPARSE_VER 5.4.0)
set(SUITESPARSEWIN_VER 1.4.0)

vcpkg_download_distfile(SUITESPARSE
    URLS "http://faculty.cse.tamu.edu/davis/SuiteSparse/SuiteSparse-${SUITESPARSE_VER}.tar.gz"
    FILENAME "SuiteSparse-${SUITESPARSE_VER}.tar.gz"
    SHA512 8328bcc2ef5eb03febf91b9c71159f091ff405c1ba7522e53714120fcf857ceab2d2ecf8bf9a2e1fc45e1a934665a341e3a47f954f87b59934f4fce6164775d6
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${SUITESPARSE}
)

vcpkg_from_github(
    OUT_SOURCE_PATH SUITESPARSEWIN_SOURCE_PATH
    REPO jlblancoc/suitesparse-metis-for-windows
    REF d63119f3157ff14f6e435e936d27ed07d462e5de
    SHA512 48b48d31c853290a4265e6fef724e63131eb04c05884e9d11ba194e28228aa9c732e7b612e37dbf55d4b22364b2c8136b2df4c07484fef32b33e73a7b07ef6aa
    HEAD_REF master
    PATCHES
        suitesparse.patch
)

set(VCPKG_FORTRAN_ENABLED ON)
vcpkg_enable_fortran(intel)

# Copy suitesparse sources.
message(STATUS "Copying SuiteSparse source files...")
# Should probably remove everything but CMakeLists.txt files?
file(GLOB SUITESPARSE_SOURCE_FILES ${SOURCE_PATH}/*)
foreach(SOURCE_FILE ${SUITESPARSE_SOURCE_FILES})
    file(COPY ${SOURCE_FILE} DESTINATION "${SUITESPARSEWIN_SOURCE_PATH}/SuiteSparse")
endforeach()
message(STATUS "Copying SuiteSparse source files... done")
message(STATUS "Removing integrated lapack and metis libs...")
file(REMOVE_RECURSE ${SUITESPARSEWIN_SOURCE_PATH}/lapack_windows)
file(REMOVE_RECURSE ${SUITESPARSEWIN_SOURCE_PATH}/metis)
message(STATUS "Removing integrated lapack and metis libs... done")

set(USE_VCPKG_METIS OFF)
if("metis" IN_LIST FEATURES)
    set(USE_VCPKG_METIS ON)
    set(ADDITIONAL_BUILD_OPTIONS "-DMETIS_SOURCE_DIR=${CURRENT_INSTALLED_DIR}")
endif()

vcpkg_configure_cmake(
    SOURCE_PATH ${SUITESPARSEWIN_SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DBUILD_METIS=OFF #Disable the option to build metis from source
        -DUSE_VCPKG_METIS=${USE_VCPKG_METIS} #Force using vcpckg metis library
        ${ADDITIONAL_BUILD_OPTIONS}
        -DMETIS_SOURCE_DIR=${CURRENT_INSTALLED_DIR}
        -DLIB_POSTFIX=
		-DOPENMP=ON 
		-DPCRE=OFF
        -DSUITESPARSE_USE_CUSTOM_BLAS_LAPACK_LIBS=ON
        -DSUITESPARSE_CUSTOM_BLAS_LIB=${CURRENT_INSTALLED_DIR}/lib/openblas.lib
        -DSUITESPARSE_CUSTOM_LAPACK_LIB=${CURRENT_INSTALLED_DIR}/lib/lapack.lib
#		-DSUITESPARSE_USE_CUSTOM_BLAS_LAPACK_LIBS=ON
#		-DSUITESPARSE_CUSTOM_BLAS_LIB #Path to custom library file for BLAS _ libblas.lib libblas.dll
#		-DSUITESPARSE_CUSTOM_LAPACK_LIB #Path to custom library file for LAPACK _ liblapack.lib liblapack.dll
#		-DSuiteSparse_LAPACK_BLAS_LIB_DIR 
		-DUSE_MKL=ON
		
     OPTIONS_DEBUG
        -DSUITESPARSE_INSTALL_PREFIX="${CURRENT_PACKAGES_DIR}/debug"
     OPTIONS_RELEASE
        -DSUITESPARSE_INSTALL_PREFIX="${CURRENT_PACKAGES_DIR}"
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/suitesparse-${SUITESPARSE_VER})

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

file(INSTALL ${SOURCE_PATH}/LICENSE.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/suitesparse RENAME copyright)
file(INSTALL ${SUITESPARSEWIN_SOURCE_PATH}/LICENSE.md DESTINATION ${CURRENT_PACKAGES_DIR}/share/suitesparse RENAME copyright_suitesparse-metis-for-windows)
