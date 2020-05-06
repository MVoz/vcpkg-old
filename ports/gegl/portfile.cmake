include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
#    URLS "https://github.com/GNOME/gegl/archive/bffe61914552931381432e123f72d481c53044c0.zip"
	URLS "https://gitlab.gnome.org/GNOME/gegl/-/archive/wip/nielsdg/meson/gegl-wip-nielsdg-meson.tar.gz"
    FILENAME "gegl.zip"
    SHA512 8aee8bcd5708f98e05a585be9c8e0929ce86f0d99071205f47b434ebcad69012b1ebd191d87bb3471ef8070f0f9a4f63b70673cc2d11a8cd77eb3d74623e9e9d
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

#vcpkg_find_acquire_program(PYTHON3)
vcpkg_find_acquire_program(RUBY)
#vcpkg_find_acquire_program(TEXLIVE)
#vcpkg_find_acquire_program(XGETTEXT)
#vcpkg_find_acquire_program(DOXYGEN)
#vcpkg_find_acquire_program(DOXYGEN)
vcpkg_find_acquire_program(PERL)
#vcpkg_find_acquire_program(FLEX)
#vcpkg_find_acquire_program(BISON)
#get_filename_component(FLEX_DIR "${FLEX}" DIRECTORY)
#get_filename_component(BISON_DIR "${BISON}" DIRECTORY)
#get_filename_component(DOXYGEN_DIR "${DOXYGEN}" DIRECTORY)
get_filename_component(PERL_DIR "${PERL}" DIRECTORY)
get_filename_component(RUBY_DIR "${RUBY}" DIRECTORY)
#get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
#get_filename_component(DOXYGEN_DIR "${DOXYGEN}" DIRECTORY)
#get_filename_component(XGETTEXT_DIR "${XGETTEXT}" DIRECTORY)
#get_filename_component(TEXLIVE_DIR "${TEXLIVE}" DIRECTORY)
#set(ENV{PATH} ";$ENV{PATH};${QT5_DIR};${PYTHON3_DIR};${DOXYGEN_DIR};${XGETTEXT_DIR};${TEXLIVE_DIR};${FLEX_DIR};${BISON_DIR};${DOXYGEN_DIR};${PERL_DIR}")
#vcpkg_find_acquire_program(YASM)
#get_filename_component(YASM_EXE_PATH ${YASM} DIRECTORY)
set(ENV{PATH} "$ENV{PATH};${PERL_DIR};${RUBY_DIR}")

# https://mesonbuild.com/Configuring-a-build-directory.html
vcpkg_configure_meson(
	SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
#	OPTIONS_RELEASE
#	OPTIONS_DEBUG
		--backend=ninja
		-Dgexiv2=false
		-Dlensfun=false
		-Dlibrsvg=false
		-Dlibv4l2=false
		-Dspiro=false
		-Dopenexr=false
		-Dsdl=false
		-Dlibraw=false
#		-Dlibraw=false
)

vcpkg_install_meson()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/COPYING ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###