include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO catchorg/Catch2
<<<<<<< HEAD
    REF v2.7.2
    SHA512 ac58cb3b676c73a361a494492e7b1f1b85cba7d08feb2d09b2269109a89b66aa37efead6b0a9fca64678f42a3395a3b02b6d461b4cb35310451ce849a79d04ae
=======
    REF v2.7.1
    SHA512 1566f63122984a8f29645db8e76028ba2559bb4b812f1e15081f79725530effe2ff432b6f61f404dc2b386829004d126b9511053d25a811c017f3102a01608a1
>>>>>>> [many ports] Updates 2019.04.19 (#6155)
    HEAD_REF master
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DBUILD_TESTING=OFF
        -DCATCH_BUILD_EXAMPLES=OFF
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/Catch2 TARGET_PATH share/catch2)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug ${CURRENT_PACKAGES_DIR}/lib)

if(NOT EXISTS ${CURRENT_PACKAGES_DIR}/include/catch2/catch.hpp)
    message(FATAL_ERROR "Main includes have moved. Please update the forwarder.")
endif()

file(WRITE ${CURRENT_PACKAGES_DIR}/include/catch.hpp "#include <catch2/catch.hpp>")
file(INSTALL ${SOURCE_PATH}/LICENSE.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/catch2 RENAME copyright)
