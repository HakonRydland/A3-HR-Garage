/*
    Author: [Håkon]
    [Description]
        Handels opening the garage
        setting up controls and EH for the garage to function

        Note: Should only be called from display onLoad EH

    Arguments:
        <Nil>

    Return Value:
        <Nil>

    Scope: Clients
    Environment: Any
    Public: [No]
    Dependencies:

    Example: [] call HR_Garage_fnc_onLoad;

    License: APL-ND
*/
#include "defines.inc"
FIX_LINE_NUMBERS()
['HR_Garage','Loading Garage, please wait...'] call BIS_fnc_startLoadingScreen;
Trace("Opening Garage");

//if for some reason the server init has not been done, do it now
if (isNil "HR_Garage_Init") then {remoteExecCall ["HR_Garage_fnc_initServer",2]};
waitUntil {!isNil "HR_Garage_Init"};

//dont allow opening when placing a vehicle
if (isNil "HR_Garage_Placing") then { HR_Garage_Placing = false };
if (HR_Garage_Placing) exitWith { closeDialog 2 };
[] call HR_Garage_onOpenEvent;

//define general global variables used by garage
private _disp = findDisplay HR_Garage_IDD_Garage;
HR_Garage_PlayerUID = getPlayerUID player;
HR_Garage_SelectedVehicles = [-1, -1, ""];
HR_Garage_SelectedChanged = false;
HR_Garage_previewVeh = objNull;
HR_Garage_Mounts = [];
HR_Garage_usedCapacity = 0;
HR_Garage_LockedSeats = 0;
HR_Garage_ReloadMounts = false;
HR_Garage_curTexture = [];
HR_Garage_Pylons = [];
HR_Garage_UpdatePylons = false;

//preview cam
HR_Garage_previewCam = "camera" camCreate [10,0,100000];
HR_Garage_previewCam enableSimulation false;
HR_Garage_previewCam cameraEffect ["Internal", "Back"];
showCinemaBorder false;
enableEnvironment false; //wind sound
HR_Garage_previewCam camCommit 0;
HR_Garage_camDist = 1.3;
HR_Garage_camDirX = 30;
HR_Garage_camDirY = 10;

//light source
HR_Garage_previewLight = "#lightpoint" createVehicleLocal [10,0,100000];
HR_Garage_previewLight setLightBrightness 1.1 * HR_Garage_camDist;
HR_Garage_previewLight setLightAmbient [1, 1, 1];
HR_Garage_previewLight setLightColor [1, 1, 1];
HR_Garage_previewLight setLightDayLight false;//only at night
HR_Garage_previewLight lightAttachObject [HR_Garage_previewCam, [0,0,0]];

//preview cam rotation events
HR_Garage_RMouseBtnDown = false;
_disp displayAddEventHandler ["MouseButtonDown", "if ((_this#1) isEqualTo 1) then {HR_Garage_RMouseBtnDown = true};"];
_disp displayAddEventHandler ["MouseButtonUp", "if ((_this#1) isEqualTo 1) then {HR_Garage_RMouseBtnDown = false};"];
_disp displayAddEventHandler ["MouseMoving", "if (HR_Garage_RMouseBtnDown) then {_this call HR_Garage_fnc_updateCamPos};"];
_disp displayAddEventHandler ["MouseZChanged","if !(HR_Garage_RMouseBtnDown) exitWith {}; HR_Garage_camDist = 0.9 max (HR_Garage_camDist - (_this#1)*0.1) min 2; [nil,0,0] call HR_Garage_fnc_updateCamPos; HR_Garage_previewLight setLightBrightness 1.1 * HR_Garage_camDist;"];

//add veh pool modified EH
"HR_Garage_Event" addPublicVariableEventHandler {
    if (isNil "HR_Garage_Vehicles") exitWith {};
    (_this#1) call HR_Garage_fnc_reciveBroadcast;
};
"HR_Garage_Vehicles" addPublicVariableEventHandler {
    private _disp = findDisplay HR_Garage_IDD_Garage;
    private _index = HR_Garage_Cats findIf {ctrlShown _x};
    private _ctrl = HR_Garage_Cats#_index;
    [_ctrl, _index] call HR_Garage_fnc_reloadCategory;
};
//add player to broadcast recipient list
[clientOwner] remoteExecCall ["HR_Garage_fnc_addUser", 2]; //add to recipient
waitUntil {!isNil "HR_Garage_Vehicles"};//wait for server response

//define list of controls coresponding with list index
HR_Garage_Cats = [HR_Garage_IDC_CatCar,HR_Garage_IDC_CatArmored,HR_Garage_IDC_CatAir,HR_Garage_IDC_CatBoat,HR_Garage_IDC_CatStatic] apply {_disp displayCtrl _x};
{
    _x ctrlShow false;
    _x ctrlEnable false;
} forEach HR_Garage_Cats;
[0] call HR_Garage_fnc_switchCategory;

if !(call HR_Garage_Cnd_canAccessAir) then {
    private _airBttn = _disp displayCtrl HR_Garage_IDC_BttnAir;
    _airBttn ctrlEnable false;
    _airBttn ctrlSetTextColor [0.7,0,0,1];
    _airBttn ctrlSetTooltip localize "STR_HR_Garage_Generic_AirDisabled";
};

//extras list init
if (
    !HR_Garage_Pylons_Enabled //Pylon editing disabled
    || {!HR_Garage_hasAmmoSource} //or ammo source not registered
) then {
    private _pylonBttn = _disp displayCtrl HR_Garage_IDC_BttnPylons;
    _pylonBttn ctrlEnable false;
    _pylonBttn ctrlSetTextColor [0.7,0,0,1];
    _pylonBttn ctrlSetTooltip localize (["STR_HR_Garage_Generic_PylonDisabled", "STR_HR_Garage_Generic_PylonLackingSource"] select HR_Garage_Pylons_Enabled);
};
[false] call HR_Garage_fnc_reloadExtras;

//hide all extras menus and info panel
{
    _ctrl = _disp displayCtrl _x;
    _ctrl ctrlEnable false;
    _ctrl ctrlShow false;
} forEach [HR_Garage_IDC_ExtraMounts,HR_Garage_IDC_ExtraTexture,HR_Garage_IDC_ExtraAnim,HR_Garage_IDC_ExtraPylonsContainer];
[0] call HR_Garage_fnc_switchExtrasMenu;
[] call HR_Garage_fnc_reloadPylons;


HR_Garage_EachFrame = addMissionEventHandler ["EachFrame", {
    if (call HR_Garage_CP_closeCnd) exitWith {closeDialog 2};
    if (HR_Garage_UpdatePylons) then { [] call HR_Garage_fnc_UpdatePylons };
}];

//keyBind hints
_keyBindCtrl = _disp displayCtrl HR_Garage_IDC_KeyBindHint;
_keyBindText = composeText [
    image cameraIcon,"",localize "STR_HR_Garage_Feedback_Cam_Controls", lineBreak
    ,"    ",image moveIcon,"",localize "STR_HR_Garage_Feedback_Cam_Rotate",lineBreak
    ,"    ",image zoomIcon,"",localize "STR_HR_Garage_Feedback_Cam_Zoom"
];
_keyBindCtrl ctrlSetStructuredText _keyBindText;

'HR_Garage' call BIS_fnc_endLoadingScreen;
