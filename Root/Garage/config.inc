/*
    Author: [Håkon]
    [Description]
        This is the config file for the garage, everything that is meant to be adjustable can be changed here.

    Arguments:

    Return Value:

    Scope: Server
    Environment: Any
    Public: [No]
    Dependencies:

    Example:

    License: MIT License
*/
if (isNil "HR_GRG_Prefix") then {HR_GRG_Prefix = "A3A-Event"; publicVariable "HR_GRG_Prefix"};
//Overwrite client
if (isNil "HR_GRG_cmdClient") then { HR_GRG_cmdClient = {
    if ((isServer && hasInterface) || {admin owner _this > 0}) then {_this} else {objnull}; //LAN Host or admin on DS or commander
} };

//side declaration
if (isNil "TeamPlayer") then {TeamPlayer = independent; publicVariable "TeamPlayer"};
if (isNil "nameTeamPlayer") then {nameTeamPlayer = "Rebel"; publicVariable "nameTeamPlayer"};
if (isNil "Invaders") then {Invaders = sideEnemy; publicVariable "Invaders"};
if (isNil "Occupants") then {Occupants = sideEnemy; publicVariable "Occupants"};

//ace detection
if (isNil "HR_GRG_hasAce") then {HR_GRG_hasAce = (!isNil "ace_common_fnc_isModLoaded"); publicVariable "HR_GRG_hasAce"};

//condition to automatically close garage/placement as if canceled
if (isNil "HR_GRG_CP_closeCnd") then { HR_GRG_CP_closeCnd = {
    (!([player] call HR_fnc_canFight))
    || {(!isNull HR_GRG_AccessPoint)
        && {player distance HR_GRG_AccessPoint > 50}
    }
}; publicVariable "HR_GRG_CP_closeCnd"};

if (isNil "HR_GRG_Cnd_canAccessAir") then { HR_GRG_Cnd_canAccessAir = {
    true
}; publicVariable "HR_GRG_Cnd_canAccessAir"};

//in valid are to garage vehicles
if (isNil "HR_GRG_inValidArea") then {HR_GRG_inValidArea = {
    private _nearObjects = (player nearObjects 50) select { !isNil {_x getVariable "HR_GRG_GarageID"} };
    _nearObjects findIf { _x distance player < 50 } > -1;
}; publicVariable "HR_GRG_inValidArea"};

//Lock on garaged vehicles ( Values: [{""}, { getPlayerUID player }] )
if (isNil "HR_GRG_dLock") then { HR_GRG_dLock = {""}; publicVariable "HR_GRG_dLock" };

//garage pool cap
if (isNil "HR_GRG_PoolBase") then { HR_GRG_PoolBase = 10; publicVariable "HR_GRG_PoolBase"; };
if (isNil "HR_GRG_PoolIncr") then { HR_GRG_PoolIncr = 2; publicVariable "HR_GRG_PoolIncr" };
if (isNil "HR_GRG_VehCap") then { HR_GRG_VehCap = { HR_GRG_PoolBase + warTier * HR_GRG_PoolIncr }; publicVariable "HR_GRG_VehCap" };

//Pylon config
if (isNil "HR_GRG_Pylons_Enabled") then { HR_GRG_Pylons_Enabled = true; publicVariable "HR_GRG_Pylons_Enabled" };

//camo blacklist (display name, case sensitive)
if (isNil "HR_GRG_blackListCamo") then {HR_GRG_blackListCamo = []; publicVariable "HR_GRG_blackListCamo"};

//proxies
if (isNil "HR_GRG_fnc_Log") then {HR_GRG_fnc_Log = { [2,_this, "HR Garage"] call HR_fnc_log }; publicVariable "HR_GRG_fnc_Log"};
if (isNil "HR_GRG_fnc_Hint") then {HR_GRG_fnc_Hint = { hint (_this#0) }; publicVariable "HR_GRG_fnc_Hint"};
if (isNil "HR_GRG_fnc_vehInit") then { HR_GRG_fnc_vehInit = {
    private _nodeType = [_this] call HR_fnc_logistics_getCargoNodeType;
    if (_nodeType > -1) then { [_this] call HR_fnc_logistics_addLoadAction }
}; publicVariable "HR_GRG_fnc_vehInit" }; //is passed vehicle as _this

//CBA settings
if (isClass (configfile >> "CBA_Extended_EventHandlers")) then {

    ["HR_GRG_dLock", "CHECKBOX", ["Lock on garage", "Lock vehicles when garaged"], [HR_GRG_Prefix,"Garage"], (HR_GRG_dLock isEqualTo {getPlayerUID player}), false, {
        HR_GRG_dLock = [{""}, { getPlayerUID player }] select _this;
    }] remoteExecCall ["CBA_fnc_addSetting",0,true];

    ["HR_GRG_Pylons_Enabled", "CHECKBOX", ["Allow pylon editing", "Allows player to configure pylons in the garage"], [HR_GRG_Prefix,"Garage"], true, true, {
        HR_GRG_Pylons_Enabled = _this;
    }] remoteExecCall ["CBA_fnc_addSetting",0,true];

    ["HR_GRG_PoolBase", "SLIDER", ["Base Capacity", "Garage base capacity"], [HR_GRG_Prefix,"Garage"], [0, 50, HR_GRG_PoolBase, 0], true, {
        HR_GRG_PoolBase = round _this;
        HR_GRG_VehCap = { HR_GRG_PoolBase + warTier * HR_GRG_PoolIncr };
    }] remoteExecCall ["CBA_fnc_addSetting",0,true];

    ["HR_GRG_PoolIncr", "SLIDER", ["Capacity increase", "Capacity increase per war level"], [HR_GRG_Prefix,"Garage"], [0, 10, HR_GRG_PoolIncr, 0], true, {
        HR_GRG_PoolIncr = round _this;
        HR_GRG_VehCap = { HR_GRG_PoolBase + warTier * HR_GRG_PoolIncr };
    }] remoteExecCall ["CBA_fnc_addSetting",0,true];

};
