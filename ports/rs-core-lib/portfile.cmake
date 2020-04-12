include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO CaptainCrowbar/rs-core-lib
<<<<<<< HEAD
    REF 4828e0dc8b7e7ed76935865cfe99181da0da211b
    SHA512 97298d94c1cc4cd4cb580bde6c1413a2f429544dc80cae58bc436aad25e385d9ced611a2512a45f1e3d10fd613f26958fc5d3a03ea9bfaefd5170a4b2d1ac124
=======
    REF 65235aec3b72ac622d1c9cf146dbf78aa3dfab0d
    SHA512 6cae59bf4d254a4fe968d51ecab2910a7fedabed0eaaa549bc05df4b2960cbe1c7206e1408b3c7afeee3c9aa3ef1883f3cdc15dde35a3c39e50ba99a0115dc5e
>>>>>>> [many ports] Updates 2019.04.19 (#6155)
    HEAD_REF master
)

file(INSTALL ${SOURCE_PATH}/rs-core DESTINATION ${CURRENT_PACKAGES_DIR}/include FILES_MATCHING PATTERN "*.hpp")

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE.TXT DESTINATION ${CURRENT_PACKAGES_DIR}/share/rs-core-lib RENAME copyright)