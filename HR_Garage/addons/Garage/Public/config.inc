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

// Condition for whether the player can override garage locks
HR_Garage_isCmdClient = {
    (isServer && hasInterface && _this isEqualTo player) //Lan host
    || {admin owner _this > 0} //admin
};

//condition to automatically close garage/placement as if canceled
HR_Garage_CP_closeCnd = {
    (!([player] call HR_fnc_canFight))
    || {(!isNull HR_Garage_accessPoint)
        && {player distance HR_Garage_accessPoint > 25}
    }
};

HR_Garage_Cnd_canAccessAir = { true };

//Lock on garaged vehicles ( Values: [{""}, { getPlayerUID player }] )
HR_Garage_dLock = {""};

HR_Garage_renderPlacementRays = false;

//garage pool cap
if (isNil "HR_Garage_PoolBase") then { HR_Garage_PoolBase = 10 }; //can be overwritten by CBA settings
if (isNil "HR_Garage_PoolIncr") then { HR_Garage_PoolIncr = 2 }; //can be overwritten by CBA settings
HR_Garage_VehCap = { (HR_Garage_PoolBase * HR_Garage_PoolIncr) min HR_Garage_PoolBase };

//Pylon config
if (isNil "HR_Garage_Pylons_Enabled") then { HR_Garage_Pylons_Enabled = true }; //can be overwritten by CBA settings
if (isNil "HR_Garage_ServiceDisabled_Rearm") then {HR_Garage_ServiceDisabled_Rearm = false};
if (isNil "HR_Garage_ServiceDisabled_Refuel") then {HR_Garage_ServiceDisabled_Refuel = false};
if (isNil "HR_Garage_ServiceDisabled_Repair") then {HR_Garage_ServiceDisabled_Repair = false};

//camo blacklist (display name, case sensitive)
HR_Garage_blackListCamo = ["IDAP", "African Desert Extremists", "African Desert Extremists 01", "African Desert Extremists 02",
"African Desert Extremists Alt", "Middle East Extremists", "Middle East Extremists Alt", "Middle East Extremists 1", "Middle East Extremists 2",
"Middle East Extremists 3", "Middle East Extremists 4", "Middle East Extremists 5", "Middle East Extremists 6"];
//proxies
HR_Garage_fnc_Hint = {
    params ["_key", ["_arguments", []]];
    hintSilent (if (_arguments isEqualTo []) then {localize _key} else {format ( [localize _key] + _arguments )});
};
HR_Garage_fnc_vehInit = {
    { _x addCuratorEditableObjects [_this,false] } forEach allCurators; //add vehicle to zeus
}; //is passed vehicle as _this
HR_Garage_onOpenEvent = {};
HR_Garage_onCloseEvent = {};
