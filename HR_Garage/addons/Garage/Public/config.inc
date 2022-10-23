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

//proxy function to gather similar code for access condition functions
HR_Garage_Cnd_canAccessX = {
    //sanity checking
    if (isNil "HR_Garage_accessPoint" || {isNull HR_Garage_accessPoint}) then {
        HR_Garage_accessPoint = (HR_Garage_accessPoints inAreaArray [getPos player, 25,25])#0;
    };
    if (isNil "HR_Garage_accessPoint") exitWith {false};

    // bool and number flag safe
    private _tmp = (HR_Garage_accessPoint getVariable QGVAR(ModuleArguments)) getOrDefault [_this, 0];
    if (_tmp isEqualType 0) exitwith {_tmp>0};
    _tmp;
};
HR_Garage_Cnd_canAccessAir = { "accessAir" call HR_Garage_Cnd_canAccessX };
HR_Garage_Cnd_canAccessNaval = { "accessNaval" call HR_Garage_Cnd_canAccessX };
HR_Garage_Cnd_canAccessArmor = { "accessArmor" call HR_Garage_Cnd_canAccessX };

FUNC(getBlackListCamo) = { (HR_Garage_accessPoint getVariable QGVAR(ModuleArguments)) getOrDefault ["blackListCamo", [
        "IDAP", "African Desert Extremists", "African Desert Extremists 01", "African Desert Extremists 02"
        ,"African Desert Extremists Alt", "Middle East Extremists", "Middle East Extremists Alt",
        "Middle East Extremists 1", "Middle East Extremists 2","Middle East Extremists 3", "Middle East Extremists 4",
        "Middle East Extremists 5", "Middle East Extremists 6"
    ]];
};

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
    { _x addCuratorEditableObjects [[_this],false] } forEach allCurators; //add vehicle to zeus
}; //is passed vehicle as _this
HR_Garage_onOpenEvent = {};
HR_Garage_onCloseEvent = {};
