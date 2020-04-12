include(vcpkg_common_functions)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/ebassi/graphene/archive/29eb2a49c11a6ae825dc2f54565331e5dac403e2.zip"
    FILENAME "graphene.zip"
    SHA512 b97f6d4e556bf515bc30821097d9919fbeae006d7b98ce5892b6248fc7b341de61a39a3341c3147a84983b2a097890a9dc29b58ea0b7d664b23b8b781aafd24c
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

### https://mesonbuild.com/Configuring-a-build-directory.html
vcpkg_configure_meson(
	SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
		--backend=ninja
		-Dgtk_doc=false
#		-Dgobject_types=false
#		-Dintrospection=false
#		-Dgcc_vector=false
		-Dsse2=true
		-Darm_neon=false
		-Dtests=false
		-Dbenchmarks=false
		-Dinstalled_tests=false
)

vcpkg_install_meson()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled)
vcpkg_copy_pdbs()
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)

###
