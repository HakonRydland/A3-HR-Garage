/*
    Author: [Håkon]
    [Description]
        Toggles the buttons Confirm and [Un]Lock on/off

    Arguments:
    0. <Bool> Enable controls

    Return Value:
    <nil>

    Scope: Clients
    Environment: Any
    Public: [No]
    Dependencies:

    Example: [false] call HR_Garage_fnc_toggleConfirmBttn;

    License: APL-ND
*/
#include "defines.inc"
FIX_LINE_NUMBERS()
params ["_enable"];

private _disp = findDisplay HR_Garage_IDD_Garage;
private _ctrlCnfrm = _disp displayCtrl HR_Garage_IDC_Confirm;
private _ctrlLock = _disp displayCtrl HR_Garage_IDC_tLock;

_ctrlCnfrm ctrlEnable _enable;
_ctrlLock ctrlEnable _enable;
