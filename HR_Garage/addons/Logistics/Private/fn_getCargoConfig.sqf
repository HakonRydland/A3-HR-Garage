#include "..\script_component.hpp"
params [["_class","",["",objNull]]];
if (_class isEqualType objNull) then {_class = typeOf _class};

#define cgVehicle (configFile/"CfgVehicles"/_class)
#define VehicleNodes (configFile/"CfgVehicles"/_class/ QDOUBLES(ADDON,Cargo))
#define CfgNodes configFile/QDOUBLES(ADDON,Cargo)
#define MissionNodes missionConfigFile/QDOUBLES(ADDON,Cargo)

if !(isClass cgVehicle) exitWith { configNull };
if (isClass (MissionNodes/_class)) exitWith { (MissionNodes/_class) };
if (isClass VehicleNodes) exitWith { VehicleNodes };
if (isClass (CfgNodes/_class)) exitWith { (CfgNodes/_class) };

private _model = modelOfClass(_class);
if (isClass (MissionNodes/_model)) exitWith { (MissionNodes/_model) };
if (isClass (CfgNodes/_model)) exitWith { (CfgNodes/_model) };
configNull;
