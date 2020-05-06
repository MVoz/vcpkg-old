include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://download.gnome.org/sources/libgee/0.20/libgee-0.20.1.tar.xz"
#    URLS "https://gitlab.gnome.org/GNOME/libgee/-/archive/wip/tintou/meson/libgee-wip-tintou-meson.tar.gz"
#    FILENAME "libgee-wip-tintou-meson.tar.gz"
    FILENAME "libgee-0.20.1.tar.xz"
    SHA512 b991acfea965e0afa007adac0df1763c3b97b31bf2832c0408128d02f4bb237a03c583b4dd107de1ed877ef042614352c845b6ba5f8b6fb535f43e2400746d7f
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)


#  --vapidir=DIRECTORY...             Look for package bindings in DIRECTORY
#  --girdir=DIRECTORY...              Look for .gir files in DIRECTORY
#  --metadatadir=DIRECTORY...         Look for GIR .metadata files in DIRECTORY
#  -d, --directory=DIRECTORY          Change output directory from current working directory
#  --includedir=DIRECTORY             Directory used to include the C header file
#  --cc=COMMAND                       Use COMMAND as C compiler command
#  -X, --Xcc=OPTION...                Pass OPTION to the C compiler
#  --gresourcesdir=DIRECTORY...       Look for resources in DIRECTORY
#--library=${CURRENT_INSTALLED_DIR}/lib

vcpkg_find_acquire_program(VALAC)
get_filename_component(VALAC_DIR "${VALAC}" DIRECTORY)
set(ENV{PATH} "$ENV{PATH};${VALAC_DIR}")

#set(VAPIGENFLAGS --vapidir=${VALAC_DIR}/../z_vala-0.20/vapi,${SOURCE_PATH}/vapi)
set(VAPIGENFLAGS "--vapidir=${SOURCE_PATH}/vapi ${VAPIGENFLAGS}")
set(ENV{VAPIGENFLAGS} ${VAPIGENFLAGS})

#set(VALAFLAGS --vapidir=${VALAC_DIR}/../z_vala-0.20/vapi,${SOURCE_PATH}/vapi --disable-warnings --cc=cl -X ${CFLAG})
set(VALAFLAGS "--vapidir=${VALAC_DIR}/../z_vala-0.20/vapi --disable-warnings --enable-experimental --cc=cl --includedir=${CURRENT_INSTALLED_DIR}/include --basedir=${SOURCE_PATH} --verbose ${VALAFLAGS}")
set(ENV{VALAFLAGS} ${VALAFLAGS})

set(DATAROOTDIR ${VALAC_DIR}/../z_vala-0.20)
set(ENV{DATAROOTDIR} ${DATAROOTDIR})

find_package(Vala REQUIRED)

vcpkg_configure_meson(
	SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
#	OPTIONS_RELEASE
#	OPTIONS_DEBUG
		--backend=ninja
#		-Dsubproject:option=_build
		-Ddocumentation=false #, description : 'Documentation generation')
		-Dinternal-asserts=true #, description : 'Use internal asserts')
		-Dconsistency-check=false #, description : 'Do some (very) expensive consistency checks: It might affect the asymptotic performance')	
)

vcpkg_install_meson()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
