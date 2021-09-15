#include "..\script_component.hpp"
params ["_module", "_accessObjects"];

private _attached = _module getvariable ["bis_fnc_curatorAttachObject_object",objnull];
if (!isNull _attached) then { _accessObjects pushBackUnique _attached };
deleteVehicle _module;

if (!isMultiplayer) exitWith {
    ["STR_HR_Garage_Modules_notMultiplayer"] call HR_Garage_fnc_Hint;
    Error("HR Garage is only available in multiplayer");
};

{
    [_x] remoteExecCall ["HR_Garage_fnc_initGarage", 0, _x];
} forEach _accessObjects;
