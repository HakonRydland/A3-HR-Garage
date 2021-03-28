/*
    Author: [Håkon]
    [Description]
        Adds garage access to a object

    Arguments:
    0. <Object> Object to access the garage from

    Return Value:
    <Bool> Action added

    Scope: Clients
    Environment: Any
    Public: [Yes]
    Dependencies:

    Example: [_object] call HR_GRG_fnc_initGarage;

    License: Håkon Rydland Garage SHARED SOURCE LICENSE
*/
params [ ["_object", objNull, [objNull]] ];
if (isNull _object) exitWith {false};
private _oldID = _object getVariable ["HR_GRG_GarageID", -1];
_object removeAction _oldID;

private _id = _object addAction [
    localize "STR_HR_GRG_openGarage_Action"
    , "
        HR_GRG_AccessPoint = _this#0;
        createDialog 'HR_GRG_VehicleSelect';
    ", nil, 1.5, true, true, ""
    , "(isNil {HR_GRG_Placing}) || {!HR_GRG_Placing}", 6
];
_object setVariable ["HR_GRG_GarageID", _id, true];
true;
