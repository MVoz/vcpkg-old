include(vcpkg_common_functions)



###

#vcpkg_build_msbuild(
#    PROJECT_PATH ${SOURCE_PATH}/ports/MSVC++/2015/win32/libmpg123/libmpg123.vcxproj
#    RELEASE_CONFIGURATION Release_x86${MPG123_CONFIGURATION_SUFFIX}
#    DEBUG_CONFIGURATION Debug_x86${MPG123_CONFIGURATION_SUFFIX}
#)


#vcpkg_from_bitbucket(
#set(OPENEXR_VERSION 2.3.0)
#set(OPENEXR_HASH 268ae64b40d21d662f405fba97c307dad1456b7d996a447aadafd41b640ca736d4851d9544b4741a94e7b7c335fe6e9d3b16180e710671abfc0c8b2740b147b2)
#vcpkg_from_github(
#  OUT_SOURCE_PATH SOURCE_PATH
#  REPO openexr/openexr
#  REF v${OPENEXR_VERSION}
#  SHA512 ${OPENEXR_HASH}
#  HEAD_REF master
#  PATCHES
#    fix_clang_not_setting_modern_cplusplus.patch
#    fix_install_ilmimf.patch
#)
vcpkg_download_distfile(ARCHIVE
    URLS "https://gitlab.gnome.org/GNOME/evince/-/archive/master/evince-master.tar.gz"
    FILENAME "evince-master.tar.gz"
    SHA512 75ac8626c48ecaec1a7760c6ab226dc844ac5aef130e137164edf1c5bae4ce95c6fbc67aba5a71874757868a2de47ff61223bad4687ff338b056cd8542581fc0
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
#    PATCHES
#        001_port_fixes.patch
#        002_more_port_fixes.patch
)

#vcpkg_find_acquire_program(YASM)
#get_filename_component(YASM_EXE_PATH ${YASM} DIRECTORY)
#set(ENV{PATH} "$ENV{PATH};${YASM_EXE_PATH}")

#file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH})

### https://mesonbuild.com/Configuring-a-build-directory.html
vcpkg_configure_meson(
	SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
		--backend=ninja
		
		-Dplatform=win32 # 'combo', choices: ['gnome', 'win32'], value: 'gnome', description: 'for which platform to build')
		-Dviewer=false # description: 'whether Viewer support is requested')
		-Dpreviewer=false # description: 'whether Previewer support is requested')
		-Dthumbnailer=false # description: 'whether Thumbnailer support is requested')
		-Dbrowser_plugin=false # description: 'whether Browser Plugin support is requested')
		-Dnautilus=false # description: 'whether Nautilus support is requested')

		-Dcomics=auto # description: 'whether Comics support is requested')
		-Ddjvu=auto # description: 'whether DJVU support is requested')
		-Ddvi=auto # description: 'whether DVI support is requested')
		-Dpdf=auto # description: 'whether PDF support is requested')
		-Dps=disabled # description: 'whether PS support is requested')
		-Dtiff=auto # description: 'whether TIFF support is requested')
		-Dxps=auto # description: 'whether XPS support is requested')

		-Dgtk_doc=false # description: 'whether GTK Doc reference is requested')
		-Dintrospection=false # description: 'whether introspection support is requested')
		-Ddbus=false # description: 'whether DBUS support is requested')
		-Dkeyring=auto # description: 'whether keyring support is requested')
		-Dgtk_unix_print=auto # description: 'whether gtk+-unix-print support is requested')
		-Dthumbnail_cache=auto # description: 'whether GNOME Desktop (Thumbnail cache) is requested')
		-Dmultimedia=auto # description: 'whether multimedia support is requested')
		-Dgspell=auto # description: 'whether gpsell support is requested')

		-Dt1lib=auto # description: 'whether support of t1lib for type1 fonts in dvi is requested')

#		-Dbrowser_plugin_dir=mozilla/plugins # description: 'custom directory for browser plugin')
		-Dsystemduserunitdir=disable # type: 'string', value: '', description: 'custom directory for systemd user units, or \'no\' to disable')
)

vcpkg_install_meson()


#file(COPY ${SOURCE_PATH}/greatest.h DESTINATION ${CURRENT_PACKAGES_DIR}/include)

#vcpkg_fixup_cmake_targets(CONFIG_PATH "lib/cmake/${PORT}")
#vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/nlohmann_json TARGET_PATH share/nlohmann_json)
#file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/bin)
#file(RENAME ${CURRENT_PACKAGES_DIR}/lib/${LIB_NAME}.dll ${CURRENT_PACKAGES_DIR}/bin/${LIB_NAME}.dll
#file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/evince RENAME copyright)



#file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/lib ${CURRENT_PACKAGES_DIR}/debug)
#file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin ${CURRENT_PACKAGES_DIR}/debug/bin ${CURRENT_PACKAGES_DIR}/debug/share ${CURRENT_PACKAGES_DIR}/debug/include)

#file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/tools)
#file(RENAME ${CURRENT_PACKAGES_DIR}/debug/bin ${CURRENT_PACKAGES_DIR}/tools/${PORT})

#vcpkg_copy_tool_dependencies(${CURRENT_PACKAGES_DIR}/tools/openexr)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME evince)

configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
set(VCPKG_POLICY_EMPTY_PACKAGE enabled)
vcpkg_copy_pdbs()

###
