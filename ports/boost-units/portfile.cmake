# Automatically generated by boost-vcpkg-helpers/generate-ports.ps1

include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO boostorg/units
    REF boost-1.70.0
    SHA512 001bfe9ca2a6be94ec66c123ed983468cefebfebbee58f439bbb2a392fa152cb0818fc03a782bfd698693702df185242187d91ba6cbab8f742bb04d53cd1ca28
    HEAD_REF master
)

include(${CURRENT_INSTALLED_DIR}/share/boost-vcpkg-helpers/boost-modular-headers.cmake)
boost_modular_headers(SOURCE_PATH ${SOURCE_PATH})