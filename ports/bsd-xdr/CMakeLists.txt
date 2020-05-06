cmake_minimum_required(VERSION 2.8)
project(bsd-xdr C)

include_directories(${CMAKE_CURRENT_SOURCE_DIR})
add_library(bsd-xdr STATIC lib/xdr.c lib/xdr_array.c lib/xdr_float.c lib/xdr_mem.c lib/xdr_private.c lib/xdr_private.h lib/xdr_rec.c lib/xdr_reference.c lib/xdr_sizeof.c lib/xdr_stdio.c rpc/types.h rpc/xdr.h)

install(
    TARGETS ${PROJECT} 
    EXPORT ${PROJECT}-export
    RUNTIME DESTINATION ${BINARY_INSTALL_DIR}
    LIBRARY DESTINATION ${LIBRARY_INSTALL_DIR}
    ARCHIVE DESTINATION ${LIBRARY_INSTALL_DIR}
    BUNDLE DESTINATION .
##    FRAMEWORK DESTINATION ${FRAMEWORK_INSTALL_DIR}
##    PUBLIC_HEADER DESTINATION ${INCLUDE_INSTALL_DIR}/qjson${QJSON_SUFFIX}
)