#define MAINPREFIX x
#ifndef PREFIX
    #define PREFIX HR_GRG
#endif

#include "common.inc"

#include "script_version.hpp"
#define VERSION MAJOR.MINOR.PATCHLVL.BUILD
#define VERSION_AR MAJOR,MINOR,PATCHLVL,BUILD

#define REQUIRED_VERSION 2.02

#ifdef COMPONENT_BEAUTIFIED
    #define COMPONENT_NAME QUOTE(HR Garage - COMPONENT_BEAUTIFIED)
#else
    #define COMPONENT_NAME QUOTE(HR Garage - COMPONENT)
#endif

#ifndef AUTHOR
    #define AUTHOR "Håkon Rydland"
#endif
#ifndef AUTHORS
    #define AUTHORS "Håkon Rydland"
#endif

#include "script_macros.hpp"
