/*
    Author: [Håkon]
    [Description]
        add user to recipient list of vehicle pool updates from the garage, also sends current garage pool to the user

    Arguments:
    0. <Int> clientID of user to keep updated on garage pool changes

    Return Value:
    <Bool> succeded

    Scope: Server
    Environment: Any
    Public: [No]
    Dependencies:

    Example: [clientOwner] remoteExecCall ["HR_GRG_fnc_addUser",2];

    License: MIT License
*/
#include "defines.inc"
params ["_client"];
if !(isServer) exitWith {false};
if (isNil "_client") exitWith {false};
if !(_client isEqualType 0) exitWith {false};
if (isNil "HR_GRG_Users") then {HR_GRG_Users = []};
Trace_1("Adding user: %1", _client);
HR_GRG_Users pushBack _client;
_client publicVariableClient "HR_GRG_Vehicles";
true
