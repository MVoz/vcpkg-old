_find_package(${ARGS})

if("@VCPKG_LIBRARY_LINKAGE@" STREQUAL "static")
    find_package(iconv CONFIG REQUIRED)
    find_package(gettext CONFIG REQUIRED)
    if(TARGET exiv2lib)
        set_property(TARGET exiv2lib APPEND PROPERTY INTERFACE_LINK_LIBRARIES 
            iconv::libiconv 
            gettext::libintl)
    endif()
endif()
