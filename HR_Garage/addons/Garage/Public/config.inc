/*
    Author: [Håkon]
    [Description]
        This is the config file for the garage, everything that is meant to be adjustable can be changed here.

    Arguments:

    Return Value:

    Scope: Any
    Environment: Any
    Public: [No]
    Dependencies:

    Example:

    License: MIT
*/
HR_Garage_Prefix = "HR Garage";
//Overwrite client
HR_Garage_cmdClient = {
    if ((isServer && hasInterface) || {admin owner _this > 0}) then {_this} else {objNull}; //LAN Host or admin on DS or commander
};

//condition to automatically close garage/placement as if canceled
HR_Garage_CP_closeCnd = {
    (!([player] call HR_fnc_canFight))
    || {(!isNull HR_Garage_accessPoint)
        && {player distance HR_Garage_accessPoint > 25}
    }
};

HR_Garage_Cnd_canAccessAir = {
    true
};

//Lock on garaged vehicles ( Values: [{""}, { getPlayerUID player }] )
HR_Garage_dLock = {""};

//garage pool cap
if (isNil "HR_Garage_PoolBase") then { HR_Garage_PoolBase = 10 }; //can be overwritten by CBA settings
if (isNil "HR_Garage_PoolIncr") then { HR_Garage_PoolIncr = 2 }; //can be overwritten by CBA settings
HR_Garage_VehCap = { HR_Garage_PoolBase * HR_Garage_PoolIncr max HR_Garage_PoolBase };

//Pylon config
if (isNil "HR_Garage_Pylons_Enabled") then { HR_Garage_Pylons_Enabled = true }; //can be overwritten by CBA settings
if (isNil "HR_Garage_ServiceBehaviour_Rearm") then {HR_Garage_ServiceBehaviour_Rearm = 0};
if (isNil "HR_Garage_ServiceBehaviour_Refuel") then {HR_Garage_ServiceBehaviour_Refuel = 0};
if (isNil "HR_Garage_ServiceBehaviour_Repair") then {HR_Garage_ServiceBehaviour_Repair = 0};

//camo blacklist (display name, case sensitive)
HR_Garage_blackListCamo = ["IDAP", "African Desert Extremists", "African Desert Extremists 01", "African Desert Extremists 02", "African Desert Extremists Alt"];
//proxies
HR_Garage_fnc_Hint = {
    params ["_key", ["_arguments", []]];
    hintSilent (if (_arguments isEqualTo []) then {localize _key} else {format ( [localize _key] + _arguments )});
};
HR_Garage_fnc_vehInit = {}; //is passed vehicle as _this
HR_Garage_onOpenEvent = {};
HR_Garage_onCloseEvent = {};
