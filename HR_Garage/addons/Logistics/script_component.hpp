#define COMPONENT Logistics
#include "..\Common\Includes\script_mod.hpp"

//get and format model path to class friendly name for lookup
#define modelOfClass(class) (((getText (configFile/"CfgVehicles"/class/"model")) splitString "\.") joinString "_")
