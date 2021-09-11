#include "\x\cba\addons\main\script_macros_common.hpp"
#include "\x\cba\addons\xeh\script_xeh.hpp"

#define DFUNC(fncName) TRIPLES(ADDON,fnc,fncName)
#define DEFUNC(comp,fncName) TRIPLES(DOUBLES(PREFIX,comp),fnc,fncName)

#undef QFUNC
#undef QEFUNC
#define QFUNC(fncName) QOUTE(DFUNC(fncName))
#define QEFUNC(comp,fncName) QOUTE(DEFUNC(comp,fncName))

#undef PREP
#define PREP(fncName) DFUNC(fncName) = compile preprocessFileLineNumbers QPATHTOF(functions\DOUBLES(fn,fncName).sqf)
#define PREPSUB(folder,fncName) DFUNC(fncName) = compile preprocessFileLineNumbers QPATHTOF(folder\DOUBLES(fn,fncName).sqf)
