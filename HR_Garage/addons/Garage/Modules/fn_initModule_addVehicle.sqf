#include "..\script_component.hpp"
params ["_module", "_accessObjects"];

if (!local _module) exitWith {};

private _attached = _module getvariable ["bis_fnc_curatorAttachObject_object",objnull];
if (!isNull _attached) then { _accessObjects pushBackUnique _attached };
deleteVehicle _module;

if (!isMultiplayer) exitWith {
    ["STR_HR_Garage_Modules_notMultiplayer"] call HR_Garage_fnc_Hint;
    Error("HR Garage is only available in multiplayer");
};
{
    if (isServer) then {
        [_x, clientOwner] call HR_Garage_fnc_addVehicle; //will always use this one
        hintSilent "";
    } else {
        [_x, clientOwner] remoteExecCall ["HR_Garage_fnc_addVehicle",2];
    };
} forEach _accessObjects;
