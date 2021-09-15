/*
    Author: [Håkon]
    [Description]
        Handles client selection change attempt

    Arguments:
    0. <Control> Control to try and change selection of

    Return Value:
    <nil>

    Scope: Clients
    Environment: Any
    Public: [No]
    Dependencies:

    Example: _this call HR_Garage_fnc_selectionChange;

    License: APL-ND
*/
#include "defines.inc"
FIX_LINE_NUMBERS()//temp for trace
params ["_ctrl"];
private _curSel = lbCurSel _ctrl;
if (_curSel isEqualTo -1) exitWith {};

private _newVehUID = _ctrl lbValue _curSel;
private _newCat = HR_Garage_Cats find _ctrl;
_ctrl lbSetCurSel -1;

private _cat = HR_Garage_SelectedVehicles#0;
if (_cat != -1) then {
    (HR_Garage_Cats#_cat) lbSetCurSel -1;
};
HR_Garage_SelectedChanged = true;
[false] call HR_Garage_fnc_toggleConfirmBttn;

[HR_Garage_PlayerUID, _newCat, _newVehUID, player, clientOwner] remoteExecCall ["HR_Garage_fnc_requestSelectionChange",2];
