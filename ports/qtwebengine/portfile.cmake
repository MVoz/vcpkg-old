###
##
##                          Welcome to QtWebEngine.
## https://chromium.googlesource.com/chromium/src/+/master/docs/windows_build_instructions.md
##
##                                  WARNING!
##
##  - Expect build times of between 4 & 6 hrs, depending upon on the hardware specifications of the build machine. -
##
##  - This port file is experimental and requires 150-200 gigabytes of free space available. -
##  - The build dependencies of this piece of software are highly inflexible. -
##
###

include(vcpkg_common_functions)

set(_qt5base_port_dir "${CMAKE_CURRENT_LIST_DIR}")

function(qt_webengine_fetch_library NAME HASH TARGET_SOURCE_PATH)

    string(LENGTH "${CURRENT_BUILDTREES_DIR}" BUILDTREES_PATH_LENGTH)

    if(BUILDTREES_PATH_LENGTH GREATER 45)
        message(WARNING "Qt5's buildsystem uses very long paths and may fail on your system.\n"
            "We recommend moving vcpkg to a short path such as 'C:\\src\\vcpkg' or using the subst command."
        )
    endif()

    message(STATUS "* Acquiring the qtwebengine source code...")
    message(STATUS "* Please be patient whilst the source archive is downloaded and extracted.")
    message(STATUS "* The archive is large and extracting it may take some time.")

    ### ------------------------------------------------------

    set(MAJOR_MINOR 5.12)
    set(FULL_VERSION ${MAJOR_MINOR}.3)
    set(ARCHIVE_NAME "${NAME}-everywhere-src-${FULL_VERSION}.tar.xz")

    ## Pull an official release archive

    #vcpkg_download_distfile(ARCHIVE_FILE
        #URLS "http://download.qt.io/official_releases/qt/${MAJOR_MINOR}/${FULL_VERSION}/submodules/${ARCHIVE_NAME}"
        #FILENAME ${ARCHIVE_NAME}
        #SHA512 ${HASH}
    #)

    #vcpkg_extract_source_archive_ex(
        #OUT_SOURCE_PATH SOURCE_PATH
        #ARCHIVE "${ARCHIVE_FILE}"
        #REF ${FULL_VERSION}
    #)

    ### ------------------------------------------------------

    ### ------------------------------------------------------

    ## Pull the source from github

    vcpkg_from_github(
        ## (https://github.com/qt/qtwebengine)
        OUT_SOURCE_PATH SOURCE_PATH
        REPO qt/qtwebengine
        REF 7ba379ecfa575f871a52dc94c9f29e2bfdfc9865
        HEAD_REF 5.12.3
        SHA512 41453672054acffc680be74aa664220c19ec2bb23fb34313fefd1dc48e6c18bd6ed30611477b78ca5549ef0e62b655bdc3c8e4306a9094d0b12dcbb58614baa2
    )

    ## Obtain perl so that the includes folder can be created (only required if the qtwebengine sources have been acquired from git)

    vcpkg_find_acquire_program(PERL)
    get_filename_component(PERL_EXE_PATH ${PERL} DIRECTORY)
    set(ENV{PATH} "${PERL_EXE_PATH};$ENV{PATH}")

    ## Run the syncqt.pl script to generate the includes directory (only required if the qtwebengine sources have been acquired from git)

	vcpkg_execute_required_process(
		COMMAND perl ${VCPKG_ROOT_DIR}/packages/qt5-base_x64-windows/tools/qt5/syncqt.pl -version ${FULL_VERSION}
		WORKING_DIRECTORY ${SOURCE_PATH}
	)

    ### ------------------------------------------------------

    ### ------------------------------------------------------

    ## "Fix" 5.12.3 so that it will build with VS2019 by removing an arbitrary hard coded compiler dep..
    ## 5.12.4 does not need this fix and this section can be removed when building 5.12.4+
    file(READ ${SOURCE_PATH}/src/core/config/windows.pri WIN_PRI)
	string(REPLACE "MSVS_VERSION = 2017" "MSVS_VERSION = 2017 } else: equals(MSVC_VER, 16.0) { MSVS_VERSION = 2019" WIN_PRI "${WIN_PRI}")
	file(WRITE ${SOURCE_PATH}/src/core/config/windows.pri "${WIN_PRI}")

    ### ------------------------------------------------------

    set(${TARGET_SOURCE_PATH} ${SOURCE_PATH} PARENT_SCOPE)

    ## Add some includes to the INCLUDEPATH

    set(ENV{INCLUDEPATH} "${SOURCE_PATH}/include/;$ENV{INCLUDEPATH}")

endfunction()

function(qt_webengine_build_library SOURCE_PATH)

    ## This fixes issues on machines with default codepages that are not ASCII compatible, such as some CJK encodings
    set(ENV{_CL_} "/utf-8")

    ## Store build paths
    set(DEBUG_DIR "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg")
    set(RELEASE_DIR "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel")

    ## Find Python and add it to the path
    vcpkg_find_acquire_program(PYTHON2)
    get_filename_component(PYTHON2_EXE_PATH ${PYTHON2} DIRECTORY)
    set(ENV{PATH} "${PYTHON2_EXE_PATH};$ENV{PATH}")

    file(TO_NATIVE_PATH "${CURRENT_INSTALLED_DIR}" NATIVE_INSTALLED_DIR)
    file(TO_NATIVE_PATH "${CURRENT_PACKAGES_DIR}" NATIVE_PACKAGES_DIR)

    if(WIN32)
        string(SUBSTRING "${NATIVE_INSTALLED_DIR}" 2 -1 INSTALLED_DIR_WITHOUT_DRIVE)
        string(SUBSTRING "${NATIVE_PACKAGES_DIR}" 2 -1 PACKAGES_DIR_WITHOUT_DRIVE)
    else()
        set(INSTALLED_DIR_WITHOUT_DRIVE ${NATIVE_INSTALLED_DIR})
        set(PACKAGES_DIR_WITHOUT_DRIVE ${NATIVE_PACKAGES_DIR})
    endif()

    ### ------------------------------------------------------

    if(EXISTS ${SOURCE_PATH}/src/3rdparty/chromium/)

        message(STATUS "* Utilising previously acquired and extracted Chromium source code...")

    else()

        message(STATUS "* Acquiring the Chromium source code from Github...")
        message(STATUS "* Please be patient whilst the source archive is downloaded and extracted.")
        message(STATUS "* The archive is large and extracting it may take some time.")

        ## Both gn and ninja placed inside the ${SOURCE_PATH}/src/3rdparty/ directory are required to build this software.

        vcpkg_from_github(
            OUT_SOURCE_PATH CRO_SOURCE_PATH
            REPO qt/qtwebengine-chromium
            REF e8eec84aac0dc626770a483d503f7b16ab0dbe70
            HEAD_REF 69-based
            SHA512 5b3932010d8836cd8bce58284973ffd0f34a372a38790cc889f750253c647ae4773b3dcf816b13865a123e93767fc065c23c03925e0f1328aa5bbbb5af03d058
            #REF 0aae24c2876d19946ce0d28adc38c3dbed2c6549
            #HEAD_REF 71-based
            #SHA512 ffe82b76c4c7b44236dd89b516b076a09a181ffb290c04d6224617897cf08b463dd0f8f3c6260ba5a178dca66ff15c723dab8b737761f323ff0c65b5ab0649ac
            #PATCHES
                #"${CMAKE_CURRENT_LIST_DIR}/qtwebengine.patch"
            ## The ref and sha hash 69-based are for the 5.12.3 version of qtwebengine-chromium
            ## Due to a bug in QtWebEngine, bumping to 71-based is not possible until QtWebEngine 5.12.4+
            ## The below example bumps to version 75 (https://github.com/qt/qtwebengine) (version 75 does not currently build with 5.12.3)
            #REF 06d572ebf4947483ad556db7232a22c76fcf38d7
            #SHA512 8a8fb1a236a319a7c415611cf156ab96321c3fd30130a8592b3d5270c023ef8fc20e0e70cf10f274645abd8a15738b377a71e682e1e7a996d59f2935ab6fed5b
            #HEAD_REF 75-based
        )

        message(STATUS "* Moving the Chromium source code into place within the source tree...")

	    file(RENAME ${CRO_SOURCE_PATH}/chromium/ ${SOURCE_PATH}/src/3rdparty/chromium/)

    endif()

    set(ENV{PATH} "${SOURCE_PATH}/src/3rdparty/chromium/;$ENV{PATH}")

    ### ------------------------------------------------------

    ### ------------------------------------------------------

    if(EXISTS ${VCPKG_ROOT_DIR}/buildtrees/qtwebengine/src/gnuwin32/bin/)

        message(STATUS "* Utilising previously acquired gperf, bison and flex binaries...")

    else()

        message(STATUS "* Obtaining and moving the gperf, bison and flex binaries into position...")
        ## Copy vcpkg gperf into the build tree
        vcpkg_find_acquire_program(GPERF)
        get_filename_component(GPERF_EXE_PATH ${GPERF} DIRECTORY)
        file(COPY ${GPERF_EXE_PATH}/gperf.exe DESTINATION ${VCPKG_ROOT_DIR}/buildtrees/qtwebengine/src/gnuwin32/bin/)
        ## Copy vcpkg bison and flex into the build tree
        vcpkg_find_acquire_program(BISON)
        get_filename_component(BISON_EXE_PATH ${BISON} DIRECTORY)
        file(COPY ${BISON_EXE_PATH}/win_bison.exe DESTINATION ${VCPKG_ROOT_DIR}/buildtrees/qtwebengine/src/gnuwin32/bin/)
        file(COPY ${BISON_EXE_PATH}/win_flex.exe DESTINATION ${VCPKG_ROOT_DIR}/buildtrees/qtwebengine/src/gnuwin32/bin/)
        file(COPY ${BISON_EXE_PATH}/data/ DESTINATION ${VCPKG_ROOT_DIR}/buildtrees/qtwebengine/src/gnuwin32/bin/data/)
        file(RENAME ${VCPKG_ROOT_DIR}/buildtrees/qtwebengine/src/gnuwin32/bin/win_flex.exe ${VCPKG_ROOT_DIR}/buildtrees/qtwebengine/src/gnuwin32/bin/flex.exe)
        file(RENAME ${VCPKG_ROOT_DIR}/buildtrees/qtwebengine/src/gnuwin32/bin/win_bison.exe ${VCPKG_ROOT_DIR}/buildtrees/qtwebengine/src/gnuwin32/bin/bison.exe)

    endif()

    set(ENV{PATH} "${VCPKG_ROOT_DIR}/buildtrees/qtwebengine/src/gnuwin32/bin/;$ENV{PATH}")

    ### ------------------------------------------------------

    ### ------------------------------------------------------

    ## Comment out the following single line for 5.12.4+ or for testing. The version of ninja which ships with 5.12.3 is old.
	#file(REMOVE_RECURSE ${SOURCE_PATH}/src/3rdparty/ninja)

    if(EXISTS ${SOURCE_PATH}/src/3rdparty/ninja/)

        message(STATUS "* Utilising previously acquired ninja...")

    else()

        message(STATUS "* Copying ninja into the build tree...")

        vcpkg_find_acquire_program(NINJA)
        get_filename_component(NINJA_EXE_PATH ${NINJA} DIRECTORY)
        file(COPY ${NINJA_EXE_PATH}/ninja.exe DESTINATION ${SOURCE_PATH}/src/3rdparty/ninja/)

    endif()

    set(ENV{PATH} "${SOURCE_PATH}/src/3rdparty/ninja/;$ENV{PATH}")

    ### ------------------------------------------------------

    ### ------------------------------------------------------

    ## Comment out the following single line for 5.12.4+ or for testing. The version of gn which ships with 5.12.3 is bad.
	#file(REMOVE_RECURSE ${SOURCE_PATH}/src/3rdparty/gn)

    if(EXISTS ${SOURCE_PATH}/src/3rdparty/gn/)

        message(STATUS "* Utilising previously acquired gn...")

    else()

        ## Use the version which ships with qtwebengine-chromium git
        file(RENAME ${CRO_SOURCE_PATH}/gn/ ${SOURCE_PATH}/src/3rdparty/gn/)

        ### ------------------------------------------------------

        ## Experimental pull gn from git (not recommended unless you know exactly which commit you need)

        #message(STATUS "* Acquiring the gn source code...")

        ## - WARNING! -
        ## If you bump gn higher than the following commit, then
        ## expect errors.
        ## The following commit currently causes big issues when using gn
        ## on the Chromium source code :
        ## https://gn.googlesource.com/gn/+/8730b0feb6b991fa47368566501ab9ccfb453c92
        ## Below we use the commit before it. (It's parent.)

	    #vcpkg_from_git(
		    #OUT_SOURCE_PATH GN_SOURCE_PATH
		    #URL https://gn.googlesource.com/gn
            ## Tree : https://gn.googlesource.com/gn/+/0d038c2e0a32a528713d3dfaf1f1e0cdfe87fd46/
		    #REF 0d038c2e0a32a528713d3dfaf1f1e0cdfe87fd46
		    #SHA512 ff0fc5f7eb0f38a76098b750dd1922563c9dad08e43de731cb8a98d6b35b6fa560fc8e248dbc90747b1ca6321bffebb4f4fd9d3de5721ce3c74ac117387a9388
            #HEAD_REF master
	    #)

        #message(STATUS "* Patching the gn source code and moving it into position within the source tree...")

	    ## Deal with "Cannot open include file: 'last_commit_position.h': No such file or directory"
	    #file(READ ${GN_SOURCE_PATH}/tools/gn/gn_main.cc  GN_MAIN_C)
	    #string(REPLACE "#include \"last_commit_position.h\"" "#define LAST_COMMIT_POSITION \"dont-be-evil\"" GN_MAIN_C "${GN_MAIN_C}")
	    #file(WRITE ${GN_SOURCE_PATH}/tools/gn/gn_main.cc "${GN_MAIN_C}")
	    ## Copy the new version into place
	    #file(RENAME ${GN_SOURCE_PATH} ${SOURCE_PATH}/src/3rdparty/gn/)

        ### ------------------------------------------------------

    endif()

    set(ENV{PATH} "${SOURCE_PATH}/src/3rdparty/gn/);$ENV{PATH}")

    ### ------------------------------------------------------

    ### ------------------------------------------------------

    if(EXISTS ${SOURCE_PATH}/src/3rdparty/chromium/README.md)

        message(STATUS "* Patching the source tree...")
        ### ------------------------------------------------------
        ##                  "Fixes"
        ### ------------------------------------------------------

        ## "Fix" the "The GN arg 'remove_webcore_debug_symbols' is deprecated" error message
        file(READ ${SOURCE_PATH}/src/core/config/common.pri COM_PRI)
	    string(REPLACE "!webcore_debug: gn_args += remove_webcore_debug_symbols=true" "!webcore_debug: gn_args += blink_symbol_level = 0" COM_PRI "${COM_PRI}")
        ##
        ## "Fix" the "Ninja does not see existing precompiled header" error https://bugreports.qt.io/browse/QTBUG-65677
        ## Qt 5.13 does not suffer from the precompiled header bug (according to the linked report)
        ## Compiling the headers means the build takes significantly longer to complete
        ## Builds of 5.12 need the below line
	    string(REPLACE "gn_args += enable_precompiled_headers=true" "gn_args += enable_precompiled_headers=false" COM_PRI "${COM_PRI}")
        ##
        ## Enable proprietary codecs
	    string(REPLACE "qtConfig(webengine-proprietary-codecs):" " " COM_PRI "${COM_PRI}")
	    file(WRITE ${SOURCE_PATH}/src/core/config/common.pri "${COM_PRI}")
        #
        ## "Fix" the "resource whitelist generation only works on non-component builds with debug info enabled." error message
        file(READ ${SOURCE_PATH}/src/3rdparty/chromium/build/toolchain/gcc_toolchain.gni GTC_GNI)
	    string(REPLACE "(target_os == \"android\" || target_os == \"win\")" "(target_os == \"android\")" GTC_GNI "${GTC_GNI}")
	    file(WRITE ${SOURCE_PATH}/src/3rdparty/chromium/build/toolchain/gcc_toolchain.gni "${GTC_GNI}")

        ### ------------------------------------------------------

        ## Prevent patching twice upon rebuilds
        file(REMOVE ${SOURCE_PATH}/src/3rdparty/chromium/README.md)

    else()

        message(STATUS "* Source tree is already patched...")

    endif()

    ### ------------------------------------------------------

    message(STATUS "* Configuring the QtWebEngine source tree...")

   vcpkg_configure_qmake(
      SOURCE_PATH ${SOURCE_PATH}/qtwebengine.pro
   )

    message(STATUS "* Build QtWebEngine from source begin:")
    message(STATUS "* The process will take several hours (4-6 on average) to complete.")
    message(STATUS "* Please be patient whilst the software is built")

    vcpkg_build_qmake()

    message(STATUS "*** Build QtWebEngine from source complete!")
    message(STATUS "* Cleaning up...")
    message(STATUS "* Fixing cmake files...")

    if(EXISTS ${RELEASE_DIR}/lib/cmake)
        vcpkg_execute_required_process(
            COMMAND ${PYTHON2} ${_qt5base_port_dir}/fixcmake.py ${PORT}
            WORKING_DIRECTORY ${RELEASE_DIR}/lib/cmake
            LOGNAME fix-cmake
        )
    endif()

    file(GLOB_RECURSE MAKEFILES ${DEBUG_DIR}/*Makefile* ${RELEASE_DIR}/*Makefile*)

    foreach(MAKEFILE ${MAKEFILES})
        file(READ "${MAKEFILE}" _contents)
        message(STATUS "* Correcting the package install directory...")
        string(REPLACE "(INSTALL_ROOT)${INSTALLED_DIR_WITHOUT_DRIVE}" "(INSTALL_ROOT)${PACKAGES_DIR_WITHOUT_DRIVE}" _contents "${_contents}")
        file(WRITE "${MAKEFILE}" "${_contents}")
    endforeach()

    message(STATUS "* Installing the module files...")

    vcpkg_build_qmake(TARGETS install SKIP_MAKEFILES BUILD_LOGNAME install)

    message(STATUS "* Removing extra cmake files...")

    if(EXISTS ${CURRENT_PACKAGES_DIR}/lib/cmake)
        file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/share)
        file(RENAME ${CURRENT_PACKAGES_DIR}/lib/cmake ${CURRENT_PACKAGES_DIR}/share/cmake)
    endif()

    if(EXISTS ${CURRENT_PACKAGES_DIR}/debug/lib/cmake)
        file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/lib/cmake)
    endif()

    file(GLOB_RECURSE PRL_FILES "${CURRENT_PACKAGES_DIR}/lib/*.prl" "${CURRENT_PACKAGES_DIR}/debug/lib/*.prl")
    if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "release")
        file(TO_CMAKE_PATH "${CURRENT_INSTALLED_DIR}/lib" CMAKE_RELEASE_LIB_PATH)
    endif()

    if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "debug")
        file(TO_CMAKE_PATH "${CURRENT_INSTALLED_DIR}/debug/lib" CMAKE_DEBUG_LIB_PATH)
    endif()

    foreach(PRL_FILE IN LISTS PRL_FILES)
        file(READ "${PRL_FILE}" _contents)
        string(REPLACE "${CMAKE_RELEASE_LIB_PATH}" "\$\$[QT_INSTALL_LIBS]" _contents "${_contents}")
        string(REPLACE "${CMAKE_DEBUG_LIB_PATH}" "\$\$[QT_INSTALL_LIBS]" _contents "${_contents}")
        file(WRITE "${PRL_FILE}" "${_contents}")
    endforeach()

    file(GLOB RELEASE_LIBS "${CURRENT_PACKAGES_DIR}/lib/*")
    if(NOT RELEASE_LIBS)
        file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/lib)
    endif()

    file(GLOB DEBUG_FILES "${CURRENT_PACKAGES_DIR}/debug/lib/*")

    if(NOT DEBUG_FILES)
        file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/lib)
    endif()

    message(STATUS "* Moving release and debug dlls into the correct directory...")

    if(EXISTS ${CURRENT_PACKAGES_DIR}/tools/qt5)
        file(RENAME ${CURRENT_PACKAGES_DIR}/tools/qt5 ${CURRENT_PACKAGES_DIR}/tools/${PORT})    
    endif()

    if(EXISTS ${CURRENT_PACKAGES_DIR}/debug/tools/qt5)
        file(RENAME ${CURRENT_PACKAGES_DIR}/debug/tools/qt5 ${CURRENT_PACKAGES_DIR}/debug/tools/${PORT})
    endif()

    file(GLOB RELEASE_DLLS ${CURRENT_PACKAGES_DIR}/tools/${PORT}/*.dll)
    file(GLOB DEBUG_DLLS ${CURRENT_PACKAGES_DIR}/debug/tools/${PORT}/*.dll)

    if (RELEASE_DLLS)
        file(INSTALL ${RELEASE_DLLS} DESTINATION ${CURRENT_PACKAGES_DIR}/bin)
        file(REMOVE ${RELEASE_DLLS})
        #Check if there are any binaries left over; if not - delete the directory
        file(GLOB RELEASE_BINS ${CURRENT_PACKAGES_DIR}/tools/${PORT}/*)
        if(NOT RELEASE_BINS)
            file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/tools)
        endif()
    endif()

    if(DEBUG_DLLS)
        file(INSTALL ${DEBUG_DLLS} DESTINATION ${CURRENT_PACKAGES_DIR}/debug/bin)
        file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/tools)
    endif()

    if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "debug")
        file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/share/qt5/debug/include)
    endif()

    if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "release")
        vcpkg_copy_tool_dependencies(${CURRENT_PACKAGES_DIR}/tools/${PORT})
    endif()

    message(STATUS "* Finding the relevant license file and installing it...")

    if(EXISTS "${SOURCE_PATH}/LICENSE.LGPLv3")
        set(LICENSE_PATH "${SOURCE_PATH}/LICENSE.LGPLv3")
    elseif(EXISTS "${SOURCE_PATH}/LICENSE.LGPL3")
        set(LICENSE_PATH "${SOURCE_PATH}/LICENSE.LGPL3")
    elseif(EXISTS "${SOURCE_PATH}/LICENSE.GPLv3")
        set(LICENSE_PATH "${SOURCE_PATH}/LICENSE.GPLv3")
    elseif(EXISTS "${SOURCE_PATH}/LICENSE.GPL3")
        set(LICENSE_PATH "${SOURCE_PATH}/LICENSE.GPL3")
    elseif(EXISTS "${SOURCE_PATH}/LICENSE.GPL3-EXCEPT")
        set(LICENSE_PATH "${SOURCE_PATH}/LICENSE.GPL3-EXCEPT")
    endif()
    file(INSTALL ${LICENSE_PATH} DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
endfunction()

    ### ------------------------------------------------------

function(qt_webengine_library NAME HASH)
    qt_webengine_fetch_library(${NAME} ${HASH} TARGET_SOURCE_PATH)
    qt_webengine_build_library(${TARGET_SOURCE_PATH})
endfunction()

    ### ------------------------------------------------------

## The QtWebEngine version must match the Qt base version, point releases are confusingly rendered incompatible due to version number dependencies..
## This makes mixing point releases impossible.. We also don't use the archives in this file currently. So the hashes below are meaningless...
## - Qt 5.12.4 :
#qt_webengine_library(qtwebengine 312c584222ed5e7183af2be8a4f42b84c7fed18c3d4b080bc32bed1bd5c7dc88c9752deaf7afc1b4d9fcd02c8c8a013d32d5be2e7635fec2c085cdbe81998de8)
## - Qt 5.12.3 :
qt_webengine_library(qtwebengine 5b500ec6653aa6ed70e7826fe394f95c7932eaea5b1b48f6342a6f18294f75e4f954959fa2f42de0685097679389245d2bc80454e8eea202fa18a326d6d5a9a5)
