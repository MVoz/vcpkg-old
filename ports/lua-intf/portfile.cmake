# Specify reference in GitHub
set(GITHUB_REF 0ff4fc9653c0b6d7cb238568f4abba4a026b13f2)

include(vcpkg_common_functions)

# Prepair sources
set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/lua-intf-${GITHUB_REF})
vcpkg_from_github(
    OUT_SOURCE_PATH ${SOURCE_PATH}
    REPO SteveKChiu/lua-intf
    REF ${GITHUB_REF}
    SHA512 cb1a0599e6122942cd979f0a010612707a707d56a771d5c89eb9ffc11560c91e49fd4939f91f047be2eae54f308387f95122d193d96d12451b0417dc38356963
    HEAD_REF master
)

# Copy libraries
file(GLOB INDLUDES ${SOURCE_PATH}/LuaIntf/*)
file(INSTALL ${INDLUDES} DESTINATION ${CURRENT_PACKAGES_DIR}/include)

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/lua-intf RENAME copyright)
