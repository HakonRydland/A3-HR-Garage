/*
Author: Håkon
Description:
    Broadcast vehicle state update to garage users

Arguments:
0. <UID> The vehicles UID
1. <Struct> Fuel, Repair or Ammo state struct (see getState for more info)
2. <Int> The index of state preservation to update, in above order (optional: default - 0)

Return Value: <nil>

Scope: Server
Environment: unscheduled
Public: No
Dependencies:

Example:

License: APL-ND
*/
params ["_vUID", "_state", ["_stateIndex",0,[0]]];
if (isNil "_vUID" || isNil "_state") exitWith {false};

if (HR_Garage_Users isNotEqualTo []) then {
    private _recipiants = +HR_Garage_Users;
    _recipiants pushBackUnique 2;
    [_vUID, _stateIndex, _state] remoteExecCall ["HR_Garage_fnc_reciveStateUpdate", _recipiants];
    {_x publicVariableClient "HR_Garage_Sources"} forEach _recipiants;
};
