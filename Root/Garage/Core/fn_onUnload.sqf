/*
    Author: [Håkon]
    [Description]
        Handles the closing of the garage interface

        Note: Should only be called from display onUnload EH

    Arguments:
    0. <nil>

    Return Value:
    <nil>

    Scope: Clients
    Environment: Any
    Public: [No]
    Dependencies:

    Example: [] call HR_GRG_fnc_onUnload

    License: Håkon Rydland Garage SHARED SOURCE LICENSE
*/
#include "defines.inc"
FIX_LINE_NUMBERS()
Trace("Closing Garage");
[clientOwner] remoteExecCall ["HR_GRG_fnc_removeUser",2];
"HR_GRG_Event" addPublicVariableEventHandler {};
"HR_GRG_Vehicles" addPublicVariableEventHandler {};
HR_GRG_SelectedVehicles = [-1, -1, ''];
removeMissionEventHandler ["EachFrame", HR_GRG_EachFrame];

//destroy light source
lightDetachObject HR_GRG_previewLight;
deleteVehicle HR_GRG_previewLight;

//destroy preview camera
HR_GRG_previewCam cameraEffect ["terminate","back"];
camDestroy HR_GRG_previewCam;

//delete previw vehicle
if (!isNull HR_GRG_previewVeh) then {
    { detach _x; deleteVehicle _x } forEach (attachedObjects HR_GRG_previewVeh);
    deleteVehicle HR_GRG_previewVeh;
};

//only do bellow if we are not attemting to place vehicle
if (HR_GRG_Placing) exitWith {};

//remove check out
private _fnc = "HR_GRG_fnc_releaseAllVehicles";
private _code = {
    params ["_client", "_UID", "_fnc"];
    private _recipients = +HR_GRG_Users;
    _recipients pushBackUnique 2;
    _recipients pushBackUnique _client;
    [_UID] remoteExecCall [_fnc,_recipients];
};
HR_GRG_AccessPoint = objNull;
[[clientOwner, getPlayerUID player, _fnc], _code] remoteExecCall ["call", 2]; //run code on server as HR_GRG_Users is maintained ONLY on the server
