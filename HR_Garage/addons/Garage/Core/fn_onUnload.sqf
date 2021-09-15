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

    Example: [] call HR_Garage_fnc_onUnload

    License: APL-ND
*/
#include "defines.inc"
FIX_LINE_NUMBERS()
Trace("Closing Garage");

[] call HR_Garage_onCloseEvent;

[clientOwner] remoteExecCall ["HR_Garage_fnc_removeUser",2];
"HR_Garage_Event" addPublicVariableEventHandler {};
"HR_Garage_Vehicles" addPublicVariableEventHandler {};
HR_Garage_SelectedVehicles = [-1, -1, ''];
removeMissionEventHandler ["EachFrame", HR_Garage_EachFrame];

//destroy light source
lightDetachObject HR_Garage_previewLight;
deleteVehicle HR_Garage_previewLight;

//destroy preview camera
enableEnvironment true;
HR_Garage_previewCam cameraEffect ["terminate","back"];
camDestroy HR_Garage_previewCam;

//delete previw vehicle
if (!isNull HR_Garage_previewVeh) then {
    { detach _x; deleteVehicle _x } forEach (attachedObjects HR_Garage_previewVeh);
    deleteVehicle HR_Garage_previewVeh;
};

//only do bellow if we are not attemting to place vehicle
if (HR_Garage_Placing) exitWith {};

//remove check out
[clientOwner, player, "HR_Garage_fnc_releaseAllVehicles"] remoteExecCall ["HR_Garage_fnc_execForGarageUsers", 2]; //run code on server as HR_Garage_Users is maintained ONLY on the server
HR_Garage_accessPoint = objNull;
