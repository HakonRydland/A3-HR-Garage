/*
    Author: [Håkon]
    Description:
        Checks if vehicle is a fuel source, ace compatible

    Arguments:
    0. <Object> Vehicle your checking if is source

    Return Value:
    <Bool> is fuel source

    Scope: Any
    Environment: Any
    Public: Yes
    Dependencies: <Bool>HR_GRG_hasAce

    Example: [_veh] call HR_GRG_fnc_isFuelSource;

    License: MIT License
*/
params [ ["_vehicle", objNull, [objNull]] ];
if (isNull _vehicle) exitWith {false};

if (HR_GRG_hasAce) then { //Ace
    private _vehCfg = configFile >> "CfgVehicles" >> typeOf _vehicle;
    _vehicle getVariable ["ace_refuel_currentFuelCargo", getNumber (_vehCfg >> "ace_refuel_fuelCargo")] > 0;
} else { //Vanilla
    getFuelCargo _vehicle > 0
};
