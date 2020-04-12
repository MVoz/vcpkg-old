include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO mlpack/ensmallen
<<<<<<< HEAD
    REF ensmallen-1.14.3
    SHA512 138713849e9cd55517893c9b0c21afa751bff157c968fbdfa0fbefd10439006c27af023c13f5ffbc349b417b6539ce5fa67652f0a15d53f8204511f1c0d81adb
=======
    REF ensmallen-1.14.2
    SHA512 8aa8d00d80579c619e417d8fbc17c78c867f916161e3c412c3af24c1b7b9816c9e6faee981931e1591a45db0c797a081d45f1dfc3ea396a610ee2da55232b265
>>>>>>>  [ensmallen] Updated to version 1.14.2  (#6242)
    HEAD_REF master
	PATCHES
		disable_tests.patch
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
)
vcpkg_install_cmake()

file(INSTALL ${SOURCE_PATH}/COPYRIGHT.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/ensmallen RENAME copyright)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug)
