include(vcpkg_common_functions)

set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/async_tcp)

vcpkg_from_github(
	OUT_SOURCE_PATH SOURCE_PATH
	REPO xrootpi/async_tcp
	REF v0.0.5
	SHA512 cf9f8bc58c4181bcafbcd26cd9aafb14cc9f79858f734dbd3a836bd46683e65827c34fb10f2be1fc1c30d4544f872f4bc816e3eb7f5e0d641b481ba5070cb644
    )

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
	PREFER_NINJA
)

file(INSTALL ${SOURCE_PATH}/include/async_tcp/ DESTINATION ${CURRENT_PACKAGES_DIR}/include/async_tcp)

file(INSTALL ${SOURCE_PATH}/license.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/async-tcp RENAME copyright)

vcpkg_install_cmake()
