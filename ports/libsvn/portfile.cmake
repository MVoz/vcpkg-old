include(vcpkg_common_functions)

if(VCPKG_CMAKE_SYSTEM_NAME STREQUAL "WindowsStore")
    message(FATAL_ERROR "${PORT} does not currently support UWP")
endif()

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/apache/subversion/archive/770a9b24be522008d74574cbe15b0c6bc3707105.zip"
    FILENAME "770a9b24be522008d74574cbe15b0c6bc3707105.zip"
    SHA512 32d04ad6a461e2c1c1cfbbaa701447b24224df69fb3ec3975509984b3850ea8e68451b8fcbc15affe3fb1138b3ee6e6a3b0ab7c19cf75e4b2aa03bf6defd1acf
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE} 
)

vcpkg_find_acquire_program(PYTHON2)
#vcpkg_find_acquire_program(SWIG)
#vcpkg_find_acquire_program(PERL)
#vcpkg_find_acquire_program(RUBY)
get_filename_component(PYTHON2_DIR ${PYTHON2} DIRECTORY)
vcpkg_add_to_path(${PYTHON2_DIR})
#vcpkg_find_acquire_program(SWIG_DIR ${SWIG} DIRECTORY)
#vcpkg_add_to_path(${PYTHON2_DIR};${SWIG_DIR})
#set(ENV{PATH} "$ENV{PATH};${PYTHON2_DIR}")
#set(ENV{PATH} "$ENV{PATH}:${PYTHON2_EXE_PATH}")
#set(ENV{PATH} "$ENV{PATH}:${TOOLS_PATH}/bin")





# find_package(PythonInterp)

#if(NOT PYTHON_EXECUTABLE)
#  message(FATAL_ERROR "PYTHON_EXECUTABLE must be set")
#endif()

#vcpkg_configure_cmake(
#  SOURCE_PATH ${SOURCE_PATH}
#  OPTIONS -DPYTHON_EXECUTABLE=${PYTHON3}
#  OPTIONS_DEBUG -DDISABLE_INSTALL_HEADERS=ON
#)
#execute_process(
#  COMMAND ${PYTHON_EXECUTABLE} ${FSM_GENERATOR} ${HTMLPARSER_CONFIG}
#  WORKING_DIRECTORY ${COMMON_INCLUDES}/htmlparser
#  OUTPUT_VARIABLE  HTMLPARSER_CONFIG_H
#)

# KDE 5 Framework libraries or KDELibs 4  (Unix only, OPTIONAL)
#
# --with-kwallet=/path/to/KDE/prefix
# --with-gnome-keyring
# --with-ctypesgen=/path/to/ctypesgen.py
# --with-libmagic=/path/to/libmagic/prefix ## include/magic.h and lib/libmagic.so.1.0
# build mod_dav_svn, omit the --with-httpd
# --with-lz4=/path/to/liblz4 or --with-lz4=internal

#E:\Anaconda2\python gen-make.py --vsnet-version=2017 --with-apr=E:/tools/vcpkg/installed/x64-windows-static --with-apr-util=E:/tools/vcpkg/installed/x64-windows-static --with-zlib=E:/tools/vcpkg/installed/x64-windows-static --with-sqlite=E:/tools/vcpkg/installed/x64-windows-static


vcpkg_execute_required_process(
	COMMAND ${PYTHON2} gen-make.py
		--vsnet-version=2015
		--with-apr=${CURRENT_INSTALLED_DIR}
		--with-apr-util=${CURRENT_INSTALLED_DIR}
		--with-zlib=${CURRENT_INSTALLED_DIR}
		--with-sqlite=${CURRENT_INSTALLED_DIR}
		--with-openssl=${CURRENT_INSTALLED_DIR}
#		--with-berkeley-db=${CURRENT_INSTALLED_DIR}
#		--with-serf=${CURRENT_INSTALLED_DIR}
#		--with-apr-iconv=${CURRENT_INSTALLED_DIR}
		--with-libintl=${CURRENT_INSTALLED_DIR}
		--disable-shared
		--with-static-apr
		--with-static-openssl
		
	WORKING_DIRECTORY ${SOURCE_PATH}
	LOGNAME build-genmake
)

# msbuild.exe subversion_vcnet.sln /t:__MORE__ /p:Configuration=Release

vcpkg_install_msbuild(
    SOURCE_PATH ${SOURCE_PATH}
    PROJECT_SUBPATH subversion_vcnet.sln
	TARGET
		__LIBS__

#		/t:__LIBS__.vcxproj
#	OPTIONS
#		CustomBuildAfterTargets and CustomBuildBeforeTargets ## <-- CustomBuildStep
#		/p:PostBuildEventUseInBuild=false
#		/p:PreBuildEventUseInBuild=false  # error build ## Custom Clean Step ### del and rd
#		/p:CustomBuildAfterTargets=false  # error build ## Custom Clean Step ### del and rd
#		/p:OutDir=${CURRENT_BUILDTREES_DIR}/../../msvc/
#	OPTIONS_RELEASE
#		/p:OutDir=${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/msvc/
#	OPTIONS_DEBUG
#		/p:OutDir=${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/msvc/
	SKIP_CLEAN
	LICENSE_SUBPATH LICENSE
	ALLOW_ROOT_INCLUDES ON
	USE_VCPKG_INTEGRATION
)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME libsvn)


#USAGE:  gen-make.py [options...] [conf-file]
#  -s        skip dependency generation
#  --debug   print lots of stuff only developers care about
#  --release release mode
#  --reload  reuse all options from the previous invocation
#            of the script, except -s, -t, --debug and --reload
#  -t TYPE   use the TYPE generator; can be one of:
#            make          Makefiles for POSIX systems
#            vcproj        VC.Net project files
#            The default generator type is 'make'
#
#  Makefile-specific options:
#  --assume-shared-libs
#           omit dependencies on libraries, on the assumption that
#           shared libraries will be built, so that it is unnecessary
#           to relink executables when the libraries that they depend
#           on change.  This is an option for developers who want to
#           increase the speed of frequent rebuilds.
#           *** Do not use unless you understand the consequences. ***
#
#  UNIX-specific options:
#  --installed-libs
#           Comma-separated list of Subversion libraries to find
#           pre-installed instead of building (probably only
#           useful for packagers)
#
#  Windows-specific options:
#  --with-apr=DIR
#           the APR sources are in DIR
#  --with-apr-util=DIR
#           the APR-Util sources are in DIR
#  --with-apr-iconv=DIR
#           the APR-Iconv sources are in DIR
#  --with-berkeley-db=DIR
#           look for Berkeley DB headers and libs in
#           DIR
#  --with-serf=DIR
#           the Serf sources are in DIR
#  --with-httpd=DIR
#           the httpd sources and binaries required
#           for building mod_dav_svn are in DIR;
#           implies --with-apr{-util, -iconv}, but
#           you can override them
#  --with-libintl=DIR
#           look for GNU libintl headers and libs in DIR;
#           implies --enable-nls
#  --with-openssl=DIR
#           tell serf to look for OpenSSL headers
#           and libs in DIR
#  --with-zlib=DIR
#           tell Subversion to look for ZLib headers and
#           libs in DIR
#  --with-jdk=DIR
#           look for the java development kit here
#  --with-junit=DIR
#           look for the junit jar here
#           junit is for testing the java bindings
#  --with-swig=DIR
#           look for the swig program in DIR
#  --with-sqlite=DIR
#           look for sqlite in DIR
#  --with-sasl=DIR
#           look for the sasl headers and libs in DIR
#  --enable-pool-debug
#           turn on APR pool debugging
#  --enable-purify
#           add support for Purify instrumentation;
#           implies --enable-pool-debug
#  --enable-quantify
#           add support for Quantify instrumentation
#  --enable-nls
#           add support for gettext localization
#  --disable-shared
#           only build static libraries
#  --with-static-apr
#           Use static apr and apr-util
#  --with-static-openssl
#           Use static openssl
#  --vsnet-version=VER
#           generate for VS.NET version VER (2005-2017 or 9.0-15.0)
#           [implies '-t vcproj']
# -D NAME[=value]
#           define NAME macro during compilation
#           [only valid in combination with '-t vcproj']
#  --with-apr_memcache=DIR
#           the apr_memcache sources are in DIR
