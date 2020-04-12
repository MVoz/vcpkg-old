#header-only library
include(vcpkg_common_functions)
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO nothings/stb
<<<<<<< HEAD
    REF 1034f5e5c4809ea0a7f4387e0cd37c5184de3cdd
    SHA512 efc3deedd687615a6706b0d315ded8d76edb28fcd6726531956fde9bba81cc62f25df0a1f998b56e16ab0c62989687c7d5b58875789470c2bf7fd457b1ff6535
=======
    REF 2c2908f50515dcd939f24be261c3ccbcd277bb49
    SHA512 d039346a4117f230eba344e8fd45b55290026c6611ef9aab1a6f504d7207ae724c978062e85613dda05f96d3e1eb8ee04c78a289c142cad34bc7ef24e2cf8689
>>>>>>> [many ports] Updates 2019.04.19 (#6155)
    HEAD_REF master
)

# Put the licence file where vcpkg expects it
file(COPY ${SOURCE_PATH}/README.md DESTINATION ${CURRENT_PACKAGES_DIR}/share/stb/README.md)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/stb/README.md ${CURRENT_PACKAGES_DIR}/share/stb/copyright)

# Copy the stb header files
file(GLOB HEADER_FILES ${SOURCE_PATH}/*.h)
file(COPY ${HEADER_FILES} DESTINATION ${CURRENT_PACKAGES_DIR}/include)
