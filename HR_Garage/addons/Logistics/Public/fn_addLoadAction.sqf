/*
    Author: [Håkon]
    [Description]
        adds logistics load action to objects

    Arguments:
    0. <Object> Cargo that you want to be able to load in a vehicle
    1. <String> "load" or "unload" action (optional - should not really be used)

    Return Value:
    <Nil>

    Scope: Any
    Environment: Any
    Public: [Yes]
    Dependencies:

    Example: [_object] call HR_logistics_fnc_addLoadAction;
*/
#include "..\script_component.hpp"
FIX_LINE_NUMBERS()
params [["_object", objNull, [objNull]], ["_action", "load"]];

if (isNull _object) exitWith {
    Error("No object passed, aborting");
    nil
};

if (!alive _object) exitWith {
    Error("Destroyed object passed, aborting");
    nil
};

if (([_object] call HR_logistics_fnc_getCargoNodeType) isEqualTo -1) exitWith {nil};

if (isNil "HR_logistics_vehicleHardpoints") exitWith {
    Error("Logistics nodes not initialized, aborting");
    nil
};

private _nonSupportedStatic = false;
if (_object isKindOf "StaticWeapon") then {
    private _model = getText (configFile >> "CfgVehicles" >> typeOf _object >> "model");
    if (HR_logistics_weapons findIf {(_x#0) isEqualTo _model} isEqualTo -1) then {_nonSupportedStatic = true};
};
if (_nonSupportedStatic) exitWith {nil};

[_object , _action] remoteExec ["HR_logistics_fnc_addAction", 0, _object];
nil
