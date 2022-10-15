/*
Author: Håkon
Description:
    Toggles the access to garage vehicle categories of a garage access point; Air, Boats, and Armor

Arguments:
    0. <Object> The garage access point
    1. <Bool> Allow access to air vehicles
    2. <Bool> Allow access to naval vehicles
    3. <Bool> Allow access to armor vehicles

Return Value:
    <Bool> True

Scope: Any
Environment: Any
Public: Yes
Dependencies:

Example:

License: MIT License
*/
#include "..\script_component.hpp"

params [
    ["_ap", objNull, [objNull]]
    , ["_allowAir", true, [true]]
    , ["_allowNaval", true, [true]]
    , ["_allowArmor", true, [true]]
];

if (isNull _ap) exitWith { false };
if !(_ap in HR_Garage_accessPoints) exitWith { false };
private _args = _ap getVariable [QGVAR(ModuleArguments), createHashMap];
_args set ["accessAir", _allowAir];
_args set ["accessNaval", _allowNaval];
_args set ["accessArmor", _allowArmor];
_ap setVariable [QGVAR(ModuleArguments),_args, true];

true;
