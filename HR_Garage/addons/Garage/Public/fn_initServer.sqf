/*
    Author: [Håkon]
    [Description]
        initilizes the garage on the server

    Arguments:
    0. <nil>

    Return Value:
    <>

    Scope: Server
    Environment: unscheduled
    Public: [Yes]
    Dependencies:

    Example: [] call HR_Garage_fnc_initServer;

    License: APL-ND
*/

//init stuff on client and server
#include "defines.inc"
#include "config.inc"
FIX_LINE_NUMBERS()
call HR_fnc_detector;

//only server
if (!isServer) exitWith {};

Trace("Running server init");
if (!isNil "HR_Garage_Init") exitWith {};//init already run.

if (isNil "HR_Garage_Vehicles") then {[] call HR_Garage_fnc_loadSaveData};
if (isNil "HR_Garage_Users") then {HR_Garage_Users = []};
[] call HR_Garage_fnc_validateGarage;

//Handle improper exit of garage (crash)
addMissionEventHandler ["PlayerDisconnected", {
    private _owner = param [4, -1];
    if (_owner isNotEqualTo -1) then {
        private _UID = param [1,""];
        [_owner] call HR_Garage_fnc_removeUser;

        private _recipients = +HR_Garage_Users;
        _recipients pushBackUnique 2;
        [_UID] remoteExecCall ["HR_Garage_fnc_releaseAllVehicles",_recipients];
    };
}];

//mark init complete
HR_Garage_Init = true;
publicVariable "HR_Garage_Init";
