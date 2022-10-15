/*
    Author: [Håkon]
    [Description]
        Rebuilds the extras lists base on local garage pool data

    Arguments:
    0. <String> Selected vehicle class

    Return Value:
    <nil>

    Scope: Clients
    Environment: Any
    Public: [No]
    Dependencies: HR_hasAce

    Example: [true] call HR_Garage_fnc_reloadExtras;

    License: APL-ND
*/
#include "defines.inc"
FIX_LINE_NUMBERS()
params [["_reloadMounts", false, [true]]];
private _class = HR_Garage_SelectedVehicles param [2, "", [""]];
Trace("Reloading Extras");
//Mounts
private _disp = findDisplay HR_Garage_IDD_Garage;
private _ctrl = _disp displayCtrl HR_Garage_IDC_ExtraMounts;
lbClear _ctrl;
private _vehConfig = [HR_Garage_previewVeh] call EFUNC(Logistics,getNodeConfig);
private _capacity = [HR_Garage_previewVeh] call EFUNC(Logistics,getVehCapacity);
private _vehModel = ((getText (configFile/"CfgVehicles"/_class/"model")) splitString "\.") joinString "_";
if (!isNull _vehConfig) then {
    {
        _y params ["_displayName", "_staticClass", "_lockedUID", "_checkedOut"];

        private _block =false;
        if !(_lockedUID in ["", HR_Garage_PlayerUID]) then {_block = true};
        if !(_checkedOut in ["", HR_Garage_PlayerUID]) then {_block = true};
        if !(isClass (configFile >> "CfgVehicles" >> _class)) then {_block = true};

        //check if its loadable
        private _cargoConfig = [_staticClass] call EFUNC(Logistics,getCargoConfig);
        private _size = if (isNull _cargoConfig) then {-1} else { getNumber (_cargoConfig/"size") };

        //is weapon allowed
        private _allowed = if (getNumber (_vehConfig/"canLoadWeapon") == 0) then { false } else {
            private _blackList = getArray (_cargoConfig/"blackList");
            !(
                _vehModel in _blackList
                || _class in _blackList
            )
            };

        //add entry
        if ( (_allowed) && (_size != -1) && (_capacity >= _size) && !_block) then { //static is loadable and vehicle can fit it
            private _index = _ctrl lbAdd _displayName;
            _ctrl lbSetData [_index, _staticClass];
            _ctrl lbSetValue [_index, _x];
            _ctrl lbsetpicture [_index,checkboxTextures select (_checkedOut isEqualTo HR_Garage_PlayerUID)];
            _ctrl lbSetTextRight [_index, format ["Size: %1", _size]];
            Trace_4("Mount Added to list | Class: %1 | UID: %2 | Checked: %3 | Size: %4", _staticClass, _x, (_checkedOut isEqualTo HR_Garage_PlayerUID), _type);
        };
    } forEach (HR_Garage_Vehicles#4);//statics
    lbSort _ctrl;
};
if (_reloadMounts) then { [] call HR_Garage_fnc_reloadMounts };

private _customisation = [HR_Garage_previewVeh] call BIS_fnc_getVehicleCustomization;
//textures
HR_Garage_curTexture = _customisation#0;
private _badInit = HR_Garage_curTexture isEqualTo [];
private _ctrl = _disp displayCtrl HR_Garage_IDC_ExtraTexture;
lbClear _ctrl;
{
    private _displayName = getText (_x >> "displayName");
    private _cfgName = configname _x;
    if (_displayName != "" && {!(_displayName in HR_Garage_blackListCamo)}) then {
        private _index = _ctrl lbAdd _displayName;
        _ctrl lbsetdata [_index,_cfgName];
        if (_badInit) then {
            _ctrl lbsetpicture [_index,checkboxTextures#0];
        } else {
            _ctrl lbsetpicture [_index,checkboxTextures select ((HR_Garage_curTexture#0) isEqualTo _cfgName)];
        };
    };
} foreach (configProperties [(configfile >> "CfgVehicles" >> _class >> "textureSources"),"isclass _x",true]);
lbSort _ctrl;

//animations
private _ctrl = _disp displayCtrl HR_Garage_IDC_ExtraAnim;
lbClear _ctrl;
{
    _configName = configname _x;
    _displayName = getText (_x >> "displayName");
    if (_displayName != "") then {
        _textures = getArray (_x >> "textures");
        _index = _ctrl lbAdd _displayName;
        _ctrl lbSetData [_index,_configName];
        private _phase = ceil (HR_Garage_PreviewVeh animationPhase _configName);
        _ctrl lbSetPicture [_index,checkboxTextures#_phase];
    };
} foreach (configProperties [(configfile >> "CfgVehicles" >> _class >> "animationSources"),"isclass _x",true]);
lbSort _ctrl;

HR_Garage_curAnims = _customisation#1;
[HR_Garage_previewVeh, HR_Garage_curTexture, HR_Garage_curAnims] call BIS_fnc_initVehicle;

//update source panel
private _ctrl = _disp displayCtrl HR_Garage_IDC_SourcePanelAmmo;
_ctrl ctrlSetStructuredText composeText ["   ", image RearmIcon, " ", image (checkboxTextures select (HR_Garage_hasAmmoSource && !HR_Garage_ServiceDisabled_Rearm))];
_ctrl ctrlSetTooltip ([
    localize "STR_HR_Garage_SourcePanel_toolTip_Ammo_Unavailable"
    , localize "STR_HR_Garage_SourcePanel_toolTip_Ammo_Available"
    , localize "STR_HR_Garage_SourcePanel_toolTip_Ammo_Disabled"
] select (if (HR_Garage_ServiceDisabled_Rearm) then {2} else {HR_Garage_hasAmmoSource}));

private _ctrl = _disp displayCtrl HR_Garage_IDC_SourcePanelFuel;
_ctrl ctrlSetStructuredText composeText ["   ", image RefuelIcon, " ", image (checkboxTextures select (HR_Garage_hasFuelSource && !HR_Garage_ServiceDisabled_Refuel))];
_ctrl ctrlSetTooltip ([
    localize "STR_HR_Garage_SourcePanel_toolTip_Fuel_Unavailable"
    , localize "STR_HR_Garage_SourcePanel_toolTip_Fuel_Available"
    , localize "STR_HR_Garage_SourcePanel_toolTip_Fuel_Disabled"
] select (if (HR_Garage_ServiceDisabled_Refuel) then {2} else {HR_Garage_hasFuelSource}));

private _ctrl = _disp displayCtrl HR_Garage_IDC_SourcePanelRepair;
_ctrl ctrlSetStructuredText composeText ["   ", image RepairIcon, " ", image (checkboxTextures select (HR_Garage_hasRepairSource && !HR_Garage_ServiceDisabled_Repair))];
_ctrl ctrlSetTooltip ([
    localize "STR_HR_Garage_SourcePanel_toolTip_Repair_Unavailable"
    , localize "STR_HR_Garage_SourcePanel_toolTip_Repair_Available"
    , localize "STR_HR_Garage_SourcePanel_toolTip_Repair_Disabled"
] select (if (HR_Garage_ServiceDisabled_Repair) then {2} else {HR_Garage_hasRepairSource}));

if (isNull HR_Garage_previewVeh) exitWith {};
//update info panel
private _ctrl = _disp displayCtrl HR_Garage_IDC_InfoPanel;
private _spacer = composeText [lineBreak, lineBreak];
private _topBar = composeText [
    image cfgIcon(_class), " ", cfgDispName(_class)
];

//is source
private _source = [
    [HR_Garage_previewVeh] call HR_Garage_fnc_isAmmoSource
    ,[HR_Garage_previewVeh] call HR_Garage_fnc_isFuelSource
    ,[HR_Garage_previewVeh] call HR_Garage_fnc_isRepairSource
];
private _typeSource = switch (_source find true) do {
    case 0: {localize "STR_HR_Garage_InfoPanel_isAmmoSource"};
    case 1: {localize "STR_HR_Garage_InfoPanel_isFuelSource"};
    case 2: {localize "STR_HR_Garage_InfoPanel_isRepairSource"};
    default {localize "STR_HR_Garage_InfoPanel_isNotSource"};
};


//state indicator
private _getPercentageAmmo = {
    if (count _this isEqualTo 0) exitWith {0};
    private _sumPercent = 0;
    private _weaponsWithAmmo = 0;
    {
        (if (_x#0) then { //pylon
            [_x#1#3, _x#1#4]
        } else { //muzzle
            [_x#1#0,_x#1#2]
        }) params ["_mag", "_count"];

        private _maxAmmo = getNumber (configFile/"CfgMagazines"/_mag/"count");
        if (_maxAmmo <= 0) then { continue };
        _sumPercent = _sumPercent + (_count/_maxAmmo);
        _weaponsWithAmmo = _weaponsWithAmmo + 1;
    } forEach _this;
    if (_weaponsWithAmmo > 0) then { _sumPercent / _weaponsWithAmmo } else { 1 };
};

private _hasAmmo = (HR_Garage_previewVehState#2) isNotEqualTo [];//Preview state >> Ammo data
private _avgAmmo = (HR_Garage_previewVehState#2) call _getPercentageAmmo; //Preview state >> Ammo data
private _avgFuel = HR_Garage_previewVehState#0#0; //Preview state >> Fuel data >> Fuel
private _avgDmg = 1 - (HR_Garage_previewVehState#1#0); //Preview state >> Damage data >> Damage
private _selectStateColor = {
    switch true do {
        case (_this > 0.5): {"#ffffff"}; // white
        case (_this > 0.25): {"#edc80e"}; // yellow
        default            {"#e00202"}; // red
    };
};

private _vehAmmoState = composeText [image RearmIcon, " " + (if (_hasAmmo) then {str round (_avgAmmo * 100) + " %"} else {"-"})];
private _vehFuelState = composeText [image RefuelIcon, " " + str round (_avgFuel * 100) + " %"];
private _vehDmgState = composeText [image RepairIcon, " " + str round (_avgDmg * 100) + " %"];

private _vehicleState = composeText [
    _vehAmmoState setAttributes ["color", (if (_hasAmmo) then {_avgAmmo} else {1}) call _selectStateColor]
    , "    "
    , _vehFuelState setAttributes ["color", _avgFuel call _selectStateColor]
    , "    "
    , _vehDmgState setAttributes ["color", _avgDmg call _selectStateColor]
] setAttributes ["align", "center"];

// update remainingfuel from sources available for refueling
private _availableFuel = call HR_Garage_fnc_getTotalFuelCargo;
private _maxFuel = getNumber ( configOf HR_Garage_previewVeh / (if (HR_hasACE) then {"ace_refuel_fuelCapacity"} else {"fuelCapacity"}) );
private _requiredFuel = _maxFuel - (fuel HR_Garage_previewVeh * _maxFuel);
private _refuelHintText = if (_requiredFuel < _availableFuel) then {
    localize "STR_HR_Garage_Refuel_fullRefuel" + " " + str _requiredFuel + "L"
} else {
    if (_availableFuel > 0) then {
        (localize "STR_HR_Garage_Refuel_partialRefuel") + " " + str((_maxFuel - _requiredFuel) + (_availableFuel/_maxFuel*100)) + "% "
    } else {
        localize "STR_HR_Garage_Refuel_noRefuel"
    }
};
private _refuelInfo = composeText [_refuelHintText, lineBreak, localize "STR_HR_Garage_Refuel_factionFuel", " ", [_availableFuel, "L"] call HR_Garage_fnc_prefix];

//Crew
private _fullCrew = fullCrew [HR_Garage_previewVeh, "", true];
private _driver = [];
private _gunner = [];
private _commander = [];
private _cargo = [];
{
    _return = call {
        if ((_x#2) > -1) exitWith {0};
        if ((_x#1) isEqualTo "driver") exitWith {1};
        if ((_x#1) isEqualTo "commander") exitWith {2};
        3
    };
    switch _return do {
        case 0: {_cargo pushBack _x};
        case 1: {_driver pushBack _x};
        case 2: {_commander pushBack _x};
        case 3: {_gunner pushBack _x};
    };
} forEach _fullCrew;
private _countCargo = count _cargo;
private _totalSeats = count _fullCrew;
private _seatsInfo = composeText [
    localize "STR_HR_Garage_InfoPanel_Seats"," ", str (_totalSeats - HR_Garage_LockedSeats), "/", str _totalSeats, lineBreak, "    ",
    image DriverIcon, ": ", str count _driver, "    "
    ,image GunnerIcon, ": ", str count _gunner, "    "
    ,image CommanderIcon, ": ", str count _commander, "    "
    ,image CargoIcon, ": ", str (_countCargo - HR_Garage_LockedSeats), "/", str _countCargo
];

//Cargo
private _nodes = HR_Garage_previewVeh getVariable [QEGVAR(Logistics,Nodes),nil];
if (isNil "_nodes") then {
    _nodes = [HR_Garage_previewVeh] call EFUNC(Logistics,getVehicleNodes);
    HR_Garage_previewVeh setVariable [QEGVAR(Logistics,Nodes), _nodes];
};
if (_nodes isEqualType 0) then {_nodes = []};
private _cargoCapacity = count _nodes;
private _availableCapacity = _cargoCapacity - HR_Garage_usedCapacity;
private _aceCargo = if (HR_hasAce) then {
    composeText [lineBreak, "    ", localize "STR_HR_Garage_InfoPanel_AceCargo"," ", str cfgAceCargo(_class)]
} else {""};

private _cargoInfo = composeText [
    image VehCargoIcon, localize "STR_HR_Garage_InfoPanel_Cargo", lineBreak, "    "
    ,localize "STR_HR_Garage_InfoPanel_Capacity"," ", str _cargoCapacity,  lineBreak, "    "
    ,localize "STR_HR_Garage_InfoPanel_Available"," ", str _availableCapacity
    ,_aceCargo
];

//general
private _topSpeed = cfgMaxSpeed(_class);
private _horsePower = cfgEnginePower(_class);
private _mass = HR_Garage_previewVeh getVariable ["default_mass", getMass HR_Garage_previewVeh];
{ _mass = _mass + getMass _x } forEach attachedObjects HR_Garage_previewVeh; //the only thing attached is mounts
_generalInfo = composeText [
    image SpeedIcon," ", localize "STR_HR_Garage_InfoPanel_Speed"," ", str _topSpeed, lineBreak
    ,image MassIcon," ",localize "STR_HR_Garage_InfoPanel_Mass"," ", str _mass
];

_ctrl ctrlSetStructuredText composeText [_topBar, lineBreak, _typeSource, _spacer, "Vehicle state:", lineBreak, _vehicleState,lineBreak,_refuelInfo, _spacer, _seatsInfo, _spacer, _cargoInfo, _spacer, _generalInfo];
