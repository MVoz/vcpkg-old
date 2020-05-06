include(vcpkg_common_functions)

if(VCPKG_CMAKE_SYSTEM_NAME OR VCPKG_CMAKE_SYSTEM_NAME STREQUAL "WindowsStore")
	message(FATAL_ERROR "\n-- Build port ${PORT} only supported Windows Desktop")
endif()

vcpkg_download_distfile(ARCHIVE
    URLS "https://netix.dl.sourceforge.net/project/lpsolve/lpsolve/5.5.2.5/lp_solve_5.5.2.5_source.tar.gz"
    FILENAME "lp_solve_5.5.2.5_source.tar.gz"
    SHA512 6ae78b01bf50990b8141dfe3c1994bb9e7632db6a200c7900ac44de592b3ac1e21063f7b4554d4960af01538d89e937fc25da14f67156d12464e8cfdf0f86c46
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE} 
)

vcpkg_install_msbuild(
    SOURCE_PATH ${SOURCE_PATH}
    PROJECT_SUBPATH lp_solve/lp_solve.vcxproj

	SKIP_CLEAN
	LICENSE_SUBPATH README.txt
	ALLOW_ROOT_INCLUDES ON
	USE_VCPKG_INTEGRATION
)

