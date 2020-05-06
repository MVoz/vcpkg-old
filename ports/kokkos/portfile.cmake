# Common Ambient Variables:
#   CURRENT_BUILDTREES_DIR    = ${VCPKG_ROOT_DIR}\buildtrees\${PORT}
#   CURRENT_PACKAGES_DIR      = ${VCPKG_ROOT_DIR}\packages\${PORT}_${TARGET_TRIPLET}
#   CURRENT_PORT_DIR          = ${VCPKG_ROOT_DIR}\ports\${PORT}
#   CMAKE_CURRENT_LIST_DIR    = ${VCPKG_ROOT_DIR}\ports\${PORT}
#   PORT                      = current port name (zlib, etc)
#   TARGET_TRIPLET            = current triplet (x86-windows, x64-windows-static, etc)
#   VCPKG_CRT_LINKAGE         = C runtime linkage type (static, dynamic)
#   VCPKG_LIBRARY_LINKAGE     = target library linkage type (static, dynamic)
#   VCPKG_ROOT_DIR            = <C:\path\to\current\vcpkg>
#   VCPKG_TARGET_ARCHITECTURE = target architecture (x64, x86, arm)

#string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "static" KEYSTONE_BUILD_STATIC)
#string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "dynamic" KEYSTONE_BUILD_SHARED)
#vcpkg_configure_cmake(
#    SOURCE_PATH ${SOURCE_PATH}
#    PREFER_NINJA
#    OPTIONS
#        -DKEYSTONE_BUILD_STATIC=${KEYSTONE_BUILD_STATIC}
#        -DKEYSTONE_BUILD_SHARED=${KEYSTONE_BUILD_SHARED}
#)
#string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "static" CURL_STATICLIB)
#vcpkg_check_linkage(ONLY_STATIC_LIBRARY) ## = ## VCPKG_LIBRARY_LINKAGE=static ## = ## BUILD_STATIC_LIBS=ON
#vcpkg_check_linkage(ONLY_STATIC_LIBRARY ONLY_DYNAMIC_CRT)
#vcpkg_check_linkage(ONLY_DYNAMIC_LIBRARY)
#vcpkg_check_linkage(ONLY_DYNAMIC_LIBRARY ONLY_DYNAMIC_CRT)
###

#создаем пустой репозитор
#git init .
#добавляем в него все файлы
#git add .
#создаем бранч\коммит\точку
#git commit -m "patch"

#редактируем файлы
#и создаем патч на основе коммит
#git diff > ..\..\..\..\ports\kokkos\patch.patch

#git init . && git add . && git commit -m "patch"
#git diff > ..\..\..\..\ports\kokkos\001_kokkos_patch.patch

#configure_file(${SOURCE_PATH}/config.h.in ${SOURCE_PATH}/config.h COPYONLY)

#configure_file(config.h.in config.h)
#configure_file(${CMAKE_CURRENT_LIST_DIR}/config.h.in ${SOURCE_PATH})

include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/kokkos/kokkos/archive/2983b80d9aeafabb81f2c8c1c5a49b40cc0856cb.zip"
    FILENAME "2983b80d9aeafabb81f2c8c1c5a49b40cc0856cb.zip"
    SHA512 421de43e9e31591da87d5593c272bb52330ed95d68bc6a8d534a79a497a174dfc52e78f4ceb295032f61a16d2527405120d5b0083c322f69e9278e77d5ce2c5d
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
#    PATCHES
#      001_kokkos_fixes.patch
#      001_kokkos_patch.patch
)

set(VCPKG_FORTRAN_ENABLED ON)
vcpkg_enable_fortran(intel)

#vcpkg_find_acquire_program(PYTHON3)
#vcpkg_find_acquire_program(QT5)
#vcpkg_find_acquire_program(TEXLIVE)
#vcpkg_find_acquire_program(XGETTEXT)
#vcpkg_find_acquire_program(DOXYGEN)
#vcpkg_find_acquire_program(DOXYGEN)
#vcpkg_find_acquire_program(PERL)
#vcpkg_find_acquire_program(FLEX)
#vcpkg_find_acquire_program(BISON)
#get_filename_component(FLEX_DIR "${FLEX}" DIRECTORY)
#get_filename_component(BISON_DIR "${BISON}" DIRECTORY)
#get_filename_component(DOXYGEN_DIR "${DOXYGEN}" DIRECTORY)
#get_filename_component(PERL_DIR "${PERL}" DIRECTORY)
#get_filename_component(QT5_DIR "${QT5}" DIRECTORY)
#get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
#get_filename_component(DOXYGEN_DIR "${DOXYGEN}" DIRECTORY)
#get_filename_component(XGETTEXT_DIR "${XGETTEXT}" DIRECTORY)
#get_filename_component(TEXLIVE_DIR "${TEXLIVE}" DIRECTORY)
#set(ENV{PATH} ";$ENV{PATH};${QT5_DIR};${PYTHON3_DIR};${DOXYGEN_DIR};${XGETTEXT_DIR};${TEXLIVE_DIR};${FLEX_DIR};${BISON_DIR};${DOXYGEN_DIR};${PERL_DIR}")
#vcpkg_find_acquire_program(YASM)
#get_filename_component(YASM_EXE_PATH ${YASM} DIRECTORY)
#set(ENV{PATH} "$ENV{PATH};${YASM_EXE_PATH}")

#get_filename_component(GIT_EXE_PATH ${GIT} DIRECTORY)
#set(SH_EXE_PATH "${GIT_EXE_PATH}/../usr/bin")
#set(ENV{PATH} "$ENV{PATH};${VALAC_DIR};${BISON_DIR};${FLEX_DIR};${SH_EXE_PATH}")

#file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH})

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates

    OPTIONS 
#      -DKOKKOS_ARCH:STRING=NOT_SET
#      -DKOKKOS_CUDA_DIR:PATH=
#      -DKOKKOS_ENABLE_AGGRESSIVE_VECTORIZATION=OFF
#      -DKOKKOS_ENABLE_AGGRESSIVE_VECTORIZATION_INTERNAL=OFF
#      -DKOKKOS_ENABLE_COMPILER_WARNINGS=OFF
#      -DKOKKOS_ENABLE_COMPILER_WARNINGS_INTERNAL=OFF
#      -DKOKKOS_ENABLE_CUDA=OFF
#      -DKOKKOS_ENABLE_CUDA_INTERNAL=OFF
#      -DKOKKOS_ENABLE_CUDA_LAMBDA=OFF
#      -DKOKKOS_ENABLE_CUDA_LAMBDA_INTERNAL=OFF
#      -DKOKKOS_ENABLE_CUDA_LDG_INTRINSIC=
#      -DKOKKOS_ENABLE_CUDA_LDG_INTRINSIC_INTERNAL=
#      -DKOKKOS_ENABLE_CUDA_RELOCATABLE_DEVICE_CODE=OFF
#      -DKOKKOS_ENABLE_CUDA_RELOCATABLE_DEVICE_CODE_INTERNAL=OFF
#      -DKOKKOS_ENABLE_CUDA_UVM=
#      -DKOKKOS_ENABLE_CUDA_UVM_INTERNAL=
#      -DKOKKOS_ENABLE_DEBUG=OFF
#      -DKOKKOS_ENABLE_DEBUG_BOUNDS_CHECK_INTERNAL=
#      -DKOKKOS_ENABLE_DEBUG_DUALVIEW_MODIFY_CHECK=OFF
#      -DKOKKOS_ENABLE_DEBUG_DUALVIEW_MODIFY_CHECK_INTERNAL=OFF
#      -DKOKKOS_ENABLE_DEBUG_INTERNAL=OFF
      -DKOKKOS_ENABLE_DEPRECATED_CODE=ON
      -DKOKKOS_ENABLE_DEPRECATED_CODE_INTERNAL=ON
#      -DKOKKOS_ENABLE_EXPLICIT_INSTANTIATION=OFF
#      -DKOKKOS_ENABLE_EXPLICIT_INSTANTIATION_INTERNAL=OFF
#      -DKOKKOS_ENABLE_HPX=OFF
#      -DKOKKOS_ENABLE_HPX_ASYNC_DISPATCH=OFF
#      -DKOKKOS_ENABLE_HPX_ASYNC_DISPATCH_INTERNAL=OFF
#      -DKOKKOS_ENABLE_HPX_INTERNAL=OFF
      -DKOKKOS_ENABLE_HWLOC=ON
      -DKOKKOS_ENABLE_HWLOC_INTERNAL=ON
      -DKOKKOS_ENABLE_LIBRT=OFF
      -DKOKKOS_ENABLE_LIBRT_INTERNAL=OFF
#      -DKOKKOS_ENABLE_MEMKIND=OFF
#      -DKOKKOS_ENABLE_MEMKIND_INTERNAL=OFF
      -DKOKKOS_ENABLE_OPENMP=ON
      -DKOKKOS_ENABLE_OPENMP_INTERNAL=ON
      -DKOKKOS_ENABLE_PROFILING=OFF
      -DKOKKOS_ENABLE_PROFILING_INTERNAL=OFF
#      -DKOKKOS_ENABLE_PROFILING_LOAD_PRINT=OFF
#      -DKOKKOS_ENABLE_PROFILING_LOAD_PRINT_INTERNAL=OFF
#      -DKOKKOS_ENABLE_PTHREAD=OFF
#      -DKOKKOS_ENABLE_PTHREAD_INTERNAL=OFF
#      -DKOKKOS_ENABLE_QTHREADS=
#      -DKOKKOS_ENABLE_QTHREAD_INTERNAL=
#      -DKOKKOS_ENABLE_ROCM=OFF
#      -DKOKKOS_ENABLE_ROCM_INTERNAL=OFF
      -DKOKKOS_ENABLE_SERIAL=OFF
      -DKOKKOS_ENABLE_SERIAL_INTERNAL=OFF
#      -DKOKKOS_HAS_TRILINOS=OFF
#      -DKOKKOS_HPX_DIR:PATH=
#      -DKOKKOS_HWLOC_DIR:PATH=
#      -DKOKKOS_MEMKIND_DIR:PATH=
#      -DKOKKOS_QTHREADS_DIR:PATH=
      -DKOKKOS_SEPARATE_LIBS=ON
      -DKOKKOS_SEPARATE_TESTS=ON
#      -DKOKKOS_ENABLE_Aggressive_Vectorization=OFF
#      -DKOKKOS_ENABLE_Compiler_Warnings=OFF
      -DKOKKOS_ENABLE_Cuda=ON
#      -DKOKKOS_ENABLE_Cuda_LDG_Intrinsic=
#      -DKOKKOS_ENABLE_Cuda_Lambda=OFF
#      -DKOKKOS_ENABLE_Cuda_Relocatable_Device_Code=OFF
#      -DKOKKOS_ENABLE_Cuda_UVM=
#      -DKOKKOS_ENABLE_Debug=OFF
#      -DKOKKOS_ENABLE_Debug_DualView_Modify_Check=OFF
#      -DKOKKOS_ENABLE_Deprecated_Code=ON
#      -DKOKKOS_ENABLE_Explicit_Instantiation=OFF
#      -DKOKKOS_ENABLE_HPX=OFF
#      -DKOKKOS_ENABLE_HPX_ASYNC_DISPATCH=OFF
      -DKOKKOS_ENABLE_HWLOC=ON
      -DKOKKOS_ENABLE_LIBRT=OFF
      -DKOKKOS_ENABLE_MEMKIND=OFF
      -DKOKKOS_ENABLE_OpenMP=ON
      -DKOKKOS_ENABLE_Profiling=OFF
      -DKOKKOS_ENABLE_Profiling_Load_Print=OFF
      -DKOKKOS_ENABLE_Pthread=OFF
      -DKOKKOS_ENABLE_ROCm=OFF
      -DKOKKOS_ENABLE_Serial=OFF
)

vcpkg_install_cmake()

### https://mesonbuild.com/Configuring-a-build-directory.html
#vcpkg_configure_meson(
#    SOURCE_PATH ${SOURCE_PATH}
#    OPTIONS
#      --backend=ninja
#)

#vcpkg_install_meson()

###
#msbuild build-package.proj /t:Clean;BeforeBuild
#msbuild build.proj /t:Build
#msbuild build-package.proj /t:PreparePackage;Package

#vcpkg_install_msbuild(
#    SOURCE_PATH ${SOURCE_PATH}
#    PROJECT_SUBPATH "ide/vs2017/mimalloc.vcxproj"
#    TARGET restore
#    SKIP_CLEAN
#    RELEASE_CONFIGURATION Release_x86${MPG123_CONFIGURATION_SUFFIX}
#    DEBUG_CONFIGURATION Debug_x86${MPG123_CONFIGURATION_SUFFIX}
#    LICENSE_SUBPATH LICENSE
#    ALLOW_ROOT_INCLUDES ON
#    USE_VCPKG_INTEGRATION
#)

#file(GLOB_RECURSE TMP_FILES "${SOURCE_PATH}/include/*.hin" "${SOURCE_PATH}/include/*.orig" "${SOURCE_PATH}/include/*.in")
#file(REMOVE_RECURSE ${TMP_FILES})

#remove_srcs_file("${SOURCE_PATH}/include/*.hin" "${SOURCE_PATH}/include/*.orig" "${SOURCE_PATH}/include/*.in")

#file(COPY ${SOURCE_PATH}/include DESTINATION ${CURRENT_PACKAGES_DIR}/include)
#file(RENAME ${CURRENT_PACKAGES_DIR}/include/include ${CURRENT_PACKAGES_DIR}/include/openldap)

#file(TO_NATIVE_PATH "${CURRENT_INSTALLED_DIR}/include" PGSQL_INCLUDE_DIR)
#file(COPY ${CURRENT_PACKAGES_DIR}/wpilib/lib/ DESTINATION ${CURRENT_PACKAGES_DIR}/bin FILES_MATCHING PATTERN "*.dll")
#file(COPY ${SOURCE_PATH}/greatest.h DESTINATION ${CURRENT_PACKAGES_DIR}/include)

#vcpkg_fixup_cmake_targets(CONFIG_PATH "lib/cmake/${PORT}")
#vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/nlohmann_json TARGET_PATH share/nlohmann_json)
#file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/bin)
#file(RENAME ${CURRENT_PACKAGES_DIR}/lib/${LIB_NAME}.dll ${CURRENT_PACKAGES_DIR}/bin/${LIB_NAME}.dll
#file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/kokkos RENAME copyright)

#file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/lib ${CURRENT_PACKAGES_DIR}/debug)
#file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin ${CURRENT_PACKAGES_DIR}/debug/bin ${CURRENT_PACKAGES_DIR}/debug/share ${CURRENT_PACKAGES_DIR}/debug/include)

#file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/tools)
#file(RENAME ${CURRENT_PACKAGES_DIR}/debug/bin ${CURRENT_PACKAGES_DIR}/tools/${PORT})

#vcpkg_copy_tool_dependencies(${CURRENT_PACKAGES_DIR}/tools/openexr)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME kokkos)

#install(
#    TARGETS ${PROJECT} 
#    EXPORT ${PROJECT}-export
#    RUNTIME DESTINATION ${BINARY_INSTALL_DIR}
#    LIBRARY DESTINATION ${LIBRARY_INSTALL_DIR}
#    ARCHIVE DESTINATION ${LIBRARY_INSTALL_DIR}
#    BUNDLE DESTINATION .
##    FRAMEWORK DESTINATION ${FRAMEWORK_INSTALL_DIR}
##    PUBLIC_HEADER DESTINATION ${INCLUDE_INSTALL_DIR}/qjson${QJSON_SUFFIX}
#)

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
