params [["_object", objNull, [objNull]]];
if (!alive _object) exitWith {};

if (([typeOf _object] call HR_GRG_fnc_getCatIndex) isEqualTo -1) exitWith {};
private _jipKey = "HR_GRG_addVehicleAction_" + (((str _object) splitString ':') joinString '');
[_object, _jipKey] remoteExecCall ["HR_GRG_fnc_addVehicleAction", 0, _jipKey];
