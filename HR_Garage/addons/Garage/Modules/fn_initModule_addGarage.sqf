#include "..\script_component.hpp"
params ["_module", "_accessObjects"];

//add vehicle if zues vehicle
private _attached = _module getvariable ["bis_fnc_curatorAttachObject_object",objnull];
if (!isNull _attached) then { _accessObjects pushBackUnique _attached };

//transfere arguments to object
private _moduleArguments = createHashMap;
_moduleArguments set ["accessAir", _module getVariable ["accessAir", true]];
_moduleArguments set ["accessArmor", _module getVariable ["accessArmor", true]];
_moduleArguments set ["accessNaval", _module getVariable ["accessNaval", true]];
deleteVehicle _module;

if (!isMultiplayer) exitWith {
    ["STR_HR_Garage_Modules_notMultiplayer"] call HR_Garage_fnc_Hint;
    Error("HR Garage is only available in multiplayer");
};

{
    [_x] remoteExecCall ["HR_Garage_fnc_initGarage", 0, _x];
    _x setVariable [QGVAR(ModuleArguments),_moduleArguments, true];
} forEach _accessObjects;
