#include "..\script_component.hpp"
params ["_module", "_accessObjects"];

private _attached = _module getvariable ["bis_fnc_curatorAttachObject_object",objnull];
if (!isNull _attached) then { _accessObjects pushBackUnique _attached };

{
    [_x] remoteExecCall ["HR_GRG_fnc_removeGarage", 0, _x];
} forEach _accessObjects;

deleteVehicle _module;
