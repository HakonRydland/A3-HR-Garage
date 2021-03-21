#include "CfgDefines.inc"
#include "LogMacros.inc"

//Line number fix
#define FIX_LINE_NUMBERS2(sharp) sharp##line __LINE__ __FILE__
#define FIX_LINE_NUMBERS() FIX_LINE_NUMBERS2(#)
