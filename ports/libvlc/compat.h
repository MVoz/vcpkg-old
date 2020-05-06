#pragma once

/*
VS2015 cannot fathom static inline functions
    http://stackoverflow.com/questions/32851292/vs2015-cannot-fathom-static-inline-functions

IntelliSense does not accept "inline" C99 functions
    https://connect.microsoft.com/VisualStudio/feedback/details/1368125/intellisense-does-not-accept-inline-c99-functions
*/
#if defined _MSC_VER && !defined __cplusplus
    #define inline __inline
#endif

//
// If using Visual C++ compiler, remap function names.
//
#ifdef _MSC_VER
    // Global function definitions
    #define strcasecmp		stricmp
    #define strncasecmp		strnicmp
    #define snprintf		_snprintf
    #define snwprintf		_snwprintf
#endif

