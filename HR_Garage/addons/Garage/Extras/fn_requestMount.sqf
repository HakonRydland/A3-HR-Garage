/*
    Author: [Håkon]
    [Description]
        Request reservation/release of a type of static from the server

    Arguments:
    0. <Control> ExtrasMounts control from EH

    Return Value:
    <nil>

    Scope: Clients
    Environment: Any
    Public: [No]
    Dependencies:

    Example: _this call HR_Garage_fnc_requestMount;

    License: APL-ND
*/
#include "defines.inc"
FIX_LINE_NUMBERS()
params ["_ctrl"];
private _index = lbCurSel _ctrl;
_ctrl lbSetCurSel -1;
if (_index isEqualTo -1) exitWith {};

private _newIconIndex = checkboxTextures findIf { !( _x isEqualTo (_ctrl lbPicture _index) ) };

//check if can load static
private _class = _ctrl lbData _index;
private _vehUID = _ctrl lbValue _index;
private _nodes = if (_newIconIndex isEqualTo 1) then { //load static
    private _static = _class createVehicleLocal [0,0,41764];
    _static enableSimulation false;
    _static allowDamage false;
    _nodes = [HR_Garage_previewVeh, _static] call HR_fnc_logistics_canLoad;
    deleteVehicle _static;
    _nodes;
} else { [] }; //unload static
if (_nodes isEqualType 0) exitWith { ["STR_HR_Garage_Feedback_requestMount_Denied"] call HR_Garage_fnc_Hint };

HR_Garage_ReloadMounts = true;
[false] call HR_Garage_fnc_toggleConfirmBttn;
[HR_Garage_PlayerUID, _vehUID, _newIconIndex, clientOwner, player] remoteExecCall ["HR_Garage_fnc_findMount",2];
