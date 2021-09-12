params [
    ["_object", objNull, [objNull]]
    , ["_jipKey", "", [""]]
];

if (!alive _object) exitWith {
    remoteExecCall ["", _jipKey];
};

if (([typeOf _object] call HR_GRG_fnc_getCatIndex) isEqualTo -1) exitWith {};

private _oldID = _object getVariable ["HR_GRG_GarageVehicleAction", -1];
_object removeAction _oldID;

private _id = _object addAction [
    format [localize "STR_HR_GRG_addVehicle_action", getText ((configOf _object)/"displayName")]
    , "[_this#0, clientOwner, call HR_GRG_dLock, _this#1] remoteExecCall ['HR_GRG_fnc_addVehicle',2];"
    , nil, -10, true, true, ""
    , "!isNil {HR_GRG_accessPoints} && {
        ((isNil {HR_GRG_Placing}) || {!HR_GRG_Placing})
        && player isEqualTo vehicle player
        && {(HR_GRG_accessPoints inAreaArray [getPos _originalTarget, 25,25,0,false,25]) isNotEqualTo []}
        && {(HR_GRG_accessPoints inAreaArray [getPos _this, 25,25,0,false,25]) isNotEqualTo []}
    }", 10
];
_object setVariable ["HR_GRG_GarageVehicleAction", _id];
