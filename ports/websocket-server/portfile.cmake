include(vcpkg_common_functions)

set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/websocket_server)

vcpkg_from_github(
	OUT_SOURCE_PATH SOURCE_PATH
	REPO xrootpi/websocket_server
	REF v0.0.6
	SHA512 3120f70ef9271d4a84d89d4c6780af54886bef8ea2be08148bd2e686a9a1127fef96ca43e22bf58fe52c2fb1eefa8ce7e40d6806a8eb92d2b8e7a62f5a2f2e8d
    )

vcpkg_configure_cmake( 
    SOURCE_PATH ${SOURCE_PATH}
	PREFER_NINJA
)

file(INSTALL ${SOURCE_PATH}/include/websocket_server/ DESTINATION ${CURRENT_PACKAGES_DIR}/include/websocket_server)

file(INSTALL ${SOURCE_PATH}/license.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/websocket-server RENAME copyright)

vcpkg_install_cmake()
