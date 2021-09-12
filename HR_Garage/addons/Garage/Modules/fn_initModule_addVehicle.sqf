#include "..\script_component.hpp"
params ["_module", "_accessObjects"];

if (!local _module) exitWith {};

private _attached = _module getvariable ["bis_fnc_curatorAttachObject_object",objnull];
if (!isNull _attached) then { _accessObjects pushBackUnique _attached };
deleteVehicle _module;

{
    if (isServer) then {
        [_x, clientOwner] call HR_GRG_fnc_addVehicle;
    } else {
        [_x, clientOwner] remoteExecCall ["HR_GRG_fnc_addVehicle",2];
    };
} forEach _accessObjects;
