_find_package(${ARGS})

<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> revert tiff changes
find_package(LibLZMA)
find_package(JPEG)
find_package(ZLIB)

<<<<<<< HEAD
if(TARGET TIFF::TIFF)
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
  set_property(TARGET TIFF::TIFF APPEND PROPERTY INTERFACE_LINK_LIBRARIES ${LIBLZMA_LIBRARIES} JPEG::JPEG ZLIB::ZLIB) # Should be fixed upstream
=======
  target_link_libraries(TIFF::TIFF INTERFACE ${LIBLZMA_LIBRARIES} JPEG::JPEG ZLIB::ZLIB) # Should be fixed upstream
>>>>>>> fix tiff regression. -> please report this upstream
=======
  set(_tiff_lzma_libs "${LIBLZMA_LIBRARIES}")
  list(TRANSFORM _tiff_lzma_libs REPLACE "debug;(.)+;optimized;(.)+" "$<$<CONFIG:DEBUG>:\\1;$<NOT $<CONFIG:DEBUG>:\\2")
  message(STATUS "TIFF target used; Changing LZMA variable from: ${LIBLZMA_LIBRARIES})
  message(STATUS "TIFF target used; Changing LZMA variable to: ${_tiff_lzma_libs})
  #target_link_libraries does not work here because the target is not build by the project
  #must set properties by hand using generator expressions (optimized/debug not supported here).
  #Correct way would be to fix the TIFF target to link correctly to the required libraries. 
  set_property(TIFF::TIFF APPEND PROPERTY INTERFACE_LINK_LIBRARIES ${_tiff_lzma_libs} JPEG::JPEG ZLIB::ZLIB) # Should be fixed upstream
>>>>>>> chenged tiff cmake wrapper to correctly handle debug/optimized keywords
=======
  target_link_libraries(TIFF::TIFF INTERFACE ${LIBLZMA_LIBRARIES} JPEG::JPEG ZLIB::ZLIB) # Should be fixed upstream
>>>>>>> Revert "chenged tiff cmake wrapper to correctly handle debug/optimized keywords"
=======
  set_property(TARGET TIFF::TIFF APPEND PROPERTY INTERFACE_LINK_LIBRARIES ${LIBLZMA_LIBRARIES} JPEG::JPEG ZLIB::ZLIB) # Should be fixed upstream
>>>>>>> revert tiff changes
=======
if(NOT LIBLZMA_FOUND)
    find_package(LibLZMA)
endif()
if(NOT JPEG_FOUND)
    find_package(JPEG)
endif()
if(NOT ZLIB_FOUND)
    find_package(ZLIB)
endif()
if(TARGET TIFF::TIFF)
  set_property(TARGET TIFF::TIFF APPEND PROPERTY INTERFACE_LINK_LIBRARIES "${LIBLZMA_LIBRARIES}" JPEG::JPEG ZLIB::ZLIB) # Should be fixed upstream
>>>>>>> fix tiff again
=======
if(TARGET TIFF::TIFF)
  set_property(TARGET TIFF::TIFF APPEND PROPERTY INTERFACE_LINK_LIBRARIES ${LIBLZMA_LIBRARIES} JPEG::JPEG ZLIB::ZLIB) # Should be fixed upstream
>>>>>>> revert tiff changes
  if(UNIX)
    set_property(TARGET TIFF::TIFF APPEND PROPERTY INTERFACE_LINK_LIBRARIES m)
  endif()
endif()
if(TIFF_LIBRARIES)
  list(APPEND TIFF_LIBRARIES ${LIBLZMA_LIBRARIES} ${JPEG_LIBRARIES} ${ZLIB_LIBRARIES})
  if(UNIX)
    list(APPEND TIFF_LIBRARIES m)
  endif()
endif()
