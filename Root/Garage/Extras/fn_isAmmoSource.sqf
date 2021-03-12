/*
    Author: [Håkon]
    Description:
        Checks if vehicle is a ammo source, ace compatible

    Arguments:
    0. <Object> Vehicle your checking if is source

    Return Value:
    <Bool> is ammo source

    Scope: Any
    Environment: Any
    Public: Yes
    Dependencies: <Bool>HR_GRG_hasAce

    Example: [_veh] call HR_GRG_fnc_isAmmoSource;

    License: MIT License
*/
params [ ["_vehicle", objNull, [objNull]] ];
if (isNull _vehicle) exitWith {false};

if (HR_GRG_hasAce) then { //Ace
    private _aceCurrent = _vehicle getVariable ["ace_rearm_currentSupply", 0];
    if (_aceCurrent < 0) exitWith {false};

    private _vehCfg = configFile >> "CfgVehicles" >> typeOf _vehicle;
    private _ammoCap = getNumber (_vehCfg >> "transportAmmo");
    private _aceDefault = getNumber (_vehCfg >> "ace_rearm_defaultSupply");
    private _aceIsSupply = _vehicle getVariable ["ace_rearm_isSupplyVehicle", false];
    (_aceDefault > 0) || {_aceIsSupply} || {_ammoCap > 0}
} else { //Vanilla
    getAmmoCargo _vehicle > 0
};
