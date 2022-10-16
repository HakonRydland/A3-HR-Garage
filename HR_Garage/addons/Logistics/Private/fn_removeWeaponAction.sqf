/*
    Author: [Håkon]
    [Description]
        Removes action and related EH's of mounted weapons

    Arguments:
    0. <Object> Vehicle the weapon is/was mounted on
    1. <Object> Weapon that is/was mounted on the vehicle

    Return Value:
    <Nil>

    Scope: Clients
    Environment: Any
    Public: [No]
    Dependencies:

    Example: [_vehicle, _cargo] remoteExecCall ["HR_Garage_Logistics_fnc_removeWeaponAction",0];
*/
params ["_vehicle", "_cargo"];

//Remove action
private _id = _cargo getVariable ["getInAction", -1];
_cargo setVariable ["getInAction", nil];
remoteExecCall ["", _cargo]; //clear JIP addAction
_vehicle removeAction _id;

//remove weapon killed EH
private _killedEH = _cargo getVariable ["KilledEH", -1];
_cargo removeEventHandler ["Killed", _killedEH];
_cargo setVariable ["KilledEH", nil];

//remove GetOut EH
private _GetOutEH = _cargo getVariable ["GetOutEH", -1];
_cargo removeEventHandler ["GetOut", _GetOutEH];
_cargo setVariable ["GetOutEH", nil];

//remove Undercover break if last weapon
private _attachedObjects =  attachedObjects _vehicle;
private _weaponCount = _attachedObjects findIf {
    !isNull ( [_x] call HR_Garage_Logistics_fnc_getCargoConfig )
};
if (_weaponCount isEqualTo -1) then {
    private _undercoverBreak = _vehicle getVariable ["undercoverBreak", -1];
    _vehicle removeEventHandler ["GetIn", _undercoverBreak];
    _vehicle setVariable ["undercoverBreak", nil];
};
