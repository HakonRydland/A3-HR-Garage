/*
    Author: [Håkon]
    [Description]
        Updates registred pylon loadout and aplies it to the preview vehicle

    Arguments:
    0. <nil>

    Return Value:
    <nil>

    Scope: Clients
    Environment: Any
    Public: [No]
    Dependencies:

    Example: [] call HR_Garage_fnc_updatePylons;

    License: APL-ND
*/
HR_Garage_UpdatePylons = false;
#include "defines.inc"
FIX_LINE_NUMBERS()
Trace("Updating equiped pylons");
//update data
private _pylonLoudout = [];
{
    _x params ["_combo", "_mirrorIndex", "_button", "_comboIndex"];
    private _data = _combo lbData lbCurSel _combo;
    _pylonLoudout pushBack [_forEachIndex + 1, _data, false, _button getVariable ["HR_Garage_turret", []] ];
} forEach HR_Garage_PylonData;
HR_Garage_Pylons = _pylonLoudout;
Trace_1("Pylon Loadout: %1", HR_Garage_Pylons);
[controlNull, -1, true] call HR_Garage_fnc_PylonsPresetChanged;

//update preview pylon loudout
{
    _x params ["_pylonIndex", "_mag", "_forced", "_turret"];
    HR_Garage_previewVeh setPylonLoadout [_pylonIndex, _mag, _forced, _turret];
} forEach HR_Garage_Pylons;
