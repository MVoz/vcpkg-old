#ifndef _GDKMM_CONFIG_H
#define _GDKMM_CONFIG_H

#include <pangommconfig.h>

/* Define to omit deprecated API from gdkmm. */
#cmakedefine GDKMM_DISABLE_DEPRECATED

/* Major version number of gdkmm. */
#define GDKMM_MAJOR_VERSION @GDKMM_VERSION_MAJOR@

/* Micro version number of gdkmm. */
#define GDKMM_MICRO_VERSION @GDKMM_VERSION_MICRO@

/* Minor version number of gdkmm. */
#define GDKMM_MINOR_VERSION @GDKMM_VERSION_MINOR@

#endif /* !_GDKMM_CONFIG_H */
